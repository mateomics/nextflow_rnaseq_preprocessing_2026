// Limpieza con fastp --> SE + PE
process FASTP {
  conda "bioconda::fastp=0.24.1"
  publishDir "${params.outdir}/trimmed", mode: 'copy'

  input:
    tuple val(sample_id), path(reads), path(param_file)

  output:
    tuple val(sample_id), path("*.trimmed.fastq.gz"), emit: reads
    path "${sample_id}.json", emit: json
    path "${sample_id}.html", emit: html

  script:
    // PE o SE según número de archivos asociados a la muestra
    def is_paired = reads.size() == 2

    def input_args = is_paired ?
      "-i ${reads[0]} -I ${reads[1]}" : "-i ${reads[0]}"

    def output_args = is_paired ?
      "-o ${sample_id}_1.trimmed.fastq.gz -O ${sample_id}_2.trimmed.fastq.gz" :
      "-o ${sample_id}.trimmed.fastq.gz"

    """
    fastp \
    ${input_args} \
    ${output_args} \
    \$(cat ${param_file}) \
    --thread 4 \
    --json ${sample_id}.json \
    --html ${sample_id}.html
    """
}
