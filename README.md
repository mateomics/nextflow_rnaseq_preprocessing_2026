# Nextflow RNA-seq Preprocessing Pipeline

## Overview

This repository contains a modular Nextflow workflow for RNA-seq preprocessing and quality control.

The pipeline automates quality assessment, adapter trimming, and report generation for both paired-end (PE) and single-end (SE) sequencing datasets.

The workflow was designed to demonstrate reproducible bioinformatics practices using workflow management systems.

---

## Pipeline

```text
FASTQ
   ↓
FastQC (raw reads)
   ↓
fastp
   ↓
FastQC (clean reads)
   ↓
MultiQC
```

---

## Features

* Support for paired-end RNA-seq data
* Support for single-end RNA-seq data
* Automated FastQC execution
* Adapter and quality trimming using fastp
* MultiQC report aggregation
* Modular Nextflow implementation
* Reproducible execution

---

## Repository Structure

```text
.
├── scripts/
│   ├── fastqc.nf
│   ├── fastp.nf
│   ├── multiqc.nf
│   ├── parse_fastqc.nf
│   └── nextflow_QC_cleaning.nf
│
├── data/
│   └── images/
│
├── results/
│
├── logs/
│
├── nextflow_pipeline.qmd
├── nextflow_pipeline.pdf
└── README.md
```

---

## Workflow Components

### FastQC

Performs initial quality assessment of raw sequencing reads.

Metrics evaluated include:

* Per-base sequence quality
* Adapter contamination
* Sequence duplication
* GC content
* Overrepresented sequences

### fastp

Read-cleaning stage:

* Adapter removal
* Quality filtering
* Trimming of low-quality bases
* Generation of HTML and JSON reports

### FastQC (Post-cleaning)

Quality control after preprocessing to evaluate improvements introduced by fastp.

### MultiQC

Aggregates all FastQC and fastp reports into a single interactive report.

---

## Execution

Example:

```bash
nextflow run scripts/nextflow_QC_cleaning.nf
```

---

## Example Outputs

The repository includes:

* FastQC reports for raw reads
* FastQC reports for cleaned reads
* fastp HTML reports
* fastp JSON reports
* MultiQC summaries
* Representative QC figures

Example report snapshots are available under:

```text
data/images/
```

---

## Technologies

* Nextflow
* FastQC
* fastp
* MultiQC
* Bash

---

## Skills Demonstrated

* Workflow development
* Nextflow
* RNA-seq preprocessing
* Pipeline automation
* Reproducible bioinformatics
* Modular workflow design
* Quality control analysis
* HPC-oriented pipeline development

---

## Future Improvements

* Containerization with Docker/Singularity
* Parameterized configuration profiles
* HPC scheduler integration
* nf-core style modularization
* Automatic sample sheet parsing
