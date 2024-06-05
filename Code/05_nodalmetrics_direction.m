%% Exploring local efficiency & modal controllability as the key metric of interest
% Set-up

clc
clear all

cd('/Users/aswinchari/Desktop/GOSH/47. LongitudinalNetworks');

load('Data/dataset_scale3.mat')     % Check this is the right scale

load('Data/labels_scale3.mat');     % Check labels correct    

thresh = 2;                         % Check correct threshold

cols = cbrewer2('qual','Accent',3);

%% Z score node metrics
% Will be age and sex corrected 

%degree

disp('Z score for degree');

for a = 1:length(labels)
    
    for b = 1:length(controls)
    controlsdegree(b,1) = controls(b).degree(a);
    end
    
    for b = 1:length(resections)
    resectionsdegree1(b,1) = resections(b).degree1(a);
    resectionsdegree2(b,1) = resections(b).degree2(a);
    end
    
    % creat GLM and residuals
    
    controltable = table([controls.age]',{controls.sex}',controlsdegree,'VariableNames', {'age' 'sex' 'degree'});
    resectiontable1 = table([resections.age1]',{resections.sex}',resectionsdegree1,'VariableNames', {'age' 'sex' 'degree'});
    resectiontable2 = table([resections.age2]',{resections.sex}',resectionsdegree2,'VariableNames', {'age' 'sex' 'degree'});
    model = fitglm(controltable);
    resectionfitted1 = predict(model,resectiontable1);
    resectionfitted2 = predict(model,resectiontable2);
    resectionresidual1 = resectionsdegree1 - resectionfitted1;
    resectionresidual2 = resectionsdegree2 - resectionfitted2;
    
    % Z scores from residuals
    
    [controlsz,mu,sig] = zscore([model.Residuals.raw]);
    resectionsz1 = (resectionresidual1 - mu)/sig;
    resectionsz2 = (resectionresidual2 - mu)/sig;
    
    % plug back into struct
    
    for b = 1:length(controls)
        controls(b).zdegree(a) = controlsz(b);
    end
    
    for b = 1:length(resections);
        resections(b).zdegree1(a) = resectionsz1(b);
        resections(b).zdegree2(a) = resectionsz2(b);
    end
    
    clear controltable resectiontable1 resectiontable2 model resectionfitted1 resectionfitted2 resectionresidual1 resectionresidual2 resectionsdegree1 controlsdegree resectionsdegree2
    clear controlsz resectionsz1 resectionsz2 mu sig 
end

%lefficiency

disp('Z score for lefficiency');

for a = 1:length(labels)
    
    for b = 1:length(controls)
    controlslefficiency(b,1) = controls(b).lefficiency(a);
    end
    
    for b = 1:length(resections)
    resectionslefficiency1(b,1) = resections(b).lefficiency1(a);
    resectionslefficiency2(b,1) = resections(b).lefficiency2(a);
    end
    
    % creat GLM and residuals
    
    controltable = table([controls.age]',{controls.sex}',controlslefficiency,'VariableNames', {'age' 'sex' 'lefficiency'});
    resectiontable1 = table([resections.age1]',{resections.sex}',resectionslefficiency1,'VariableNames', {'age' 'sex' 'lefficiency'});
    resectiontable2 = table([resections.age2]',{resections.sex}',resectionslefficiency2,'VariableNames', {'age' 'sex' 'lefficiency'});
    model = fitglm(controltable);
    resectionfitted1 = predict(model,resectiontable1);
    resectionfitted2 = predict(model,resectiontable2);
    resectionresidual1 = resectionslefficiency1 - resectionfitted1;
    resectionresidual2 = resectionslefficiency2 - resectionfitted2;
    
    % Z scores from residuals
    
    [controlsz,mu,sig] = zscore([model.Residuals.raw]);
    resectionsz1 = (resectionresidual1 - mu)/sig;
    resectionsz2 = (resectionresidual2 - mu)/sig;
    
    % plug back into struct
    
    for b = 1:length(controls)
        controls(b).zlefficiency(a) = controlsz(b);
    end
    
    for b = 1:length(resections);
        resections(b).zlefficiency1(a) = resectionsz1(b);
        resections(b).zlefficiency2(a) = resectionsz2(b);
    end
    
    clear controltable resectiontable1 resectiontable2 model resectionfitted1 resectionfitted2 resectionresidual1 resectionresidual2 resectionslefficiency1 controlslefficiency resectionslefficiency2
    clear controlsz resectionsz1 resectionsz2 mu sig 
end

%eigencent

disp('Z score for eigencent');

for a = 1:length(labels)
    
    for b = 1:length(controls)
    controlseigencent(b,1) = controls(b).eigencent(a);
    end
    
    for b = 1:length(resections)
    resectionseigencent1(b,1) = resections(b).eigencent1(a);
    resectionseigencent2(b,1) = resections(b).eigencent2(a);
    end
    
    % creat GLM and residuals
    
    controltable = table([controls.age]',{controls.sex}',controlseigencent,'VariableNames', {'age' 'sex' 'eigencent'});
    resectiontable1 = table([resections.age1]',{resections.sex}',resectionseigencent1,'VariableNames', {'age' 'sex' 'eigencent'});
    resectiontable2 = table([resections.age2]',{resections.sex}',resectionseigencent2,'VariableNames', {'age' 'sex' 'eigencent'});
    model = fitglm(controltable);
    resectionfitted1 = predict(model,resectiontable1);
    resectionfitted2 = predict(model,resectiontable2);
    resectionresidual1 = resectionseigencent1 - resectionfitted1;
    resectionresidual2 = resectionseigencent2 - resectionfitted2;
    
    % Z scores from residuals
    
    [controlsz,mu,sig] = zscore([model.Residuals.raw]);
    resectionsz1 = (resectionresidual1 - mu)/sig;
    resectionsz2 = (resectionresidual2 - mu)/sig;
    
    % plug back into struct
    
    for b = 1:length(controls)
        controls(b).zeigencent(a) = controlsz(b);
    end
    
    for b = 1:length(resections);
        resections(b).zeigencent1(a) = resectionsz1(b);
        resections(b).zeigencent2(a) = resectionsz2(b);
    end
    
    clear controltable resectiontable1 resectiontable2 model resectionfitted1 resectionfitted2 resectionresidual1 resectionresidual2 resectionseigencent1 controlseigencent resectionseigencent2
    clear controlsz resectionsz1 resectionsz2 mu sig 
end

%partcoef

disp('Z score for partcoef');

for a = 1:length(labels)
    
    for b = 1:length(controls)
    controlspartcoef(b,1) = controls(b).partcoef(a);
    end
    
    for b = 1:length(resections)
    resectionspartcoef1(b,1) = resections(b).partcoef1(a);
    resectionspartcoef2(b,1) = resections(b).partcoef2(a);
    end
    
    % creat GLM and residuals
    
    controltable = table([controls.age]',{controls.sex}',controlspartcoef,'VariableNames', {'age' 'sex' 'partcoef'});
    resectiontable1 = table([resections.age1]',{resections.sex}',resectionspartcoef1,'VariableNames', {'age' 'sex' 'partcoef'});
    resectiontable2 = table([resections.age2]',{resections.sex}',resectionspartcoef2,'VariableNames', {'age' 'sex' 'partcoef'});
    model = fitglm(controltable);
    resectionfitted1 = predict(model,resectiontable1);
    resectionfitted2 = predict(model,resectiontable2);
    resectionresidual1 = resectionspartcoef1 - resectionfitted1;
    resectionresidual2 = resectionspartcoef2 - resectionfitted2;
    
    % Z scores from residuals
    
    [controlsz,mu,sig] = zscore([model.Residuals.raw]);
    resectionsz1 = (resectionresidual1 - mu)/sig;
    resectionsz2 = (resectionresidual2 - mu)/sig;
    
    % plug back into struct
    
    for b = 1:length(controls)
        controls(b).zpartcoef(a) = controlsz(b);
    end
    
    for b = 1:length(resections);
        resections(b).zpartcoef1(a) = resectionsz1(b);
        resections(b).zpartcoef2(a) = resectionsz2(b);
    end
    
    clear controltable resectiontable1 resectiontable2 model resectionfitted1 resectionfitted2 resectionresidual1 resectionresidual2 resectionspartcoef1 controlspartcoef resectionspartcoef2
    clear controlsz resectionsz1 resectionsz2 mu sig 
end

%avecont

disp('Z score for avecont');

for a = 1:length(labels)
    
    for b = 1:length(controls)
    controlsavecont(b,1) = controls(b).avecont(a);
    end
    
    for b = 1:length(resections)
    resectionsavecont1(b,1) = resections(b).avecont1(a);
    resectionsavecont2(b,1) = resections(b).avecont2(a);
    end
    
    % creat GLM and residuals
    
    controltable = table([controls.age]',{controls.sex}',controlsavecont,'VariableNames', {'age' 'sex' 'avecont'});
    resectiontable1 = table([resections.age1]',{resections.sex}',resectionsavecont1,'VariableNames', {'age' 'sex' 'avecont'});
    resectiontable2 = table([resections.age2]',{resections.sex}',resectionsavecont2,'VariableNames', {'age' 'sex' 'avecont'});
    model = fitglm(controltable);
    resectionfitted1 = predict(model,resectiontable1);
    resectionfitted2 = predict(model,resectiontable2);
    resectionresidual1 = resectionsavecont1 - resectionfitted1;
    resectionresidual2 = resectionsavecont2 - resectionfitted2;
    
    % Z scores from residuals
    
    [controlsz,mu,sig] = zscore([model.Residuals.raw]);
    resectionsz1 = (resectionresidual1 - mu)/sig;
    resectionsz2 = (resectionresidual2 - mu)/sig;
    
    % plug back into struct
    
    for b = 1:length(controls)
        controls(b).zavecont(a) = controlsz(b);
    end
    
    for b = 1:length(resections);
        resections(b).zavecont1(a) = resectionsz1(b);
        resections(b).zavecont2(a) = resectionsz2(b);
    end
    
    clear controltable resectiontable1 resectiontable2 model resectionfitted1 resectionfitted2 resectionresidual1 resectionresidual2 resectionsavecont1 controlsavecont resectionsavecont2
    clear controlsz resectionsz1 resectionsz2 mu sig 
end

%modalcont

disp('Z score for modalcont');

for a = 1:length(labels)
    
    for b = 1:length(controls)
    controlsmodalcont(b,1) = controls(b).modalcont(a);
    end
    
    for b = 1:length(resections)
    resectionsmodalcont1(b,1) = resections(b).modalcont1(a);
    resectionsmodalcont2(b,1) = resections(b).modalcont2(a);
    end
    
    % creat GLM and residuals
    
    controltable = table([controls.age]',{controls.sex}',controlsmodalcont,'VariableNames', {'age' 'sex' 'modalcont'});
    resectiontable1 = table([resections.age1]',{resections.sex}',resectionsmodalcont1,'VariableNames', {'age' 'sex' 'modalcont'});
    resectiontable2 = table([resections.age2]',{resections.sex}',resectionsmodalcont2,'VariableNames', {'age' 'sex' 'modalcont'});
    model = fitglm(controltable);
    resectionfitted1 = predict(model,resectiontable1);
    resectionfitted2 = predict(model,resectiontable2);
    resectionresidual1 = resectionsmodalcont1 - resectionfitted1;
    resectionresidual2 = resectionsmodalcont2 - resectionfitted2;
    
    % Z scores from residuals
    
    [controlsz,mu,sig] = zscore([model.Residuals.raw]);
    resectionsz1 = (resectionresidual1 - mu)/sig;
    resectionsz2 = (resectionresidual2 - mu)/sig;
    
    % plug back into struct
    
    for b = 1:length(controls)
        controls(b).zmodalcont(a) = controlsz(b);
    end
    
    for b = 1:length(resections);
        resections(b).zmodalcont1(a) = resectionsz1(b);
        resections(b).zmodalcont2(a) = resectionsz2(b);
    end
    
    clear controltable resectiontable1 resectiontable2 model resectionfitted1 resectionfitted2 resectionresidual1 resectionresidual2 resectionsmodalcont1 controlsmodalcont resectionsmodalcont2
    clear controlsz resectionsz1 resectionsz2 mu sig 
end

clear a b

%% Probe nodal metrics further: Separate positive and negative

%degree

for a = 1:length(controls)
    controlszpos(a) = sum(controls(a).zdegree > thresh);
    controlszneg(a) = sum(controls(a).zdegree < -thresh);
    
end

for a = 1:length(resections)
    resectionsz1pos(a) = sum(resections(a).zdegree1 > thresh);
    resectionsz1neg(a) = sum(resections(a).zdegree1 < -thresh);
    resectionsz2neg(a) = sum(resections(a).zdegree2 < -thresh);
    resectionsz2pos(a) = sum(resections(a).zdegree2 > thresh);
end

subplot(6,2,1)
[h, ~, ~, ~, ~] = al_goodplot(controlszpos,1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot(resectionsz1pos,3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot(resectionsz2pos,2,0.5,cols(3,:));
p = signrank(resectionsz1pos,resectionsz2pos);
if p<0.01
    sigstar([2,3])
end

title(strcat ('Degree above z-score of 2 (p=',string(round(p,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Number of Nodes')
xlim([0.5 3.5])
set(gca,'FontSize',15)
xtickangle(20)
set(gca,'FontSize',10)

clear p h j k

subplot(6,2,2)
[h, ~, ~, ~, ~] = al_goodplot(controlszneg,1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot(resectionsz1neg,3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot(resectionsz2neg,2,0.5,cols(3,:));
p = signrank(resectionsz1neg,resectionsz2neg);
if p<0.01
    sigstar([2,3])
end

title(strcat ('Degree below z-score of -2 (p=',string(round(p,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Number of Nodes')
xlim([0.5 3.5])
set(gca,'FontSize',15)
xtickangle(20)
set(gca,'FontSize',10)

clear p h j k

clear resectionsz1neg resectionsz1pos resectionsz2neg resectionsz2pos controlszpos controlszneg

%partcoef

for a = 1:length(controls)
    controlszpos(a) = sum(controls(a).zpartcoef > thresh);
    controlszneg(a) = sum(controls(a).zpartcoef < -thresh);
    
end

for a = 1:length(resections)
    resectionsz1pos(a) = sum(resections(a).zpartcoef1 > thresh);
    resectionsz1neg(a) = sum(resections(a).zpartcoef1 < -thresh);
    resectionsz2neg(a) = sum(resections(a).zpartcoef2 < -thresh);
    resectionsz2pos(a) = sum(resections(a).zpartcoef2 > thresh);
end

subplot(6,2,3)
[h, ~, ~, ~, ~] = al_goodplot(controlszpos,1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot(resectionsz1pos,3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot(resectionsz2pos,2,0.5,cols(3,:));
p = signrank(resectionsz1pos,resectionsz2pos);
if p<0.01
    sigstar([2,3])
end

title(strcat ('Participation Coefficient above z-score of 2 (p=',string(round(p,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Number of Nodes')
xlim([0.5 3.5])
set(gca,'FontSize',15)
xtickangle(20)
set(gca,'FontSize',10)

clear p h j k

subplot(6,2,4)
[h, ~, ~, ~, ~] = al_goodplot(controlszneg,1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot(resectionsz1neg,3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot(resectionsz2neg,2,0.5,cols(3,:));
p = signrank(resectionsz1neg,resectionsz2neg);
if p<0.01
    sigstar([2,3])
end

title(strcat ('Participation Coefficient below z-score of -2 (p=',string(round(p,4)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Number of Nodes')
xlim([0.5 3.5])
set(gca,'FontSize',15)
xtickangle(20)
set(gca,'FontSize',10)

clear p h j k

clear resectionsz1neg resectionsz1pos resectionsz2neg resectionsz2pos controlszpos controlszneg

%eigencent

for a = 1:length(controls)
    controlszpos(a) = sum(controls(a).zeigencent > thresh);
    controlszneg(a) = sum(controls(a).zeigencent < -thresh);
    
end

for a = 1:length(resections)
    resectionsz1pos(a) = sum(resections(a).zeigencent1 > thresh);
    resectionsz1neg(a) = sum(resections(a).zeigencent1 < -thresh);
    resectionsz2neg(a) = sum(resections(a).zeigencent2 < -thresh);
    resectionsz2pos(a) = sum(resections(a).zeigencent2 > thresh);
end

subplot(6,2,5)
[h, ~, ~, ~, ~] = al_goodplot(controlszpos,1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot(resectionsz1pos,3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot(resectionsz2pos,2,0.5,cols(3,:));
p = signrank(resectionsz1pos,resectionsz2pos);
if p<0.01
    sigstar([2,3])
end

title(strcat ('Eigenvector Centrality above z-score of 2 (p=',string(round(p,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Number of Nodes')
xlim([0.5 3.5])
set(gca,'FontSize',15)
xtickangle(20)
set(gca,'FontSize',10)

clear p h j k

subplot(6,2,6)
[h, ~, ~, ~, ~] = al_goodplot(controlszneg,1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot(resectionsz1neg,3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot(resectionsz2neg,2,0.5,cols(3,:));
p = signrank(resectionsz1neg,resectionsz2neg);
if p<0.01
    sigstar([2,3])
end

title(strcat ('Eigenvector Centrality below z-score of -2 (p=',string(round(p,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Number of Nodes')
xlim([0.5 3.5])
set(gca,'FontSize',15)
xtickangle(20)
set(gca,'FontSize',10)

clear p h j k

clear resectionsz1neg resectionsz1pos resectionsz2neg resectionsz2pos controlszpos controlszneg


%lefficiency

for a = 1:length(controls)
    controlszpos(a) = sum(controls(a).zlefficiency > thresh);
    controlszneg(a) = sum(controls(a).zlefficiency < -thresh);
    
end

for a = 1:length(resections)
    resectionsz1pos(a) = sum(resections(a).zlefficiency1 > thresh);
    resectionsz1neg(a) = sum(resections(a).zlefficiency1 < -thresh);
    resectionsz2neg(a) = sum(resections(a).zlefficiency2 < -thresh);
    resectionsz2pos(a) = sum(resections(a).zlefficiency2 > thresh);
end

subplot(6,2,7)
[h, ~, ~, ~, ~] = al_goodplot(controlszpos,1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot(resectionsz1pos,3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot(resectionsz2pos,2,0.5,cols(3,:));
p = signrank(resectionsz1pos,resectionsz2pos);
if p<0.01
    sigstar([2,3])
end

title(strcat ('Local Efficiency above z-score of 2 (p=',string(round(p,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Number of Nodes')
xlim([0.5 3.5])
set(gca,'FontSize',15)
xtickangle(20)
set(gca,'FontSize',10)

clear p h j k

subplot(6,2,8)
[h, ~, ~, ~, ~] = al_goodplot(controlszneg,1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot(resectionsz1neg,3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot(resectionsz2neg,2,0.5,cols(3,:));
p = signrank(resectionsz1neg,resectionsz2neg);
if p<0.01
    sigstar([2,3])
end

title(strcat ('Local Efficiency below z-score of -2 (p=',string(round(p,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Number of Nodes')
xlim([0.5 3.5])
set(gca,'FontSize',15)
xtickangle(20)
set(gca,'FontSize',10)

clear p h j k

clear resectionsz1neg resectionsz1pos resectionsz2neg resectionsz2pos controlszpos controlszneg


%avecont

for a = 1:length(controls)
    controlszpos(a) = sum(controls(a).zavecont > thresh);
    controlszneg(a) = sum(controls(a).zavecont < -thresh);
    
end

for a = 1:length(resections)
    resectionsz1pos(a) = sum(resections(a).zavecont1 > thresh);
    resectionsz1neg(a) = sum(resections(a).zavecont1 < -thresh);
    resectionsz2neg(a) = sum(resections(a).zavecont2 < -thresh);
    resectionsz2pos(a) = sum(resections(a).zavecont2 > thresh);
end

subplot(6,2,9)
[h, ~, ~, ~, ~] = al_goodplot(controlszpos,1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot(resectionsz1pos,3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot(resectionsz2pos,2,0.5,cols(3,:));
p = signrank(resectionsz1pos,resectionsz2pos);
if p<0.01
    sigstar([2,3])
end

title(strcat ('Average Controllability above z-score of 2 (p=',string(round(p,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Number of Nodes')
xlim([0.5 3.5])
set(gca,'FontSize',15)
xtickangle(20)
set(gca,'FontSize',10)

clear p h j k

subplot(6,2,10)
[h, ~, ~, ~, ~] = al_goodplot(controlszneg,1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot(resectionsz1neg,3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot(resectionsz2neg,2,0.5,cols(3,:));
p = signrank(resectionsz1neg,resectionsz2neg);
if p<0.01
    sigstar([2,3])
end

title(strcat ('Average Controllability below z-score of -2 (p=',string(round(p,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Number of Nodes')
xlim([0.5 3.5])
set(gca,'FontSize',15)
xtickangle(20)
set(gca,'FontSize',10)

clear p h j k

clear resectionsz1neg resectionsz1pos resectionsz2neg resectionsz2pos controlszpos controlszneg

%modalcont

for a = 1:length(controls)
    controlszpos(a) = sum(controls(a).zmodalcont > thresh);
    controlszneg(a) = sum(controls(a).zmodalcont < -thresh);
    
end

for a = 1:length(resections)
    resectionsz1pos(a) = sum(resections(a).zmodalcont1 > thresh);
    resectionsz1neg(a) = sum(resections(a).zmodalcont1 < -thresh);
    resectionsz2neg(a) = sum(resections(a).zmodalcont2 < -thresh);
    resectionsz2pos(a) = sum(resections(a).zmodalcont2 > thresh);
end

subplot(6,2,11)
[h, ~, ~, ~, ~] = al_goodplot(controlszpos,1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot(resectionsz1pos,3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot(resectionsz2pos,2,0.5,cols(3,:));
p = signrank(resectionsz1pos,resectionsz2pos);
if p<0.01
    sigstar([2,3])
end

title(strcat ('Modal Controllability above z-score of 2 (p=',string(round(p,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Number of Nodes')
xlim([0.5 3.5])
set(gca,'FontSize',15)
xtickangle(20)
set(gca,'FontSize',10)

clear p h j k

subplot(6,2,12)
[h, ~, ~, ~, ~] = al_goodplot(controlszneg,1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot(resectionsz1neg,3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot(resectionsz2neg,2,0.5,cols(3,:));
p = signrank(resectionsz1neg,resectionsz2neg);
if p<0.01
    sigstar([2,3])
end

title(strcat ('Modal Controllability below z-score of -2 (p=',string(round(p,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Number of Nodes')
xlim([0.5 3.5])
set(gca,'FontSize',15)
xtickangle(20)
set(gca,'FontSize',10)

clear p h j k

clear resectionsz1neg resectionsz1pos resectionsz2neg resectionsz2pos controlszpos controlszneg

sgtitle('Number of Nodes with z-scores >2 or <-2')
set(gcf,'position',[0 0 800 1600])


%% Save

saveas(gcf,'PrelimFigs/Figure5.png')
