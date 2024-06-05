%% Sensitivity Analysis 1 - across scales
% Set-up
% This script can be execited after 02_calculatemetrics as the graph
% metrics need to be calculated to run on different scales of connectomes

clc
clear all

cd('/Users/aswinchari/Desktop/GOSH/47. LongitudinalNetworks');

cols = cbrewer2('qual','Accent',3);

filelist = dir('Data/dataset*');
%% Calculate global metrics at all scales

for a = 1:length(filelist)
    
    disp(strcat('Working on:',filelist(a).name));
    
    %open file
    
    load(strcat(filelist(a).folder,'/',filelist(a).name));
    
    %get p values for global metrics
    
    %meandeg

    controltable = table([controls.age]',{controls.sex}',[controls.meandeg]','VariableNames', {'age' 'sex' 'meandeg'});
    resectiontable1 = table([resections.age1]',{resections.sex}',[resections.meandeg1]','VariableNames', {'age' 'sex' 'meandeg'});
    resectiontable2 = table([resections.age2]',{resections.sex}',[resections.meandeg2]','VariableNames', {'age' 'sex' 'meandeg'});
    model = fitglm(controltable);
    resectionfitted1 = predict(model,resectiontable1);
    resectionfitted2 = predict(model,resectiontable2);
    resectionresidual1 = [resections.meandeg1]' - resectionfitted1;
    resectionresidual2 = [resections.meandeg2]' - resectionfitted2;
    p(a,1) = signrank(resectionresidual1,resectionresidual2);

    clearvars -except controls resections cols filelist a p;

    %transitivity

    controltable = table([controls.age]',{controls.sex}',[controls.transitivity]','VariableNames', {'age' 'sex' 'transitivity'});
    resectiontable1 = table([resections.age1]',{resections.sex}',[resections.transitivity1]','VariableNames', {'age' 'sex' 'transitivity'});
    resectiontable2 = table([resections.age2]',{resections.sex}',[resections.transitivity2]','VariableNames', {'age' 'sex' 'transitivity'});
    model = fitglm(controltable);
    resectionfitted1 = predict(model,resectiontable1);
    resectionfitted2 = predict(model,resectiontable2);
    resectionresidual1 = [resections.transitivity1]' - resectionfitted1;
    resectionresidual2 = [resections.transitivity2]' - resectionfitted2;
    p(a,2) = signrank(resectionresidual1,resectionresidual2);

    clearvars -except controls resections cols filelist a p;
    
    %modularity

    controltable = table([controls.age]',{controls.sex}',[controls.modularity]','VariableNames', {'age' 'sex' 'modularity'});
    resectiontable1 = table([resections.age1]',{resections.sex}',[resections.modularity1]','VariableNames', {'age' 'sex' 'modularity'});
    resectiontable2 = table([resections.age2]',{resections.sex}',[resections.modularity2]','VariableNames', {'age' 'sex' 'modularity'});
    model = fitglm(controltable);
    resectionfitted1 = predict(model,resectiontable1);
    resectionfitted2 = predict(model,resectiontable2);
    resectionresidual1 = [resections.modularity1]' - resectionfitted1;
    resectionresidual2 = [resections.modularity2]' - resectionfitted2;
    p(a,3) = signrank(resectionresidual1,resectionresidual2);

    clearvars -except controls resections cols filelist a p;

    %gefficiency

    controltable = table([controls.age]',{controls.sex}',[controls.gefficiency]','VariableNames', {'age' 'sex' 'gefficiency'});
    resectiontable1 = table([resections.age1]',{resections.sex}',[resections.gefficiency1]','VariableNames', {'age' 'sex' 'gefficiency'});
    resectiontable2 = table([resections.age2]',{resections.sex}',[resections.gefficiency2]','VariableNames', {'age' 'sex' 'gefficiency'});
    model = fitglm(controltable);
    resectionfitted1 = predict(model,resectiontable1);
    resectionfitted2 = predict(model,resectiontable2);
    resectionresidual1 = [resections.gefficiency1]' - resectionfitted1;
    resectionresidual2 = [resections.gefficiency2]' - resectionfitted2;
    p(a,4) = signrank(resectionresidual1,resectionresidual2);

    clearvars -except controls resections cols filelist a p;

    %meanavecont

    controltable = table([controls.age]',{controls.sex}',[controls.meanavecont]','VariableNames', {'age' 'sex' 'meanavecont'});
    resectiontable1 = table([resections.age1]',{resections.sex}',[resections.meanavecont1]','VariableNames', {'age' 'sex' 'meanavecont'});
    resectiontable2 = table([resections.age2]',{resections.sex}',[resections.meanavecont2]','VariableNames', {'age' 'sex' 'meanavecont'});
    model = fitglm(controltable);
    resectionfitted1 = predict(model,resectiontable1);
    resectionfitted2 = predict(model,resectiontable2);
    resectionresidual1 = [resections.meanavecont1]' - resectionfitted1;
    resectionresidual2 = [resections.meanavecont2]' - resectionfitted2;
    p(a,5) = signrank(resectionresidual1,resectionresidual2);

    clearvars -except controls resections cols filelist a p;

    %meanmodalcont

    controltable = table([controls.age]',{controls.sex}',[controls.meanmodalcont]','VariableNames', {'age' 'sex' 'meanmodalcont'});
    resectiontable1 = table([resections.age1]',{resections.sex}',[resections.meanmodalcont1]','VariableNames', {'age' 'sex' 'meanmodalcont'});
    resectiontable2 = table([resections.age2]',{resections.sex}',[resections.meanmodalcont2]','VariableNames', {'age' 'sex' 'meanmodalcont'});
    model = fitglm(controltable);
    resectionfitted1 = predict(model,resectiontable1);
    resectionfitted2 = predict(model,resectiontable2);
    resectionresidual1 = [resections.meanmodalcont1]' - resectionfitted1;
    resectionresidual2 = [resections.meanmodalcont2]' - resectionfitted2;
    p(a,6) = signrank(resectionresidual1,resectionresidual2);

    clearvars -except cols filelist a p;         

end

%% change p 

pglobal = p;

clear p

%% Calculate z scores & burden of abnormal nodes at all scales

for z = 1:length(filelist)
    
    disp(strcat('Working on:',filelist(z).name));
    
    %open file
    
    load(strcat(filelist(z).folder,'/',filelist(z).name));
    
    labels = controls(1).connectome;

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

    clear a b
    
    % Find burden of abnormal nodes with these metrics

    thresh = 2;     %set threshold to different z-score if needed

    %degree

    for a = 1:length(controls)
        controlsz(a) = sum(abs(controls(a).zdegree) > thresh);
    end

    for a = 1:length(resections)
        resectionsz1(a) = sum(abs(resections(a).zdegree1) > thresh);
        resectionsz2(a) = sum(abs(resections(a).zdegree2) > thresh);
    end

    p(z,1) = signrank(resectionsz1,resectionsz2);

    clear controlsz resectionsz1 resectionsz2

    %eigencent

    for a = 1:length(controls)
        controlsz(a) = sum(abs(controls(a).zeigencent) > thresh);
    end

    for a = 1:length(resections)
        resectionsz1(a) = sum(abs(resections(a).zeigencent1) > thresh);
        resectionsz2(a) = sum(abs(resections(a).zeigencent2) > thresh);
    end

    p(z,3) = signrank(resectionsz1,resectionsz2);

    clear controlsz resectionsz1 resectionsz2

    %partcoef

    for a = 1:length(controls)
        controlsz(a) = sum(abs(controls(a).zpartcoef) > thresh);
    end

    for a = 1:length(resections)
        resectionsz1(a) = sum(abs(resections(a).zpartcoef1) > thresh);
        resectionsz2(a) = sum(abs(resections(a).zpartcoef2) > thresh);
    end

    p(z,2) = signrank(resectionsz1,resectionsz2);

    clear controlsz resectionsz1 resectionsz2

    %avecont

    for a = 1:length(controls)
        controlsz(a) = sum(abs(controls(a).zavecont) > thresh);
    end

    for a = 1:length(resections)
        resectionsz1(a) = sum(abs(resections(a).zavecont1) > thresh);
        resectionsz2(a) = sum(abs(resections(a).zavecont2) > thresh);
    end

    p(z,5) = signrank(resectionsz1,resectionsz2);
    
    clear controlsz resectionsz1 resectionsz2

    %modalcont

    for a = 1:length(controls)
        controlsz(a) = sum(abs(controls(a).zmodalcont) > thresh);
    end

    for a = 1:length(resections)
        resectionsz1(a) = sum(abs(resections(a).zmodalcont1) > thresh);
        resectionsz2(a) = sum(abs(resections(a).zmodalcont2) > thresh);
    end

    p(z,6) = signrank(resectionsz1,resectionsz2);

    clear controlsz resectionsz1 resectionsz2
    
    %lefficiency

    for a = 1:length(controls)
        controlsz(a) = sum(abs(controls(a).zlefficiency) > thresh);
    end

    for a = 1:length(resections)
        resectionsz1(a) = sum(abs(resections(a).zlefficiency1) > thresh);
        resectionsz2(a) = sum(abs(resections(a).zlefficiency2) > thresh);
    end

    p(z,4) = signrank(resectionsz1,resectionsz2);

    clear controlsz resectionsz1 resectionsz2

end

%% change p 

pburden = p;

%% Graph this

subplot(1,2,1)
imagesc(-log10(pglobal))
colorbar
xticks([1:6])
yticks([1:5])
xticklabels({'Mean Degree','Transitivity','Modularity','Global Efficiency','Mean Average Controllability','Mean Modal Controllability'})
yticklabels({'Scale 1', 'Scale 2','Scale 3','Scale 4','Scale 5',})
xtickangle(90)
caxis([0 2.2])
title('Change in Global Metrics')

subplot(1,2,2)
imagesc(-log10(pburden))
colorbar
xticks([1:6])
yticks([1:5])
xticklabels({'Degree','Participation Coefficient','Eigenvector Centrality','Local Efficiency','Average Controllability','Modal Controllability'})
yticklabels({'Scale 1', 'Scale 2','Scale 3','Scale 4','Scale 5',})
xtickangle(90)
caxis([0 2.2])
title('Change in Burden of Abnormal Nodes with Nodal Metrics')

sgtitle('Sensitivity Analysis Across 5 Lausanne Atlas Scales')
set(gcf,'position',[0 0 800 400])

%% Save

saveas(gcf,'PrelimFigs/SensAnal1.png')