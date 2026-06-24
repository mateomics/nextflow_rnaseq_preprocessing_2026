#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// Módulos

include { FASTQC as FASTQC_RAW } from './fastqc.nf'
include { FASTQC as FASTQC_CLEAN } from './fastqc.nf'
include { PARSE_QC } from './parse_fastqc.nf'
include { FASTP } from './fastp.nf'
include { MULTIQC as MULTIQC_RAW } from './multiqc.nf'
include { MULTIQC as MULTIQC_CLEAN } from './multiqc.nf'

// Parámetros

// Input y output con valores por defecto
params.input = params.input ?: "./data/raw/*.fastq.gz"
params.outdir = params.outdir ?: "./results/nextflow"


// Workflow

workflow {
  // Canal de entrada --> PE o SE dinámicamente
  // Tupla (sample id, reads) --> Agrupado por sample id
  reads = Channel
    .fromPath(params.input, checkIfExists: true)
    .map { file ->
      def sample = file.baseName.replaceAll(/_[12]$/, "")
      tuple(sample, file)
    }
    .groupTuple()

  // FastQC inicial
  qc_raw = FASTQC_RAW("raw", reads)

  // MultiQC --> Recolecta todos los .zip de FastQC
  multiqc_raw = MULTIQC_RAW(
    "raw",
    qc_raw.zip.map { it[1] }.collect()
  )

  // Parseo de métricas → parámetros dinámicos
  parsed = PARSE_QC(qc_raw.zip, file("./src/parse_fastqc.py"))

  // Asociar params con cada muestra
  reads_with_params = reads.join(parsed)

  // Limpieza con fastp
  trimmed = FASTP(reads_with_params)

  // FastQC final
  qc_clean = FASTQC_CLEAN("clean", trimmed.reads)

  // MultiQC final
  multiqc_clean = MULTIQC_CLEAN(
    "clean",
    qc_clean.zip.map { it[1] }.collect()
  )
}

