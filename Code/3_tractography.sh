#!/bin/sh

# Add software prerequisites
export FREESURFER_HOME=/home/rorypiper/software/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh
export ANTSPATH=/home/rorypiper/software/install/bin/
export PATH=${ANTSPATH}:$PATH

export NIFTYREG_INSTALL=/home/rorypiper/software/nifty_git/niftyreg/install
PATH=${PATH}:${NIFTYREG_INSTALL}/bin
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${NIFTYREG_INSTALL}/lib
export PATH
export LD_LIBRARY_PATH

# define group , e.g. GROUP = SEEG or GROUP = resections or GROUP = controls
read -p 'Group: ' GROUP

# define session name 
read -p 'Session: ' session_name


#LOOP THROUGH SUBJECTS

for i in sub*; do

echo $i

#SET THE BASES
atlas_base=/media/rorypiper/gosh_nsgy/aswin/$GROUP/output/cmp/nipype-1.7.0/${i}/$session_name/anatomical_pipeline/parcellation_stage
parc_base=/media/rorypiper/gosh_nsgy/aswin/$GROUP/output/cmp/nipype-1.7.0/${i}/$session_name/anatomical_pipeline/parcellation_stage/parcCombiner
diffusion_base=/media/rorypiper/gosh_nsgy/aswin/$GROUP/output/dwi/${i}/${session_name}/mrtrix
mkdir /media/rorypiper/gosh_nsgy/aswin/$GROUP/output/connectomes/${i}
mkdir /media/rorypiper/gosh_nsgy/aswin/$GROUP/output/connectomes/${i}/${session_name}
connectomes_out=/media/rorypiper/gosh_nsgy/aswin/$GROUP/output/connectomes/${i}/${session_name}
mkdir /media/rorypiper/gosh_nsgy/aswin/$GROUP/output/segmentations/${i}
mkdir /media/rorypiper/gosh_nsgy/aswin/$GROUP/output/segmentations/${i}/${session_name}
segment_out=/media/rorypiper/gosh_nsgy/aswin/$GROUP/output/segmentations/${i}/${session_name}


#RUN THE GENERIC DIFFUSION PROCESSING (i.e. not specific to scale)

reg_aladin -flo $atlas_base/Lausanne2018_parcellation/brain.nii.gz -ref $diffusion_base/${i}_${session_name}_nodif.nii.gz -aff $atlas_base/t12diff.txt -res $diffusion_base/${i}_${session_name}_diff_space_brain.nii.gz -rigOnly

reg_resample -flo $atlas_base/Lausanne2018_parcellation/aparc+aseg.native.nii.gz -ref $diffusion_base/${i}_${session_name}_nodif.nii.gz -aff $atlas_base/t12diff.txt -res $diffusion_base/${i}_${session_name}_diff_space_aparc+aseg.nii.gz -inter 0

#had to change to fsl (vs freesurfer in in the 55tgen

5ttgen fsl /media/rorypiper/gosh_nsgy/aswin/$GROUP/input/source_data/$i/${session_name}/anat/${i}_${session_name}_T1w.nii.gz $diffusion_base/${i}_${session_name}_5tt_native.nii.gz -force

reg_resample -flo $diffusion_base/${i}_${session_name}_5tt_native.nii.gz -ref $diffusion_base/${i}_${session_name}_nodif.nii.gz -aff $atlas_base/t12diff.txt -res $diffusion_base/${i}_${session_name}_5tt.nii.gz -inter 0

tckgen $diffusion_base/${i}_${session_name}_wm.mif -act $diffusion_base/${i}_${session_name}_5tt.nii.gz -select 5000000 -seed_dynamic $diffusion_base/${i}_${session_name}_wm.mif $diffusion_base/${i}_${session_name}_5M.tck -force

tcksift2 $diffusion_base/${i}_${session_name}_5M.tck $diffusion_base/${i}_${session_name}_wm.mif $diffusion_base/${i}_${session_name}_5M_sift.txt -force


done


