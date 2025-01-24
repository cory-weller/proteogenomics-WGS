# proteogenomics-WGS

Whole genome genotyping using deepvariant on Biowulf


## Data setup
- Sequencing reads (`.fastq.gz` files) symlinked in the `00_FASTQ` directory.
- Three-column `samples.tsv` created in main directory, containing columns for `ID`, `READ1` and `READ2`. No header is included. The paths for the reads can be either absolute or relative to this project directory.


## Alignment
`00_FASTQ` `->` `01_BAM`

