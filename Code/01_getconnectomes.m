%% Set-up

clc
clear all

cd('/Users/aswinchari/Desktop/GOSH/47. LongitudinalNetworks');

%% Decide Scale

scale = 3;      % set this here, can be 1 - 5

%% Make structure for controls

controls = table2struct(readtable('Data/control_demographics.csv'));

for a = 1:length(controls)
    try
    temp = csvread(strcat('Data/controls/',string(controls(a).id),'/ses-01/',string(controls(a).id),'_ses-01_scale-',string(scale),'_connectome_sift2.csv'));
    controls(a).connectome = temp;
    clear temp
    end
end

clear a

%% Make structure for resections

resections = table2struct(readtable('Data/resection_demographics.csv'));

for a = 1:length(resections)
    try
    temp = csvread(strcat('Data/resections/',string(resections(a).id),'/ses-preop01/',string(resections(a).id),'_ses-preop01_scale-',string(scale),'_connectome_sift2.csv'));
    resections(a).connectome1 = temp;
    clear temp
    temp = csvread(strcat('Data/resections/',string(resections(a).id),'/ses-preop02/',string(resections(a).id),'_ses-preop02_scale-',string(scale),'_connectome_sift2.csv'));
    resections(a).connectome2 = temp;
    clear temp
    end
end



clear a

%% Save dataset

save(strcat('Data/dataset_scale',string(scale),'.mat'),'controls','resections');
