#!/bin/sh

#DEPENDENCIES
export ANTSPATH=/home/rorypiper/software/install/bin/
export PATH=${ANTSPATH}:$PATH

#MOVE TO THE DATA
GROUP=resections
session_name=ses-preop01

#LOOP
for i in sub*; do
	echo ${i}

	#SET THE BASES
	t1folder=/media/rorypiper/gosh_nsgy/aswin/${GROUP}/input/source_data/${i}/${session_name}/anat
	
	#Make the original file 'raw'
	cp $t1folder/${i}_${session_name}_T1w.nii.gz $t1folder/${i}_${session_name}_T1w_raw.nii.gz 
	
	#Denoise
	DenoiseImage -d 3 -i $t1folder/${i}_${session_name}_T1w.nii.gz -o $t1folder/${i}_${session_name}_T1w.nii.gz -v
	
	#Bias Field Correction
	N4BiasFieldCorrection -d 3 -i $t1folder/${i}_${session_name}_T1w.nii.gz -o $t1folder/${i}_${session_name}_T1w.nii.gz -v
	
done
