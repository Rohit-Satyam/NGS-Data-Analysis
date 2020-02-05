# BSUB -J filter.sh
# BSUB -o filter.o
# BSUB -e filter.e
# BSUB -m node16
# BSUB -n 4
# BSUB -q regularq
##Location of 
#tst='/home/parashar/scratch/bowtie'


##put the sample name in a file
##The sample file will be stored in current directory

#ls -1 $tst/*.bam | xargs -n 1 basename | uniq > temp2.txt

#while read p
#do
#basename ${p} .bam  >> testtemp.txt 
#done < temp2.txt
#sort testtemp.txt | uniq > test.txt

sambamba view -h -f bam -F 'mapping_quality >= 1 and not (unmapped or secondary_alignment) and not ([XA] != null or [SA] != null)' .bam -o {}_mapq.bam 2> {}.stderr
