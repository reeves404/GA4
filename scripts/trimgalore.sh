#!/bin/bash
set -euo pipefail

R1_FASTQ="$1"
R2_FASTQ="$2"
out_dir="$3"

for fastq in "$R1_FASTQ" "$R2_FASTQ"; do
  if [[ ! -f "$fastq" ]]; then
    echo "ERROR: Input FASTQ file '$fastq' does not exist" >&2
    exit 1
  fi
done

echo "Running Trim Galore on $R1_FASTQ and $R2_FASTQ"
apptainer exec \
  docker://community.wave.seqera.io/library/trim-galore:2.3.0--2b255ff43100a747 \
  trim_galore --paired --fastqc --output_dir \
"$out_dir" "$R1_FASTQ" "$R2_FASTQ"

