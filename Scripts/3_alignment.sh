# BSUB -J cchip.sh
# BSUB -o cchip.o
# BSUB -e cchip.e
# BSUB -m node14
# BSUB -n 8

## Alignment of samples to reference Genome using BWA MEM ##

##Location of
ctrl='path_sample'
hg37='path_to_hg37'

##The sample file will be stored in current directory ##
# ls -list                                ##
# -1 list one file per line               ##
# | -pipe                                 ##
# xarg -n - max-arguments per line        ##
# basename -remove the path information   ##
#uniq -keep unique names only             ##

ls -1 $ctrl/*.gz | xargs -n 1 basename | uniq > temp1.txt

## Read remp1.txt line by line ##
while read p
do
basename ${p} _R1.gz  >> temp2.txt
done < temp1.txt

## Sort file contents and remove R2 (Reverse) tag ##
sort temp2.txt | sed '/_R2.gz/d' | uniq > control.txt

## Align using BWA MEM ##
## -x to input index. Remember to give the prefix of the index names    ##
## -1 to input forward strand reads                                     ##
## -2 to input reverse strand reads                                     ##

cat control.txt | parallel "bwa mem $hg37 $ctrl/{}_R1.gz $ctrl/{}_R2.gz > ./{}.sam 2> {}.stderr"
