#!/bin/bash

# Script to download data

# Example code: bash get_data.sh SRR519926 1000

# GNU Parallel: parallel bash get_data.sh {} 1000 :::: runids.txt

# Stop program right away if error.
set -uex

# Define the SRR run id.
SRR=$1

# Define the data size.
#LIMIT=$2
#${LIMIT}

# Data dump of SRR files into reads directory.
fastq-dump --split-files ${SRR}

# Analyze downloaded SRA data for corruption and other problems
vdb-validate *.fastq

# If directory is not made make dir QC
DIR=QC
if [ -d $DIR ]; then
  echo "Dir $DIR exists."
else
  mkdir QC
  echo "Dir $DIR now exists."
fi;


# trim_galore and fastqc
# Paired End
# if paired end do this program
trim_galore ${SRR}_1.fastq ${SRR}_2.fastq  --paired --fastqc

# Single End
# if single end do this program

# Move .txt .html .zip
mv *report.txt QC
mv *.zip QC
mv *.html QC

# List all .fq files in .txt file
ls *.fq > fq_files.txt
