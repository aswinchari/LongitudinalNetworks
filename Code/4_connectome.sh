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


#RE-ORGANISE THE HIPP MASKS (NOT SCALE SPECIFIC)

#LEFT
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 7000 -bin $parc_base/../parcHippo/lh_subFields_amy_only.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -uthr 7000 $parc_base/../parcHippo/lh_subFields_hipp_only.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 226 -uthr 226 -bin $parc_base/../parcHippo/lh_subFields_hipp_tail.nii.gz

fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 203 -uthr 203 -bin $parc_base/../parcHippo/lh_subFields_hipp_head_1.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 211 -uthr 211 -bin $parc_base/../parcHippo/lh_subFields_hipp_head_2.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 235 -uthr 235 -bin $parc_base/../parcHippo/lh_subFields_hipp_head_3.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 237 -uthr 237 -bin $parc_base/../parcHippo/lh_subFields_hipp_head_4.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 239 -uthr 239 -bin $parc_base/../parcHippo/lh_subFields_hipp_head_5.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 241 -uthr 241 -bin $parc_base/../parcHippo/lh_subFields_hipp_head_6.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 245 -uthr 245 -bin $parc_base/../parcHippo/lh_subFields_hipp_head_7.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 243 -uthr 243 -bin $parc_base/../parcHippo/lh_subFields_hipp_head_8.nii.gz

fslmaths $parc_base/../parcHippo/lh_subFields_hipp_head_1.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_head_2.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_head_3.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_head_4.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_head_5.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_head_6.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_head_7.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_head_8.nii.gz $parc_base/../parcHippo/lh_subFields_hipp_head-all.nii.gz
rm $parc_base/../parcHippo/lh_subFields_hipp_head_*.nii.gz

fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 212 -uthr 212 -bin $parc_base/../parcHippo/lh_subFields_hipp_body_1.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 215 -uthr 215 -bin $parc_base/../parcHippo/lh_subFields_hipp_body_2.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 234 -uthr 234 -bin $parc_base/../parcHippo/lh_subFields_hipp_body_3.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 236 -uthr 236 -bin $parc_base/../parcHippo/lh_subFields_hipp_body_4.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 238 -uthr 238 -bin $parc_base/../parcHippo/lh_subFields_hipp_body_5.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 240 -uthr 240 -bin $parc_base/../parcHippo/lh_subFields_hipp_body_6.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 242 -uthr 242 -bin $parc_base/../parcHippo/lh_subFields_hipp_body_7.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 244 -uthr 244 -bin $parc_base/../parcHippo/lh_subFields_hipp_body_8.nii.gz
fslmaths $parc_base/../parcHippo/lh_subFields.nii.gz -thr 246 -uthr 246 -bin $parc_base/../parcHippo/lh_subFields_hipp_body_9.nii.gz

fslmaths $parc_base/../parcHippo/lh_subFields_hipp_body_1.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_body_2.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_body_3.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_body_4.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_body_5.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_body_6.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_body_7.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_body_8.nii.gz -add $parc_base/../parcHippo/lh_subFields_hipp_body_9.nii.gz $parc_base/../parcHippo/lh_subFields_hipp_body-all.nii.gz

rm $parc_base/../parcHippo/lh_subFields_hipp_body_*.nii.gz

#RIGHT
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 7000 -bin $parc_base/../parcHippo/rh_subFields_amy_only.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -uthr 7000 $parc_base/../parcHippo/rh_subFields_hipp_only.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 226 -uthr 226 -bin $parc_base/../parcHippo/rh_subFields_hipp_tail.nii.gz

fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 203 -uthr 203 -bin $parc_base/../parcHippo/rh_subFields_hipp_head_1.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 211 -uthr 211 -bin $parc_base/../parcHippo/rh_subFields_hipp_head_2.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 235 -uthr 235 -bin $parc_base/../parcHippo/rh_subFields_hipp_head_3.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 237 -uthr 237 -bin $parc_base/../parcHippo/rh_subFields_hipp_head_4.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 239 -uthr 239 -bin $parc_base/../parcHippo/rh_subFields_hipp_head_5.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 241 -uthr 241 -bin $parc_base/../parcHippo/rh_subFields_hipp_head_6.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 245 -uthr 245 -bin $parc_base/../parcHippo/rh_subFields_hipp_head_7.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 243 -uthr 243 -bin $parc_base/../parcHippo/rh_subFields_hipp_head_8.nii.gz

fslmaths $parc_base/../parcHippo/rh_subFields_hipp_head_1.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_head_2.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_head_3.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_head_4.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_head_5.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_head_6.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_head_7.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_head_8.nii.gz $parc_base/../parcHippo/rh_subFields_hipp_head-all.nii.gz

rm $parc_base/../parcHippo/rh_subFields_hipp_head_*.nii.gz

fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 212 -uthr 212 -bin $parc_base/../parcHippo/rh_subFields_hipp_body_1.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 215 -uthr 215 -bin $parc_base/../parcHippo/rh_subFields_hipp_body_2.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 234 -uthr 234 -bin $parc_base/../parcHippo/rh_subFields_hipp_body_3.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 236 -uthr 236 -bin $parc_base/../parcHippo/rh_subFields_hipp_body_4.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 238 -uthr 238 -bin $parc_base/../parcHippo/rh_subFields_hipp_body_5.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 240 -uthr 240 -bin $parc_base/../parcHippo/rh_subFields_hipp_body_6.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 242 -uthr 242 -bin $parc_base/../parcHippo/rh_subFields_hipp_body_7.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 244 -uthr 244 -bin $parc_base/../parcHippo/rh_subFields_hipp_body_8.nii.gz
fslmaths $parc_base/../parcHippo/rh_subFields.nii.gz -thr 246 -uthr 246 -bin $parc_base/../parcHippo/rh_subFields_hipp_body_9.nii.gz

fslmaths $parc_base/../parcHippo/rh_subFields_hipp_body_1.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_body_2.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_body_3.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_body_4.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_body_5.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_body_6.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_body_7.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_body_8.nii.gz -add $parc_base/../parcHippo/rh_subFields_hipp_body_9.nii.gz $parc_base/../parcHippo/rh_subFields_hipp_body-all.nii.gz

rm $parc_base/../parcHippo/rh_subFields_hipp_body_*.nii.gz





# LOOP THROUGH SCALES

	for scale in $(seq 5) ; do
	echo $scale

	# SELECT LABELS TO APPLY TO HIPP & AMY REGIONS - based on labels in ScaleX_old_labels.txt

	if [ $scale -eq 1 ];
	then lh_amy=106; lh_head=108; lh_body=109; lh_tail=110; rh_amy=46 ;rh_head=48; rh_body=49; rh_tail=50; ha_r_low=46 ; ha_r_high=59 ; ha_l_low=106 ; ha_l_high=119 ;
	fi

	if [ $scale -eq 2 ];
	then lh_amy=152; lh_head=154; lh_body=155; lh_tail=156; rh_amy=69 ;rh_head=71; rh_body=72; rh_tail=73; ha_r_low=69 ; ha_r_high=82 ; ha_l_low=152 ; ha_l_high=165 ;
	fi

	if [ $scale -eq 3 ];
	then lh_amy=254; lh_head=256; lh_body=257; lh_tail=258; rh_amy=120 ; rh_head=122; rh_body=123; rh_tail=124; ha_r_low=120 ; ha_r_high=133 ; ha_l_low=254 ; ha_l_high=267 ;
	fi

	if [ $scale -eq 4 ];
	then lh_amy=484; lh_head=486; lh_body=487; lh_tail=488; rh_amy=235; rh_head=237; rh_body=238; rh_tail=239; ha_r_low=235 ; ha_r_high=248 ; ha_l_low=484 ; ha_l_high=497 ;
	fi

	if [ $scale -eq 5 ];
	then lh_amy=1040; lh_head=1042; lh_body=1043; lh_tail=1044; rh_amy=513; rh_head=515; rh_body=516; rh_tail=517; ha_r_low=513 ; ha_r_high=526 ; ha_l_low=1040 ; ha_l_high=x1053 ;
	fi 


	#MAKE A COPY OF THE ATLAS

	cp $parc_base/ROIv_Lausanne2018_scale${scale}_final.nii.gz $parc_base/custom_scale_${scale}.nii.gz

	#UPDATE THE SEGMENTATION

	#Remove the old hipp and amys
	fslmaths $parc_base/custom_scale_${scale}.nii.gz -thr $ha_r_low -uthr $ha_r_high -bin $parc_base/hippamy_r.nii.gz
	fslmaths $parc_base/custom_scale_${scale}.nii.gz -thr $ha_l_low -uthr $ha_l_high -bin $parc_base/hippamy_l.nii.gz
	fslmaths $parc_base/hippamy_l.nii.gz -add $parc_base/hippamy_r.nii.gz $parc_base/hippamy_b.nii.gz
	fslmaths $parc_base/hippamy_b.nii.gz -mul -1 -add 1 $parc_base/hippamy_b2.nii.gz
	fslmaths $parc_base/custom_scale_${scale}.nii.gz -mul $parc_base/hippamy_b2.nii.gz $parc_base/custom_scale_${scale}.nii.gz

	#Assign labels to hippamy regions
	#L
	fslmaths $parc_base/../parcHippo/lh_subFields_amy_only.nii.gz -mul $lh_amy $parc_base/../parcHippo/${scale}lh_subFields_amy_only.nii.gz
	fslmaths $parc_base/../parcHippo/lh_subFields_hipp_head-all.nii.gz -mul $lh_head $parc_base/../parcHippo/${scale}lh_subFields_hipp_head-all.nii.gz
	fslmaths $parc_base/../parcHippo/lh_subFields_hipp_body-all.nii.gz -mul $lh_body $parc_base/../parcHippo/${scale}lh_subFields_hipp_body-all.nii.gz
	fslmaths $parc_base/../parcHippo/lh_subFields_hipp_tail.nii.gz -mul $lh_tail $parc_base/../parcHippo/${scale}lh_subFields_hipp_tail.nii.gz
	#R
	fslmaths $parc_base/../parcHippo/rh_subFields_amy_only.nii.gz -mul $rh_amy $parc_base/../parcHippo/${scale}rh_subFields_amy_only.nii.gz
	fslmaths $parc_base/../parcHippo/rh_subFields_hipp_head-all.nii.gz -mul $rh_head $parc_base/../parcHippo/${scale}rh_subFields_hipp_head-all.nii.gz
	fslmaths $parc_base/../parcHippo/rh_subFields_hipp_body-all.nii.gz -mul $rh_body $parc_base/../parcHippo/${scale}rh_subFields_hipp_body-all.nii.gz
	fslmaths $parc_base/../parcHippo/rh_subFields_hipp_tail.nii.gz -mul $rh_tail $parc_base/../parcHippo/${scale}rh_subFields_hipp_tail.nii.gz

	#Combine hippamy regions
	fslmaths $parc_base/../parcHippo/${scale}lh_subFields_amy_only.nii.gz -add $parc_base/../parcHippo/${scale}lh_subFields_hipp_tail.nii.gz -add $parc_base/../parcHippo/${scale}lh_subFields_hipp_head-all.nii.gz -add $parc_base/../parcHippo/${scale}lh_subFields_hipp_body-all.nii.gz -add $parc_base/../parcHippo/${scale}rh_subFields_amy_only.nii.gz -add $parc_base/../parcHippo/${scale}rh_subFields_hipp_tail.nii.gz -add $parc_base/../parcHippo/${scale}rh_subFields_hipp_head-all.nii.gz -add $parc_base/../parcHippo/${scale}rh_subFields_hipp_body-all.nii.gz $parc_base/../parcHippo/${scale}hippamy.nii.gz

	#Remove the overlapping voxels with new hipp amy
	fslmaths $parc_base/../parcHippo/${scale}hippamy.nii.gz -bin $parc_base/../parcHippo/temp.nii.gz
	fslmaths $parc_base/../parcHippo/temp.nii.gz -mul -1 -add 1 $parc_base/../parcHippo/temp2.nii.gz
	fslmaths $parc_base/../parcHippo/temp2.nii.gz -mul $parc_base/custom_scale_${scale}.nii.gz $parc_base/custom_scale_${scale}.nii.gz

	#Add hippamy to full parcellation
	fslmaths $parc_base/custom_scale_${scale}.nii.gz -add $parc_base/../parcHippo/${scale}hippamy.nii.gz $parc_base/custom_scale_${scale}.nii.gz

	#FIX THE LABEL NUMBERING
	labelconvert $parc_base/custom_scale_${scale}.nii.gz /home/rorypiper/code/labels/Scale${scale}_old_labels.txt /home/rorypiper/code/labels/Scale${scale}_new_labels.txt $parc_base/custom_scale_${scale}.nii.gz -force
	
	#COPY PARCELLATION TO THE OUTPUT FOLDER
	
	cp $parc_base/custom_scale_${scale}.nii.gz $segment_out/${i}_${session_name}_scale-${scale}_parcellation.nii.gz

	#MAKE THE CONNECTOMES
	
	#SIFT2

	reg_resample -flo $atlas_base/parcCombiner/custom_scale_${scale}.nii.gz -ref $diffusion_base/${i}_${session_name}_nodif.nii.gz -aff $atlas_base/t12diff.txt -res $diffusion_base/${i}_${session_name}_diff_space_labels.nii.gz -inter 0

	tck2connectome -symmetric -tck_weights_in $diffusion_base/${i}_${session_name}_5M_sift.txt $diffusion_base/${i}_${session_name}_5M.tck $diffusion_base/${i}_${session_name}_diff_space_labels.nii.gz $connectomes_out/${i}_${session_name}_scale-${scale}_connectome_sift2.csv -force
	
	#SIFT2 - scaled for node volumes
	tck2connectome -symmetric -scale_invnodevol -tck_weights_in $diffusion_base/${i}_${session_name}_5M_sift.txt $diffusion_base/${i}_${session_name}_5M.tck $diffusion_base/${i}_${session_name}_diff_space_labels.nii.gz $connectomes_out/${i}_${session_name}_scale-${scale}_connectome_sift2_scaled4nodesize.csv -force
	
	#MAKE THE FA CONNECTOME
	tcksample ${diffusion_base}/${i}_${session_name}_5M.tck ${diffusion_base}/${i}_${session_name}_fa.mif ${diffusion_base}/${i}_${session_name}_mean_fa_per_streamline.csv -stat_tck mean -force
	
	#FA connectome - NOT scaled for mean whole brain FA
	tck2connectome -symmetric -tck_weights_in $diffusion_base/${i}_${session_name}_5M_sift.txt ${diffusion_base}/${i}_${session_name}_5M.tck $diffusion_base/${i}_${session_name}_diff_space_labels.nii.gz $connectomes_out/${i}_${session_name}_scale-${scale}_connectome_fa.csv -stat_edge mean -force
	
	#FA connectome - SCALED for mean whole brain FA
		tck2connectome -symmetric -tck_weights_in $diffusion_base/${i}_${session_name}_5M_sift.txt ${diffusion_base}/${i}_${session_name}_5M.tck $diffusion_base/${i}_${session_name}_diff_space_labels.nii.gz $connectomes_out/${i}_${session_name}_scale-${scale}_connectome_fa_scaled4meanFA.csv -scale_file ${diffusion_base}/${i}_${session_name}_mean_fa_per_streamline.csv -stat_edge mean -force
	
	#scaled version - NOT scaled for mean whole brain FA, BUT scaled for node volumes
	tck2connectome -symmetric -scale_invnodevol -tck_weights_in $diffusion_base/${i}_${session_name}_5M_sift.txt ${diffusion_base}/${i}_${session_name}_5M.tck $diffusion_base/${i}_${session_name}_diff_space_labels.nii.gz $connectomes_out/${i}_${session_name}_scale-${scale}_connectome_fa_scaled4nodesize.csv -stat_edge mean -force
	
	#scaled version - SCALED for mean whole brain FA, AND scaled for node volumes
	tck2connectome -symmetric -scale_invnodevol -tck_weights_in $diffusion_base/${i}_${session_name}_5M_sift.txt ${diffusion_base}/${i}_${session_name}_5M.tck $diffusion_base/${i}_${session_name}_diff_space_labels.nii.gz $connectomes_out/${i}_${session_name}_scale-${scale}_connectome_fa_scaled4nodesize_scaled4meanFA.csv -scale_file ${diffusion_base}/${i}_${session_name}_mean_fa_per_streamline.csv -stat_edge mean -force
	
	
	#CLEAN
	rm $parc_base/../parcHippo/tem*.nii.gz
	rm $parc_base/../parcHippo/${scale}rh*
	rm $parc_base/../parcHippo/${scale}lh*
	rm $parc_base/hippamy_*.nii.gz
		
	done

done


