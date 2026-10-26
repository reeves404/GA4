<!--
GA4 README template.
- Add your answers to each question's section below.
- For each question where we want you to add your commands,
  put the command(s) you ran in the terminal in the corresponding ```bash code block.
- Where we want to see a command's output, there is a plain ``` code block
  right below the command block: paste the output there.
- You don't need to paste the contents of your scripts into this file:
  we will look at the scripts in your `scripts` dir directly
  (so make sure you commit them!).
- Delete instructional comments like this one as you go.
-->

# GA4 answers - <your-name>

------------------------------------------------------------------------

## Part A: Your project dir and Git repo

### 1: Create subdirs, and copy `CLAUDE.md` and a FastQC report

<!-- No command/output needed. -->

### 2: Initialize a Git repository, and commit your first files

<!-- No command/output needed here -- we check the repo directly. -->

------------------------------------------------------------------------

## Part B: A TrimGalore script --- without genAI

<!-- Reminder: no genAI in this Part! -->

### 3: A TrimGalore container, its help info, and three options

*Answer*: The container link (URI) is: docker://community.wave.seqera.io/library/trim-galore:2.3.0--2b255ff43100a747

Code to run `trim_galore --help` with the container:

```bash
# Your command:  apptainer exec 'docker://community.wave.seqera.io/library/trim-galore:2.3.0--2b255ff43100a747' trim_galore --help 
```

<!-- You don't need to paste the TrimGalore help output -->

*Answer*: The option to indicate that the reads are paired-end: 
--paired

*Answer*: The option to set the output dir:
--outdir
*Answer*: The option to run FastQC on the trimmed FASTQ files:
--fastqc
### 4: Default thresholds

*Answer*: A) The default base quality score threshold:
20
*Answer*: B) The default read length threshold:
20
### 5: Write the `trimgalore.sh` script

<!-- No need to paste the script: we'll look at scripts/trimgalore.sh directly. -->

### 6: Run the script for sample `S63`, and check the output files

Code to run the script:

```bash
# Your command: bash scripts/trimgalore.sh ../garrigos/fastq/S63_R1.fastq.gz ../garrigos/fastq/S63_R2.fastq.gz results/trimgalore
```

<!-- You don't need to paste the TrimGalore logging output -->

Code to list the output files:

```bash
# Your command: ls results/trimgalore
```

The output of the command was:

```
S63_R1.fastq.gz_trimming_report.json  S63_R1_val_1.fq.gz                    S63_R2_val_2_fastqc.zip
S63_R1.fastq.gz_trimming_report.txt   S63_R2.fastq.gz_trimming_report.json  S63_R2_val_2.fq.gz
S63_R1_val_1_fastqc.html              S63_R2.fastq.gz_trimming_report.txt
S63_R1_val_1_fastqc.zip               S63_R2_val_2_fastqc.html
```

*Answer*: What each type of output file contains: trimmed reads and then summaries 

<!-- If your script failed at first: describe the problem and your fix here. -->

### 7: Trimming results

*Answer*: Which adapter sequence TrimGalore looked for, and how it decided on this: AGATCGGAAGAGC; Type: regular 3'; Length: 13; Trimmed: 50357 times 

*Answer*: Percentage of reads with adapters in R1 and R2: 13 and 10.1

*Answer*: In R1 and R2, were more bases removed by quality trimming or by adapter trimming? 1,274,150 / 85,527 and 1,283,793 / 60,540

*Answer*: Percentage of read pairs that were removed: 7.4

### 8: Poly-G trimming

*Answer*: Did TrimGalore do poly-G trimming, and did you have to tell it to? Yes, I dont recall telling it to

*Answer*: What TrimGalore concludes about the sequencing technology: consistent with a sequencer using two-colour chemistry

*Answer*: Was more poly-G trimming done in R1 or R2? (Optional: any idea why?) R2

### 9: Compare the FastQC reports before and after trimming

*Answer*: At least two differences between the reports,
and whether things look better in terms of pass/warn/fail status:
reads decreased that 7% and bases were trimemd. per base N now passes , overrepresented too
*Answer*: Were the short reads with only `N`s removed?
If so, was that due to the length threshold, or something else?
no longer listed as overrepresented. might have removed their low quality bases making them too short to keep
*Answer*: Something you didn't expect or are confused about:
if im reading correctly per base still fails 
------------------------------------------------------------------------

## Part C: Bring in genAI

<!-- Export the conversations for questions 10, 11, 13, and 14 to `doc/ai`. -->

### 10: Sonnet reviews your script

*Answer*: Your prompt: Review this shell script. List 5 most important problems or improvements, most important first with a one sentence reason for each. Do not change it yet

*Answer*: Claude's suggestions, and for each, whether you agree, disagree,
or don't understand it, and why:
No mkdir -p "$out_dir" — if the output dir doesn't exist, Trim Galore will fail; CLAUDE.md requires creating output dirs before writing.

It does exist but sure

Uses docker:// instead of oras:// — project convention is to pull containers via Seqera's oras:// URLs, not Docker Hub references.

I'm unsure what oras is 

Variable naming inconsistent with convention — R1_FASTQ/R2_FASTQ are uppercase but are copied arguments, not constants; should be lowercase per CLAUDE.md.

It should be uniform this is fair 

Missing required header/reporting — no purpose/usage comment block, no date/inputs reported at start, and no program version/success message/date reported at end.

Script seems simple enough that its not necessary but yes agreed

No multi-threading flags used (good), but also no -j/thread guard needed — minor: could instead flag that --fastqc runs an extra FastQC pass that duplicates a separate results/fastqc step if one exists, worth confirming it's not redundant.

This just seems beyond my current comprehension 

*Answer*: Was anything wrong, or in conflict with the course's practices?
Did Claude refer to your `CLAUDE.md` conventions?

There is extra stuff I dont believe we've really gone over but Id say no. I dont think it referred to claude.md

*Answer*: The estimated cost of this conversation (from `/usage`):

$0.1469

### 11: Opus reviews your script

*Answer*: The estimated cost of this conversation (from `/usage`):
$0.23
*Answer*: Which suggestions did only one of the two models make?
sonnet said multi threading flags and opus said no argument check 
*Answer*: Did either model claim something that you know is wrong?
I dont think so

*Answer*: Did either model check its claims, for example by running commands?
No

*Answer*: Did Opus's review change your mind about any of your answers to question 10?
No

*Answer*: How did the costs compare? Which review would you trust more, and why?
Was the difference worth the difference in cost?
Almost 10 cents more for opus. I suppose I'd trust opus more due to cost assuming its more complex but for something as simple as our script I'd say it isnt worth it

### 12: Run the script with a non-existent file

```bash
# Your command: bash scripts/trimgalore.sh clean_moon.txt swept_moon.html pull_broom.gz
```

The output of the command was:

```
Running Trim Galore on clean_moon.txt and swept_moon.html
INFO:    Using cached SIF image
INFO:    gocryptfs not found, will not be able to use gocryptfs
Error: Input file not found: clean_moon.txt
```

*Answer*: What happens, and at which point does the script stop?
It starts to run it but stops at the first argument as the file doesnt exist

### 13: Claude adds a check to your script

*Answer*: Your prompt: In scripts/trimgalore.sh, add a check that both input FASTQ files exist, and exit with an informative error message if they don’t.

```bash
# Your command to test the updated script: ash scripts/trimgalore.sh clean_moon.txt swept_moon.html pull_broom.gz 
```

The output of the command was:

```
ERROR: Input FASTQ file 'clean_moon.txt' does not exist
```

*Answer*: Does it behave the way Claude claimed it would?
Yes

*Answer*: Given what you saw in question 12, how useful is this check?
Doesn't seem that useful, it throws an error regardless

### 14: Claude writes a loop

*Answer*: Your prompt:
Write a for loop that runs scripts/trimgalore.sh for the 7 samples whose IDs start with S6, with output dir results/trimgalore. I will run the loop from the GA4 dir. Only show me the loop: don’t add it to a file, and don’t run it.

The loop that Claude wrote:
mkdir -p results/trimgalore

for R1 in ../garrigos/fastq/S6*_R1.fastq.gz; do
    R2=${R1/_R1/_R2}
    bash scripts/trimgalore.sh "$R1" "$R2" results/trimgalore
done

```bash
# Paste Claude's loop here: mkdir -p results/trimgalore

for R1 in ../garrigos/fastq/S6*_R1.fastq.gz; do
    R2=${R1/_R1/_R2}
    bash scripts/trimgalore.sh "$R1" "$R2" results/trimgalore
done
```

*Answer*: Does it run the script once per sample?
Yes
*Answer*: Does it get the correct R2 file for each R1 file?
Yes i believe so
*Answer*: Does it only run for the 7 `S6` samples?
Yes i believe it runs 63-69
*Answer*: Did you change the loop? If so, what did you change and why?
No

### 15: Test and run the loop

The loop with `echo`, to test it:

```bash
# Your loop:  mkdir -p results/trimgalore

for R1 in ../garrigos/fastq/S6*_R1.fastq.gz; do
    R2=${R1/_R1/_R2}
    echo bash scripts/trimgalore.sh "$R1" "$R2" results/trimgalore
done
```
```

The output of the loop was:

```
bash scripts/trimgalore.sh ../garrigos/fastq/S63_R1.fastq.gz ../garrigos/fastq/S63_R2.fastq.gz results/trimgalore
bash scripts/trimgalore.sh ../garrigos/fastq/S64_R1.fastq.gz ../garrigos/fastq/S64_R2.fastq.gz results/trimgalore
bash scripts/trimgalore.sh ../garrigos/fastq/S65_R1.fastq.gz ../garrigos/fastq/S65_R2.fastq.gz results/trimgalore
bash scripts/trimgalore.sh ../garrigos/fastq/S66_R1.fastq.gz ../garrigos/fastq/S66_R2.fastq.gz results/trimgalore
bash scripts/trimgalore.sh ../garrigos/fastq/S67_R1.fastq.gz ../garrigos/fastq/S67_R2.fastq.gz results/trimgalore
bash scripts/trimgalore.sh ../garrigos/fastq/S68_R1.fastq.gz ../garrigos/fastq/S68_R2.fastq.gz results/trimgalore
bash scripts/trimgalore.sh ../garrigos/fastq/S69_R1.fastq.gz ../garrigos/fastq/S69_R2.fastq.gz results/trimgalore
```

<!-- You don't need to paste the output of the loop that ran TrimGalore -->

```bash
# Your command(s) to check the output files:
``` 
ls results/trimgalore/

The output of the command(s) was:

```
S63_R1.fastq.gz_trimming_report.json  S65_R1_val_1.fq.gz                    S67_R2_val_2_fastqc.zip
S63_R1.fastq.gz_trimming_report.txt   S65_R2.fastq.gz_trimming_report.json  S67_R2_val_2.fq.gz
S63_R1_val_1_fastqc.html              S65_R2.fastq.gz_trimming_report.txt   S68_R1.fastq.gz_trimming_report.json
S63_R1_val_1_fastqc.zip               S65_R2_val_2_fastqc.html              S68_R1.fastq.gz_trimming_report.txt
S63_R1_val_1.fq.gz                    S65_R2_val_2_fastqc.zip               S68_R1_val_1_fastqc.html
S63_R2.fastq.gz_trimming_report.json  S65_R2_val_2.fq.gz                    S68_R1_val_1_fastqc.zip
S63_R2.fastq.gz_trimming_report.txt   S66_R1.fastq.gz_trimming_report.json  S68_R1_val_1.fq.gz
S63_R2_val_2_fastqc.html              S66_R1.fastq.gz_trimming_report.txt   S68_R2.fastq.gz_trimming_report.json
S63_R2_val_2_fastqc.zip               S66_R1_val_1_fastqc.html              S68_R2.fastq.gz_trimming_report.txt
S63_R2_val_2.fq.gz                    S66_R1_val_1_fastqc.zip               S68_R2_val_2_fastqc.html
S64_R1.fastq.gz_trimming_report.json  S66_R1_val_1.fq.gz                    S68_R2_val_2_fastqc.zip
S64_R1.fastq.gz_trimming_report.txt   S66_R2.fastq.gz_trimming_report.json  S68_R2_val_2.fq.gz
S64_R1_val_1_fastqc.html              S66_R2.fastq.gz_trimming_report.txt   S69_R1.fastq.gz_trimming_report.json
S64_R1_val_1_fastqc.zip               S66_R2_val_2_fastqc.html              S69_R1.fastq.gz_trimming_report.txt
S64_R1_val_1.fq.gz                    S66_R2_val_2_fastqc.zip               S69_R1_val_1_fastqc.html
S64_R2.fastq.gz_trimming_report.json  S66_R2_val_2.fq.gz                    S69_R1_val_1_fastqc.zip
S64_R2.fastq.gz_trimming_report.txt   S67_R1.fastq.gz_trimming_report.json  S69_R1_val_1.fq.gz
S64_R2_val_2_fastqc.html              S67_R1.fastq.gz_trimming_report.txt   S69_R2.fastq.gz_trimming_report.json
S64_R2_val_2_fastqc.zip               S67_R1_val_1_fastqc.html              S69_R2.fastq.gz_trimming_report.txt
S64_R2_val_2.fq.gz                    S67_R1_val_1_fastqc.zip               S69_R2_val_2_fastqc.html
S65_R1.fastq.gz_trimming_report.json  S67_R1_val_1.fq.gz                    S69_R2_val_2_fastqc.zip
S65_R1.fastq.gz_trimming_report.txt   S67_R2.fastq.gz_trimming_report.json  S69_R2_val_2.fq.gz
S65_R1_val_1_fastqc.html              S67_R2.fastq.gz_trimming_report.txt
S65_R1_val_1_fastqc.zip               S67_R2_val_2_fastqc.html
```

*Answer*: Are all 7 samples represented?
Yes , I believe so 

### 16: A summary command

*Answer*: Your prompt: Give me a simple command that prints, for each sample, the percentage of read pairs that TrimGalore removed, based on the output files in results/trimgalore. I’m a shell beginner, so only use basic commands like grep, cut, and for loops.

```bash
# The command you got from Claude:  for report in results/trimgalore/*_R2.fastq.gz_trimming_report.txt; do
    sample=$(basename "$report" | cut -d "_" -f 1)
    pct=$(grep "Number of sequence pairs removed" "$report" | cut -d "(" -f 2 | cut -d ")" -f 1)
    echo "$sample $pct"
done
```

The output of the command was:

```
S63 7.40%
S64 3.35%
S65 1.94%
S66 3.71%
S67 1.78%
S68 2.56%
S69 4.81%
```

*Answer*: Did the output look right? If not, what did you do?
Yes it looks correct

*Answer*: Does the value for `S63` match your answer to question 7?
Yes
*Answer*: In your own words, how does the command work?
the script reads each samples report, takes the samples name and and percent of read pairs and adds to the diary. 
### 17: Document your genAI use

<!-- No command/output needed here -- we check your `doc/ai` dir in the repo directly. -->

### 18: Update your `CLAUDE.md`

*Answer*: What you added to `CLAUDE.md`, and why:
I added for it to summarize the command. So i can reference back and try to understand the exact command or any keys it used
*Answer*: Did Claude follow the new instruction?
I'm unsure- it just says unauthorized now (randomly) and I've been trying for awhile with no change. 
### 19: Reflection

*Answer*: I think claude can be useful in some circumstances such as q16 in saving time but not all. Some of the code it ran seemed overly complicated and when you think about how much it cost per question it makes it hard to justify. Although, I think it enables people with little comprehension or skill to be able to do more, given it's good code. I didn't personally encounter anything wrong with the code or errors that put me behind luckily so I can't complain outside just not understanding everything it's doing and it giving me recommendations for my script that were just unneeded. I don't think the explanations were clear enough for me personally to understand but referencing something else can defintely help (I used google for a couple).

------------------------------------------------------------------------

## Part D: Publish your repo on GitHub

### 20: Create a GitHub repository, push, and create an Issue

<!-- No command/output needed here -- we check your GitHub repo directly. -->
