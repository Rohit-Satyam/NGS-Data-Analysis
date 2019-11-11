# BSUB -J trim.sh
# BSUB -o merge_1.o
# BSUB -e merge_1.e
# BSUB -q regularq
# BSUB -n 8

## For Quality Trimming of Paired End Reads ##
raw='input_path'
trimmomatic='/home/parashar/software/Trimmomatic-0.39/trimmomatic-0.39.jar'
java='/usr/bin/java -jar'

for file in *_R1.gz
do
name=$(basename ${file} _R1.gz)
$java $trimmomatic  PE -threads 4 $raw/${file} $raw/${name}_R2.gz $raw/trim_paired/${name}_R1_P.fastq.gz $raw/trim_unpaired/${name}_R1_UP.fastq.gz $raw/trim_paired/${name}_R2_P.fastq.gz $raw/trim_unpaired/${name}_R2_UP.fastq.gz SLIDINGWINDOW:30:24 MINLEN:70
done
