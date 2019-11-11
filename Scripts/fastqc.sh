# BSUB -J fastqc.sh
# BSUB -o sam_to_bam.o
# BSUB -e sam_to_bam.e
# BSUB -q regularq
# BSUB -n 4

## Parameters Used ##
#-o Output directory
#--nogroup: To prevent binning; useful to see per base quality. Note: Use only on few files with small read length; Increases computation time.  

fastqc -o QC_results/ *.gz 2> fastqc.stderr
