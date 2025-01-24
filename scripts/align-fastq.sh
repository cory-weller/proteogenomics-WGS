#!/usr/bin/env bash
#SBATCH --mem 120G
#SBATCH --nodes 1
#SBATCH --tasks 1
#SBATCH --cpus-per-task 24
#SBATCH --time 40:00:00
#SBATCH --gres lscratch:300

threads=22

module load samtools/1.16.1
module load bwa-mem2

# SAMPLE=436
GITDIR=$(realpath .)
SAMPLE=${SLURM_ARRAY_TASK_ID}
DATADIR='/data/CARD_proteomics/Psomagen/AN00022036'
READ1="${DATADIR}/${SAMPLE}_1.fastq.gz"
READ2="${DATADIR}/${SAMPLE}_2.fastq.gz"
OUTBAM="${SAMPLE}-hg38.bam"


# Work in lscratch
TMPDIR="/lscratch/${SLURM_JOB_ID}"
cd "${TMPDIR}" || exit 1



# map reads to chr6 reference for xHLA genotyping
bwa-mem2 mem -t ${threads} \
    /fdb/bwa-mem2/hg38/genome.fa \
${READ1} \
${READ2} | \
samtools view -b - | sambamba sort -t ${threads} -o ${OUTBAM} /dev/stdin && \
sambamba index ${OUTBAM}


cp ${OUTBAM} ${DATADIR}/hg38_BAMS
cp ${OUTBAM}.bai ${DATADIR}/hg38_BAMS

