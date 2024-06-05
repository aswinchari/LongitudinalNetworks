%% Set-up

clc
clear all

cd('/Users/aswinchari/Desktop/GOSH/47. LongitudinalNetworks');

load('Data/dataset_scale5.mat') % Check this is the right scale

cols = cbrewer2('qual','Accent',3);

%% Age Comparisons

figure
hold on
[h, ~, ~, ~, ~] = al_goodplot([controls.age],1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot([resections.age1],3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot([resections.age2],2,0.5,cols(3,:));
for a = 1:length(resections) 
    plot([2,3], [resections(a).age2,resections(a).age1],'Color',(cols(2,:)+cols(3,:))/2);
end
title('Age distributions of Controls & Patients')
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Age')
set(gca,'FontSize',15)
set(gcf,'position',[0 0 600 600])

%% Save

saveas(gcf,'PrelimFigs/Figure1.png')

%% Global Metrics by Age

%meandeg

subplot(3,2,[1])
scatter([controls.age],[controls.meandeg],20,cols(1,:),'filled');
hold on
scatter([resections.age1],[resections.meandeg1],20,cols(2,:),'filled');
scatter([resections.age2],[resections.meandeg2],20,cols(3,:),'filled');
for a = 1:length(resections)
    plot([resections(a).age1,resections(a).age2], [resections(a).meandeg1,resections(a).meandeg2],'Color',(cols(2,:)+cols(3,:))/2);
end

meandeglm = fitlm([controls.age],[controls.meandeg]);
z = plot(meandeglm,'Color',cols(1,:));
for c=2:3
    z(c).Color = cols(1,:);
    z(c).LineWidth = 3;
end
delete(z(1));

title('Mean Degree');
xlabel('Age')
ylabel('Mean Degree')
legend('off')


%transitivity

subplot(3,2,[2])
scatter([controls.age],[controls.transitivity],20,cols(1,:),'filled');
hold on
scatter([resections.age1],[resections.transitivity1],20,cols(2,:),'filled');
scatter([resections.age2],[resections.transitivity2],20,cols(3,:),'filled');
for a = 1:length(resections)
    plot([resections(a).age1,resections(a).age2], [resections(a).transitivity1,resections(a).transitivity2],'Color',(cols(2,:)+cols(3,:))/2);
end

transitivitylm = fitlm([controls.age],[controls.transitivity]);
z = plot(transitivitylm,'Color',cols(1,:));
for c=2:3
    z(c).Color = cols(1,:);
    z(c).LineWidth = 3;
end
delete(z(1));

title('Transitivity');
xlabel('Age')
ylabel('Transitivity')
legend('off')

%modularity

subplot(3,2,3)
scatter([controls.age],[controls.modularity],20,cols(1,:),'filled');
hold on
scatter([resections.age1],[resections.modularity1],20,cols(2,:),'filled');
scatter([resections.age2],[resections.modularity2],20,cols(3,:),'filled');
for a = 1:length(resections)
    plot([resections(a).age1,resections(a).age2], [resections(a).modularity1,resections(a).modularity2],'Color',(cols(2,:)+cols(3,:))/2);
end

modularitylm = fitlm([controls.age],[controls.modularity]);
z = plot(modularitylm,'Color',cols(1,:));
for c=2:3
    z(c).Color = cols(1,:);
    z(c).LineWidth = 3;
end
delete(z(1));

title('Modularity');
xlabel('Age')
ylabel('Modularity')
legend('off')

%gefficiency

subplot(3,2,4)
scatter([controls.age],[controls.gefficiency],20,cols(1,:),'filled');
hold on
scatter([resections.age1],[resections.gefficiency1],20,cols(2,:),'filled');
scatter([resections.age2],[resections.gefficiency2],20,cols(3,:),'filled');
for a = 1:length(resections)
    plot([resections(a).age1,resections(a).age2], [resections(a).gefficiency1,resections(a).gefficiency2],'Color',(cols(2,:)+cols(3,:))/2);
end

gefficiencylm = fitlm([controls.age],[controls.gefficiency]);
z = plot(gefficiencylm,'Color',cols(1,:));
for c=2:3
    z(c).Color = cols(1,:);
    z(c).LineWidth = 3;
end
delete(z(1));

title('Global Efficiency');
xlabel('Age')
ylabel('Global Efficiency')
legend('off')

%meanavecont

subplot(3,2,5)
scatter([controls.age],[controls.meanavecont],20,cols(1,:),'filled');
hold on
scatter([resections.age1],[resections.meanavecont1],20,cols(2,:),'filled');
scatter([resections.age2],[resections.meanavecont2],20,cols(3,:),'filled');
for a = 1:length(resections)
    plot([resections(a).age1,resections(a).age2], [resections(a).meanavecont1,resections(a).meanavecont2],'Color',(cols(2,:)+cols(3,:))/2);
end

meanavecontlm = fitlm([controls.age],[controls.meanavecont]);
z = plot(meanavecontlm,'Color',cols(1,:));
for c=2:3
    z(c).Color = cols(1,:);
    z(c).LineWidth = 3;
end
delete(z(1));

title('Mean Average Controllability');
xlabel('Age')
ylabel('Mean Average Controllability')
legend('off')

%meanmodalcont

subplot(3,2,6)
scatter([controls.age],[controls.meanmodalcont],20,cols(1,:),'filled');
hold on
scatter([resections.age1],[resections.meanmodalcont1],20,cols(2,:),'filled');
scatter([resections.age2],[resections.meanmodalcont2],20,cols(3,:),'filled');
for a = 1:length(resections)
    plot([resections(a).age1,resections(a).age2], [resections(a).meanmodalcont1,resections(a).meanmodalcont2],'Color',(cols(2,:)+cols(3,:))/2);
end

meanmodalcontlm = fitlm([controls.age],[controls.meanmodalcont]);
z = plot(meanmodalcontlm,'Color',cols(1,:));
for c=2:3
    z(c).Color = cols(1,:);
    z(c).LineWidth = 3;
end
delete(z(1));

title('Mean Modal Controllability');
xlabel('Age')
ylabel('Mean Modal Controllability')
legend('off')

sgtitle('Global Graph Metrics of Controls & Patients')
set(gcf,'position',[0 0 800 1200])

%% Save

saveas(gcf,'PrelimFigs/Figure2.png')

%% Reset 

clearvars -except controls resections cols;

%% Residual comparison of Scan 1 and Scan 2 for Global Metrics

%meandeg

controltable = table([controls.age]',{controls.sex}',[controls.meandeg]','VariableNames', {'age' 'sex' 'meandeg'});
resectiontable1 = table([resections.age1]',{resections.sex}',[resections.meandeg1]','VariableNames', {'age' 'sex' 'meandeg'});
resectiontable2 = table([resections.age2]',{resections.sex}',[resections.meandeg2]','VariableNames', {'age' 'sex' 'meandeg'});
model = fitglm(controltable);
resectionfitted1 = predict(model,resectiontable1);
resectionfitted2 = predict(model,resectiontable2);
resectionresidual1 = [resections.meandeg1]' - resectionfitted1;
resectionresidual2 = [resections.meandeg2]' - resectionfitted2;
p = signrank(resectionresidual1,resectionresidual2);
d = computeCohen_d(resectionresidual1,resectionresidual2,'paired');
all(1,1)=p;
all(1,2)=d;

subplot(3,2,[1])
[h, ~, ~, ~, ~] = al_goodplot([model.Residuals.raw],1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot([resectionresidual1],3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot([resectionresidual2],2,0.5,cols(3,:));
if p<0.01
    sigstar([2,3])
end

title(strcat('Mean Degree (p=',string(round(p,2)),'; d=',string(round(d,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Residual')
xlim([0.5 3.5])

clearvars -except controls resections cols all;

%transitivity

controltable = table([controls.age]',{controls.sex}',[controls.transitivity]','VariableNames', {'age' 'sex' 'transitivity'});
resectiontable1 = table([resections.age1]',{resections.sex}',[resections.transitivity1]','VariableNames', {'age' 'sex' 'transitivity'});
resectiontable2 = table([resections.age2]',{resections.sex}',[resections.transitivity2]','VariableNames', {'age' 'sex' 'transitivity'});
model = fitglm(controltable);
resectionfitted1 = predict(model,resectiontable1);
resectionfitted2 = predict(model,resectiontable2);
resectionresidual1 = [resections.transitivity1]' - resectionfitted1;
resectionresidual2 = [resections.transitivity2]' - resectionfitted2;
p = signrank(resectionresidual1,resectionresidual2);
d = computeCohen_d(resectionresidual1,resectionresidual2,'paired');
all(2,1)=p;
all(2,2)=d;

subplot(3,2,[2])
[h, ~, ~, ~, ~] = al_goodplot([model.Residuals.raw],1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot([resectionresidual1],3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot([resectionresidual2],2,0.5,cols(3,:));
if p<0.01
    sigstar([2,3])
end

title(strcat('Transitivity (p=',string(round(p,2)),'; d=',string(round(d,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Residual')
xlim([0.5 3.5])

clearvars -except controls resections cols all;

%modularity

controltable = table([controls.age]',{controls.sex}',[controls.modularity]','VariableNames', {'age' 'sex' 'modularity'});
resectiontable1 = table([resections.age1]',{resections.sex}',[resections.modularity1]','VariableNames', {'age' 'sex' 'modularity'});
resectiontable2 = table([resections.age2]',{resections.sex}',[resections.modularity2]','VariableNames', {'age' 'sex' 'modularity'});
model = fitglm(controltable);
resectionfitted1 = predict(model,resectiontable1);
resectionfitted2 = predict(model,resectiontable2);
resectionresidual1 = [resections.modularity1]' - resectionfitted1;
resectionresidual2 = [resections.modularity2]' - resectionfitted2;
p = signrank(resectionresidual1,resectionresidual2);
d = computeCohen_d(resectionresidual1,resectionresidual2,'paired');
all(3,1)=p;
all(3,2)=d;

subplot(3,2,[3])
[h, ~, ~, ~, ~] = al_goodplot([model.Residuals.raw],1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot([resectionresidual1],3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot([resectionresidual2],2,0.5,cols(3,:));
if p<0.01
    sigstar([2,3])
end

title(strcat('Modularity (p=',string(round(p,2)),'; d=',string(round(d,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Residual')
xlim([0.5 3.5])

clearvars -except controls resections cols all;

%gefficiency

controltable = table([controls.age]',{controls.sex}',[controls.gefficiency]','VariableNames', {'age' 'sex' 'gefficiency'});
resectiontable1 = table([resections.age1]',{resections.sex}',[resections.gefficiency1]','VariableNames', {'age' 'sex' 'gefficiency'});
resectiontable2 = table([resections.age2]',{resections.sex}',[resections.gefficiency2]','VariableNames', {'age' 'sex' 'gefficiency'});
model = fitglm(controltable);
resectionfitted1 = predict(model,resectiontable1);
resectionfitted2 = predict(model,resectiontable2);
resectionresidual1 = [resections.gefficiency1]' - resectionfitted1;
resectionresidual2 = [resections.gefficiency2]' - resectionfitted2;
p = signrank(resectionresidual1,resectionresidual2);
d = computeCohen_d(resectionresidual1,resectionresidual2,'paired');
all(4,1)=p;
all(4,2)=d;

subplot(3,2,[4])
[h, ~, ~, ~, ~] = al_goodplot([model.Residuals.raw],1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot([resectionresidual1],3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot([resectionresidual2],2,0.5,cols(3,:));
if p<0.01
    sigstar([2,3])
end

title(strcat('Global Efficiency (p=',string(round(p,2)),'; d=',string(round(d,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Residual')
xlim([0.5 3.5])

clearvars -except controls resections cols all;

%meanavecont

controltable = table([controls.age]',{controls.sex}',[controls.meanavecont]','VariableNames', {'age' 'sex' 'meanavecont'});
resectiontable1 = table([resections.age1]',{resections.sex}',[resections.meanavecont1]','VariableNames', {'age' 'sex' 'meanavecont'});
resectiontable2 = table([resections.age2]',{resections.sex}',[resections.meanavecont2]','VariableNames', {'age' 'sex' 'meanavecont'});
model = fitglm(controltable);
resectionfitted1 = predict(model,resectiontable1);
resectionfitted2 = predict(model,resectiontable2);
resectionresidual1 = [resections.meanavecont1]' - resectionfitted1;
resectionresidual2 = [resections.meanavecont2]' - resectionfitted2;
p = signrank(resectionresidual1,resectionresidual2);
d = computeCohen_d(resectionresidual1,resectionresidual2,'paired');
all(5,1)=p;
all(5,2)=d;

subplot(3,2,[5])
[h, ~, ~, ~, ~] = al_goodplot([model.Residuals.raw],1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot([resectionresidual1],3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot([resectionresidual2],2,0.5,cols(3,:));
if p<0.01
    sigstar([2,3])
end

title(strcat('Mean Average Controllability (p=',string(round(p,2)),'; d=',string(round(d,2)),')'))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Residual')
xlim([0.5 3.5])

clearvars -except controls resections cols all;

%meanmodalcont

controltable = table([controls.age]',{controls.sex}',[controls.meanmodalcont]','VariableNames', {'age' 'sex' 'meanmodalcont'});
resectiontable1 = table([resections.age1]',{resections.sex}',[resections.meanmodalcont1]','VariableNames', {'age' 'sex' 'meanmodalcont'});
resectiontable2 = table([resections.age2]',{resections.sex}',[resections.meanmodalcont2]','VariableNames', {'age' 'sex' 'meanmodalcont'});
model = fitglm(controltable);
resectionfitted1 = predict(model,resectiontable1);
resectionfitted2 = predict(model,resectiontable2);
resectionresidual1 = [resections.meanmodalcont1]' - resectionfitted1;
resectionresidual2 = [resections.meanmodalcont2]' - resectionfitted2;
p = signrank(resectionresidual1,resectionresidual2);
d = computeCohen_d(resectionresidual1,resectionresidual2,'paired');
all(6,1)=p;
all(6,2)=d;

subplot(3,2,[6])
[h, ~, ~, ~, ~] = al_goodplot([model.Residuals.raw],1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot([resectionresidual1],3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot([resectionresidual2],2,0.5,cols(3,:));
if p<0.01
    sigstar([2,3])
end

title(strcat('Mean Modal Controllability (p=',string(round(p,2)),'; d=',string(round(d,2)),')'));
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Residual')
xlim([0.5 3.5])

clearvars -except controls resections cols all;

sgtitle('Age and Sex Adjusted Residuals of Graph Metrics')
set(gcf,'position',[0 0 800 1200])

%% Save

saveas(gcf,'PrelimFigs/Figure3.png')
