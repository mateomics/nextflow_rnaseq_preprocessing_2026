// FastQC
process FASTQC {
  conda "bioconda::fastqc=0.12.1"

  input:
    val stage
    // Agrupar por muestra
    tuple val(sample_id), path(reads)

  // Mode copy para no mover los archivos originales
  publishDir "${params.outdir}/fastqc_${stage}", mode: 'copy'

  output:
    tuple val(sample_id), path("*.zip"), emit: zip

  script:
    // FastQC a todas las reads, separadas por espacio
    """
    fastqc -t 4 ${reads.join(' ')}
    """
}
