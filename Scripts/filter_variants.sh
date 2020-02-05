# BSUB -J filter_call.sh
# BSUB -o filter_call.o
# BSUB -e filter_call.e
# BSUB -q regularq

#Location of 
#gatk Mutect2 -R /home/parashar/archive/Megha/bwa_0.7.17/hg19.fa -I AD0485_S1_dedup.bam -I AD0772_S2_dedup.bam -normal AD0772 -O somatic.vcf.gz 2> VCF.stderr
gatk FilterMutectCalls -R /home/parashar/archive/Megha/bwa_0.7.17/hg19.fa -V somatic.vcf.gz -O filtered.vcf.gz 2> filter_variant_call.stderr
