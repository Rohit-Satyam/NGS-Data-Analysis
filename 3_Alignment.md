## Meaning of the output files of BWA MEM ([Source](http://seqanswers.com/forums/showthread.php?t=25553))

.amb is text file, to record *appearance of N** (or other non-ATGC) in the ref fasta.<br/>
.ann is text file, to record ref sequences, name, length, etc.<br/>
.bwt is binary, the Burrows-Wheeler transformed sequence.<br/>
.pac is binary, packaged sequence (four base pairs encode one byte).<br/>
.sa is binary, suffix array index.<br/>

**[Is -a bwtsw flag compulsory for indexing human genome with BWA](https://www.biostars.org/p/302907/)**

Interpreting the Bwa mem screen output <br/>
1. What is FF, FR, RF, RR?<br/>
FR:   ---------> F         <--------- R <br/>
RF:    <-------- R         ---------> F <br/>
FF:   ---------->F       -----------> F <br/>
RR:   <---------- R      <------------R <br/>

**PNEXT in SAM File** Bam Format: What'S The Purpose Of Rnext And Pnext ? See [here](https://www.biostars.org/p/11790/)
