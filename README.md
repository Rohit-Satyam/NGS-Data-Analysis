# NGS-Data-Analysis
# Introduction

This repository tries to enlist the best practices for NGS Data Analysis in general. It's also sequential arrangements of Best Practices of updated version of GATK 4.1.4.0 and on how to start with NGS Data analysis.

**Starters**
1. Basics on NGS: [Understanding the Basics of NGS: From Mechanism to Variant Calling](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4633438/pdf/40142_2015_Article_76.pdf)
2. Illumina Sequencing Technology: [Intro](https://www.youtube.com/watch?v=womKfikWlxM) , [sequencing by synthesis](https://www.youtube.com/watch?v=fCd6B5HRaZ8&t=38s)
3. Eric Chow [explanation](https://www.youtube.com/watch?v=kN8B7-Vhqww)  behind the chemistry behind Illumina sequencers
4. An interesting TED talk to get you excited: [How to read the genome and build a human being | Riccardo Sabatini](https://www.youtube.com/watch?v=s6rJLXq1Re0)
5. Various NGS Platforms [here](https://www.youtube.com/watch?v=jFCD8Q6qSTM)

**System Preparation**
To make your life easy read my System Preparation Section before embarking upon the analysis part.

**All about HPC**
1. Start [here](https://github.com/hbctraining/In-depth-NGS-Data-Analysis-Course/raw/master/sessionI/slides/HPC_intro_O2_09042018.pdf)
2. 


**Learn Linux** 
1. Source 1: [Here](https://hbctraining.github.io/Intro-to-Shell/lessons/01_the_filesystem.html)
2. Source 2: 

## **Quality Check**

Tool used: [Fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) 
**Relevant Literature:** 
1. Sequencing Quality Issues: [Base-calling for next-generation sequencing platforms](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3178052/pdf/bbq077.pdf)
2. QC Faulire: In case if your data quality fails, look [here](https://sequencing.qcfail.com/software/fastqc/)

paired-end sequencing is designed so that there is no overlap between forward and reverse reads. It is not done in order to read the same sequence in two directions. Having overlap data is less useful than having two unique reads that are a known distance apart.


## Duplicates in FastQC report (A general Account)

According to FastQC [manual](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/8%20Duplicate%20Sequences.html), the duplicates are marked as follows:

> To cut down on the memory requirements for this module **only sequences which first appear in the first 100,000 sequences in each file are analysed**, but this should be enough to get a good impression for the duplication levels in the whole file. Each sequence is tracked to the end of the file to give a representative count of the overall duplication level. To cut down on the amount of information in the final plot any sequences with more than 10 duplicates are placed into grouped bins to give a clear impression of the overall duplication level without having to show each individual duplication value.
Because the duplication detection requires an exact sequence match over the whole length of the sequence, any reads over 75bp in length are truncated to 50bp for the purposes of this analysis. Even so, longer reads are more likely to contain sequencing errors which will artificially increase the observed diversity and will tend to underrepresent highly duplicated sequences.

In short remember

> When looking at duplicate sequence plots remember that they are based on an **exact match between sequences.** Any **sequencing errors** in the library will tend to **create artificial diversity in the library** – making identical sequences look different because of technical errors. To mitigate against this effect in long reads **only the first 50bp of each sequence are used to assess the duplication level –** however if the sequence quality in a library is very poor then the duplication plot for a heavily duplicated library might be made to look perfectly normal due to the introduced errors. You should therefore always consider the results of the sequence quality plots (especially the per-base quality plot) alongside the duplication plot to gain a realistic assessment of the true level of duplication ([Source](https://proteo.me.uk/2011/05/interpreting-the-duplicate-sequence-plot-in-fastqc/)).
> The newer version of fastqc however shows a better estimate than the older one. Read [here](http://proteo.me.uk/2013/09/a-new-way-to-look-at-duplication-in-fastqc-v0-11/) and [here](https://www.biostars.org/p/107402/). 

In duplication plot the percentage mentioned at the top is ****what percentage of the library would remain if you deduplicated (remove duplicates) it to keep only one copy of every different sequence i.e**.
`distinct sequences = number of singletons (sequences that appear only once) + number of doubles (number of sequences that appear twice but each double will be counted only once) + number of triplets (sequences that appear three times but each will be counted once) ... and so on.`

The percentage in **the title** is computed as the  `distinct/total * 100`**
The Y intercept marked is marked as follows: -  eg. if we have total 20 Reads: 10 unique reads (singletones) + 5 reads each present twice (duplicates). Total distict reads=10+1=15. 

```mermaid
graph LR
A[15 distinct reads] -- Percent singletons--> B(10 Singletons/15 distinct=66%)
A --Percent duplicates--> C(5 duplicates/15 distinct reads=33%)
```
In short if you are looking at fastqc plot of (Chip-Seq/RNA-seq/WGS) don't freak out if you have duplicates. The true duplicates can be identified only after alignment of reads with the reference, followed by markduplicates (Picard). 

Related Literature: 
