// Calidad general
process MULTIQC {
  conda "bioconda::multiqc=1.33"

  input:
    val stage
    path qc_files

  publishDir "${params.outdir}/multiqc_${stage}", mode: 'copy'

  output:
    path "multiqc_report.html"

  script:
    """
    multiqc ${qc_files} -o .
    """
}
