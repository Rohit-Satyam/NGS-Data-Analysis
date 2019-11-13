## Data Compression

If you are looking for some permanent solution of compressing and storing data generated from NGS or Chipseq, the following literature might come at your rescue

1. [Which compression format should I use for NGS-related files?](https://www.uppmax.uu.se/support-sv/faq/resources-faq/which-compression-format-should-i-use-for-ngs-related-files/)
2. [How should I compress FastQ-format files?](https://www.uppmax.uu.se/support-sv/faq/resources-faq/how-should-i-compress-fastq-format-files/)
3. Not recommended though: Will show bias in Fastqc duplicates results: [FaStore: a space-saving solution for raw sequencing data](https://academic.oup.com/bioinformatics/article/34/16/2748/4956350)
4. [Compression of FASTQ and SAM Format Sequencing Data](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0059190)
5. [How many times can a file be compressed?](https://stackoverflow.com/questions/1166385/how-many-times-can-a-file-be-compressed)

Bzip2 is better compression than gzip (have a better compression rato). The other compression techniques use lossy compression, use Quality scores to remove bad quality reads (<20), reordering the similar reads etc. thereby disrupting the integrity of the data. They are appropriate to use when you have already preprocessed your data. Otherwise you can end up seeing different/biased results in fastqc analysis. Moreover, their behaviour with bwa mem isn't well understood. gz and bzip2 files are frequently used with bwa mem and can prove to be helpful initially. Moreover the rate at which the files are decompressed during alignment also decide alignment speed. 

However though bzip2 have better compression ratio than gzip, it comes at the cost of speed. Here are some stats:

>decompression speed (fast > slow): gzip, zip > 7z > rar > bzip2 <br /> 
>compression speed (fast > slow): gzip, zip > bzip2 > 7z > rar <br />
>compression ratio (better > worse): 7z > rar, bzip2 > gzip > zip <br />
>availability (unix): gzip > bzip2 > zip > 7z > rar <br />
>availability (windows): zip > rar > 7z > gzip, bzip2 <br />
