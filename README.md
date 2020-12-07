# NGS-Data-Analysis
# Introduction

This repository tries to enlist the best practices for NGS Data Analysis in general. It's also sequential arrangements of Best Practices of updated version of GATK 4.1.4.0 and on how to start with NGS Data analysis.

**Starters**
1. Basics on NGS: [Understanding the Basics of NGS: From Mechanism to Variant Calling](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4633438/pdf/40142_2015_Article_76.pdf)
2. Illumina Sequencing Technology: [Intro](https://www.youtube.com/watch?v=womKfikWlxM) , [sequencing by synthesis](https://www.youtube.com/watch?v=fCd6B5HRaZ8&t=38s)
3. Eric Chow [explanation](https://www.youtube.com/watch?v=kN8B7-Vhqww)  behind the chemistry behind Illumina sequencers
4. An interesting TED talk to get you excited: [How to read the genome and build a human being | Riccardo Sabatini](https://www.youtube.com/watch?v=s6rJLXq1Re0)
5. Various NGS Platforms [here](https://www.youtube.com/watch?v=jFCD8Q6qSTM)
6. Analysis pipelines for cancer genome sequencing in mice is a [Protocol](https://www.nature.com/articles/s41596-019-0234-7) with all the relevant command Published in 2020

**Which Genome to start with: Grch37 or Grch38**
1. [Genomic Analysis in the Age of Human Genome Sequencing](https://www.cell.com/cell/pdf/S0092-8674(19)30215-6.pdf)
2. [Improvements and impacts of GRCh38 human reference on highthroughput sequencing data analysis](https://reader.elsevier.com/reader/sd/pii/S0888754317300058?token=B5C78CB9E937FF3A9DF0D53979D9849E6ACA7B6D5BC28FF094C7E5128C8F4089635B13F0B6012A0E04686A908927459A)
3. [Get to Know Your Reference Genome (GRCh37 vs GRCh38)](https://bitesizebio.com/38335/get-to-know-your-reference-genome-grch37-vs-grch38/)
4. GATK Post: [Human genome reference builds - GRCh38/hg38 - b37 - hg19](https://gatkforums.broadinstitute.org/gatk/discussion/11010/human-genome-reference-builds-grch38-hg38-b37-hg19)
5. [GRCh37 / hg19 / b37 / humanG1Kv37 - Human Reference Discrepancies](https://software.broadinstitute.org/gatk/documentation/article?id=23390)
6. [Sequence masking](https://drive5.com/usearch/manual/masking.html)
7. [How to...choose a reference genome?](https://genestack.com/blog/2016/07/12/choosing-a-reference-genome/)
8. [Why Are There Ambiguous (N) Bases (Gaps) In The Human Genome](https://www.biostars.org/p/67068/)
9. Which human reference genome to use? [Heng Li's Blog](http://lh3.github.io/2017/11/13/which-human-reference-genome-to-use)

>The exome size increased significantly from GRCh37's 75,231,228 to GRCh38’s 95,505,476 by **20,274,248 nucleotides, a 26.9.0% increase**.(Source No. 2)...... Percentage wise, 2.43% of GRCh37 is exome as compared to 3.09% of CRCh38. The increase in exome size can be attributed to several reasons. First, the total number of distinct exons increased from 327,058 to 457,748 in GRCh38 and the median number of exons per gene also increased from 13 to 19 in GRCh38, while the median number of nucleotide per exon increased slightly al- most from 140 to 146 in GRCh38. These combined factors explain why the increase in the exome% in GRCh38.

>high throughput sequencing is prone to identify more duplication than deletion CNV

**System Preparation**
To make your life easy read my System Preparation Section before embarking upon the analysis part.

**All about HPC**
1. Start [here](https://github.com/hbctraining/In-depth-NGS-Data-Analysis-Course/raw/master/sessionI/slides/HPC_intro_O2_09042018.pdf)
2. 


**Learn Linux** 
1. Source 1: [Here](https://hbctraining.github.io/Intro-to-Shell/lessons/01_the_filesystem.html)
2. Source 2: 

## Download Data from SRA
1. How to download data From SRA: Learn basic NGS data analysis from   
[nextgenerationsequencinghq](https://www.youtube.com/watch?v=JvifigTF4yY)
2. SRA-Toolkit: [One of the worst documented NCBI Tool](https://edwards.sdsu.edu/research/fastq-dump/) 

## How to get Chromosome size
1. Go to [UCSC Table browser](https://genome.ucsc.edu/cgi-bin/hgTables?hgsid=780963871_WaJykmAKwt9wE7PNSLuULyyD8Gtg&clade=mammal&org=&db=hg19&hgta_group=allTables&hgta_track=hg38&hgta_table=chromInfo&hgta_regionType=genome&position=&hgta_outputType=primaryTable&hgta_outFileName=)
2. Select Clade: mammal, Assembly: GRCh38, group: All Tables,  Table: Chrominfo and hit Submit
3. This wiil give you chromosome length

**How Can I Get The Human Chromosome Centromere Position And Chromosome Length In Grch37/Hg19** see [here](https://www.biostars.org/p/2349/)

**Locating centromeres and telomeres**
1. In hg19: This information can be found in the "gap" database table. Use the Table Browser to extract it. To do this, select your assembly and the gap table, then click the " filter Create" button. Set the "type" field to centromere telomere (separated by a space). [Source](https://genome.ucsc.edu/FAQ/FAQtracks#tracks20)
2. In hg38: See [source1](https://groups.google.com/a/soe.ucsc.edu/forum/#!msg/genome/SaR2y4UNrWg/XsGdMI3AazgJ) and [source2](https://groups.google.com/a/soe.ucsc.edu/forum/#!topic/genome/c9eZ_fywMbo)

## Convert .bcl to fastq
1. Quick [read](https://medium.com/@marija190396/bcl-to-fastq-conversion-e289852823d0)

## Lessons learnt from TCGA 2020 Conference

1. Use multiple variant callers (MuSE, Mutect2, VarScan2, SomaticSniper, Pindel were used in TCGA). Post annotation). Since germline mutations can be leaked and can be used to trace individuals they are usually masked. ![enter image description here](https://i.imgur.com/gWnJc4b.png)

![enter image description here](https://i.imgur.com/NlV7Acv.png)

To download havy files from TCGA GDC portal, used manifest file. Use then Data Transfer Tool (DTT).

![enter image description here](https://i.imgur.com/8t84P31.png)

![enter image description here](https://i.imgur.com/3VSDRru.png)

![enter image description here](https://i.imgur.com/6VXRYYo.png)

![enter image description here](https://i.imgur.com/ukiqlLK.png)




