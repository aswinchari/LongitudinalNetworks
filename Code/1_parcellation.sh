#!/bin/bash

# Automated Parcellation uses the Lausanne Atlas via CMP3

# define group , e.g. GROUP = SEEG or GROUP = resections or GROUP = controls
read -p 'Group: ' GROUP

# define session name 
read -p 'Session: ' session_name

for i in sub*; do
echo $i
prefix="sub-"
sub=${i#"$prefix"}

#Run the CMP

docker run -t --rm -u $(id -u):$(id -g) \
        -v /media/rorypiper/gosh_nsgy/aswin/$GROUP/input/source_data:/bids_dir \
        -v /media/rorypiper/gosh_nsgy/aswin/$GROUP/output/cmp:/output_dir \
        -v /home/rorypiper/code/license.txt:/bids_dir/code/license.txt \
        sebastientourbier/connectomemapper-bidsapp:v3.0.3 \
        /bids_dir /output_dir participant --participant_label ${sub} \
        --anat_pipeline_config /bids_dir/code_piper/ref_anatomical_config.json \
        --number_of_participants_processed_in_parallel 3  \
        --number_of_threads 3 \
        --ants_number_of_threads 3 

	
done


