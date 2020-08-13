# BSUB -J wgs_pipeline.sh
# BSUB -o wgs_pipeline.o
# BSUB -e wgs_pipeline.e
# BSUB -q regularq
# BSUB -n 32

##############################################
############# PATHS ##########################
##############################################

##Edit the paths here

## Keep the Normal and Tumor data in same directory
raw="/home/parashar/scratch/test"
hg38="/home/parashar/archive/GRCh38_GATK/Homo_sapiens_assembly38.fasta"
l1="L001.sorted.bam"
l2="L002.sorted.bam"
l3="L003.sorted.bam"
l4="L004.sorted.bam"





############################################
##############  Alignment  #################
############################################

## Preparing List of file in raw folder
mkdir $raw/alignments

ls -1 $raw/*.fastq.gz | grep 'R1' >> $raw/alignments/fastqlist

while read p;
do
header=$(zcat $p | head -n 1);
id=$(echo $header | cut -f 3-4 -d":" | sed 's/@//');
sm=$(echo $p| xargs -n 1 basename | cut -f 1-2 -d"_");
nam=$(echo $p | xargs -n 1 basename | cut -f 1-3 -d"_");
echo "bwa mem -M -R '@RG\tID:$id\tSM:$sm\tPL:ILLUMINA' $hg38 $p $raw/${nam}_R2_001.fastq.gz | sambamba view -S -f bam /dev/stdin | sambamba sort -o $raw/alignments/${nam}.sorted.bam /dev/stdin 2> $raw/alignments/${nam}.sorted.stderr" >> $raw/alignments/aligncmd;
done < "$raw/alignments/fastqlist"

cat $raw/alignments/aligncmd | parallel -j 8 "{}"

mkdir -p $raw/markdup/scripts 
mkdir -p $raw/bqsr/logs

ls -1 $raw/alignments/*.bam | xargs -n 1 basename | grep 'L001' >> $raw/markdup/list

while read p
do
name=$(basename $p _L001.sorted.bam)
echo "#!/bin/bash" > ${name}.sh
chmod +x ${name}.sh
echo "java -jar /home/parashar/software/picard.jar.1 MarkDuplicates I=$raw/alignments/${name}_L001.sorted.bam I=$raw/alignments/${name}_L002.sorted.bam I=$raw/alignments/${name}_L003.sorted.bam I=$raw/alignments/${name}_L004.sorted.bam O=$raw/markdup/${name}_dedup.bam M=$raw/markdup/${name}_metrics.txt TAGGING_POLICY=All ASSUME_SORTED=true OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 2> $raw/markdup/${name}_markdup.stderr" >> ${name}.sh
echo "gatk BaseRecalibrator -I $raw/markdup/${name}_dedup.bam -R $hg38 --known-sites /home/parashar/archive/GRCh38_GATK/Homo_sapiens_assembly38.dbsnp138.vcf --known-sites /home/parashar/archive/GRCh38_GATK/Homo_sapiens_assembly38.known_indels.vcf -O $raw/bqsr/${name}_recal_before_data.table 2> $raw/bqsr/${name}.bqsr.before.stderr" >> ${name}.sh
echo "gatk ApplyBQSR -R $hg38 -I $raw/markdup/${name}_dedup.bam -bqsr $raw/bqsr/${name}_recal_before_data.table -O $raw/bqsr/${name}_dedup.bqsr.bam 2> $raw/bqsr/${name}.applybqsr.stderr" >> ${name}.sh
echo "gatk BaseRecalibrator -I $raw/bqsr/${name}_dedup.bqsr.bam -R $hg38 --known-sites /home/parashar/archive/GRCh38_GATK/Homo_sapiens_assembly38.dbsnp138.vcf --known-sites /home/parashar/archive/GRCh38_GATK/Homo_sapiens_assembly38.known_indels.vcf -O $raw/bqsr/${name}_recal_after_data.table 2> $raw/bqsr/${name}.bqsr.after.stderr" >> ${name}.sh
echo "gatk AnalyzeCovariates -before $raw/bqsr/${name}_recal_before_data.table -after $raw/bqsr/${name}_recal_after_data.table -plots $raw/bqsr/${name}_AnalyzeCovariates.pdf 2> $raw/bqsr/${name}_AnlzCov.stderr" >> ${name}.sh
bsub < ${name}.sh
mv ${name}.sh $raw/markdup/scripts
done < "$raw/markdup/list"
