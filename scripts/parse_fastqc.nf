// Parseo de resultados de FastQC --> Parámetros de fastp
process PARSE_QC {
  conda "conda-forge::python=3.9"
  input:
    tuple val(sample_id), path(qc_zip)
    path parse_script

  output:
    tuple val(sample_id), path("${sample_id}.params.txt"), emit: params

  // Script auxiliar de python para parámetros dinámicos
  script:
    """
    python ${parse_script} ${qc_zip} > \
    ${sample_id}.params.txt
    """
}
