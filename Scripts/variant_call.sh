# BSUB -J vcf_call.sh
# BSUB -o vcf_call.o
# BSUB -e vcf_call.e
# BSUB -q regularq
# BSUB -m node22
# BSUB -n 8

#Location of 
gatk Mutect2 -R /home/parashar/archive/Megha/bwa_0.7.17/hg19.fa -I AD0485_S1_dedup.bam -I AD0772_S2_dedup.bam -normal AD0772 -O somatic.vcf.gz 2> VCF.stderr
