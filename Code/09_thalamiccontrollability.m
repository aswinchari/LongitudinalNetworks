%% Set-up

clc
clear all

cd('/Users/aswinchari/Desktop/GOSH/47. LongitudinalNetworks');

load('Data/dataset_scale3.mat')     % Check this is the right scale

load('Data/labels_scale3.mat');     % Check labels correct    

cols = cbrewer2('qual','Accent',3);

%% Z score thalamic modal controllability only 
% Will be age and sex corrected 

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

%% Find change in Z scores of thalamic parcels between scans

for a = 1:length(resections)
    modalcontz1(a,:) = resections(a).zmodalcont1;
    modalcontz2(a,:) = resections(a).zmodalcont2;
    modalcontzdiff(a,:) = resections(a).zmodalcont1 - resections(a).zmodalcont2;
end

% isolate thalamus only 
modalcontz1 = modalcontz1(:,horzcat(109:115,233:239));
modalcontz2 = modalcontz2(:,horzcat(109:115,233:239));
modalcontzdiff = modalcontzdiff(:,horzcat(109:115,233:239));

%% Plot

for a = 1:14

    p = signrank(modalcontz1(:,a),modalcontz2(:,a));
    d = computeCohen_d(modalcontz1(:,a),modalcontz2(:,a),'paired');

    subplot(2,7,a)
    [k, ~, ~, ~, ~] = al_goodplot([modalcontz1(:,a)],2,0.5,cols(2,:));
    [j, ~, ~, ~, ~] = al_goodplot([modalcontz2(:,a)],1,0.5,cols(3,:));

    if p<0.01
        sigstar([1,2])
    end
    
    title(strcat('p=',string(round(p,2)),'; d=',string(round(d,2))))
    xticks([1,2])
    xticklabels({'Patients - Early','Patients - Late'});
    ylabel('Z-score')
    ylim([-4 3])
    xlim([0.2 2.8])

    
end

set(gcf,'position',[0 0 1600 600])

subplot(2,7,1)
text(-2.5,0.6,'Right Thalamic','FontWeight','bold')
text(-2.5,0.2,'Modal Controllability','FontWeight','bold')

subplot(2,7,8)
text(-2.5,0.6,'Left Thalamic','FontWeight','bold')
text(-2.5,0.2,'Modal Controllability','FontWeight','bold')

subplot(2,7,1)
text(1.5,4,'Pulvinar','HorizontalAlignment','center','FontWeight','bold')
subplot(2,7,2)
text(1.5,4,'Anterior','HorizontalAlignment','center','FontWeight','bold')
subplot(2,7,3)
text(1.5,4,'Medio-Dorsal','HorizontalAlignment','center','FontWeight','bold')
subplot(2,7,4)
text(1.5,4,'Ventral-Latero-Dorsal','HorizontalAlignment','center','FontWeight','bold')
subplot(2,7,5)
text(1.5,4,'Central-Lateral','HorizontalAlignment','center','FontWeight','bold')
subplot(2,7,6)
text(1.5,4,'Ventral-Anterior','HorizontalAlignment','center','FontWeight','bold')
subplot(2,7,7)
text(1.5,4,'Ventral-Lateral','HorizontalAlignment','center','FontWeight','bold')

%% Save

saveas(gcf,'PrelimFigs/ThalamicModalCont.png')
