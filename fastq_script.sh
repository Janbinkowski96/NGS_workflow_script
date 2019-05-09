#!/bin/bash
set -e

data_sets="SRX2636920 SRX2636919 SRX2636918 SRX2636917
SRX2636916 SRX2636915 SRX2636914 SRX2636913 SRX2636912
SRX2636911 SRX2636910 SRX2636909 SRX2636908 SRX2636907
SRX2636906 SRX2636905 SRX2636904"

faster=~/Soft/sratoolkit.2.9.6-ubuntu64/bin/fasterq-dump.2.9.6
qc=~/Soft/FastQC/fastqc

parta=_1.fastq
partb=_2.fastq

if ! [ -e Data_SRA ]; then
	mkdir Data_SRA
else
	echo "Data_SRA file exist"
	exit
fi


for sra_id in $data_sets; do

        echo "Download and quality control for SRA id:"  $sra_id
        mkdir Data_SRA/$sra_id

        $faster $sra_id -px --skip-technical -O Data_SRA/$sra_id/

	$qc Data_SRA/$sra_id/$sra_id$parta --extract  -o Data_SRA/$sra_id/ 
	$qc Data_SRA/$sra_id/$sra_id$partb --extract -o Data_SRA/$sra_id/ 
done
echo "Done"
