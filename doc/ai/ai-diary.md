# AI diary

## 2026-10-25 — Input file check in Trim Galore script

- **Asked for:** a check that both input FASTQ files exist in `scripts/trimgalore.sh`,
  exiting with an informative error if not
- **Changed:** `scripts/trimgalore.sh`; created this diary (`doc/ai/ai-diary.md`)
- **Decisions:** loop over both files with `[[ -f ]]`, print the missing path to stderr, `exit 1`;
  placed before any other output so it fails fast.
  Left the other review issues (oras URL, `mkdir -p`, logging, naming) for later, as not requested
- **Tested:** `bash -n` passes; nonexistent inputs give the error and exit code 1
