# Download reference genome.

# Stop on errors.
set -uex

# Make refs directory.
mkdir refs

# Downloaded data from nuccore.
efetch -db=nuccore -format=fasta -id=AF086833 > refs/reference.fa

# Run BWA on downloaded data.
bwa index refs/reference.fa

# Index the reference genome for IGV.
samtools faidx $REF

# Generate perfect coverage.
cat refs/reference.fa | python perfect_coverage.py
