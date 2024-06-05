%% Set-up

clc
clear all

cd('/Users/aswinchari/Desktop/GOSH/47. LongitudinalNetworks');

load('Data/dataset_scale3.mat') % Check this is the right scale

cols = cbrewer2('qual','Accent',3);

%% Assign thalamic connectivity

%           Right               Left
%Frontal    1-41                125-165
%Parietal   42-71               166-195
%Occipital  72-87               196-211
%Temporal   88-105 + 120-123    212-229 +  244-247
%Insula     106-108             230-232
%Thalamus   109-115             233-239

lobes{1} = (1:41);
lobes{2} = (42:71);
lobes{3} = (72:87);
lobes{4} = horzcat(88:105,120:123);
lobes{5} = (106:108);
lobes{6} = (125:165);
lobes{7} = (166:195);
lobes{8} = (196:211);
lobes{9} = horzcat(212:229,244:247);
lobes{10} = (230:232);

thalamusr = (109:115);
thalamusl = (233:239);

% matrix for thalamus-lobe connectivity

% controls

for a=1:length(controls)
    for b=1:5
        controlsthalconn(a,b) = sum(sum(controls(a).connectome(thalamusr,lobes{b})));
    end
        for b=6:10
        controlsthalconn(a,b) = sum(sum(controls(a).connectome(thalamusl,lobes{b})));
    end
end

% resections

for a=1:length(resections)
    for b=1:5
        resections1thalconn(a,b) = sum(sum(resections(a).connectome1(thalamusr,lobes{b})));
    end
        for b=6:10
        resections1thalconn(a,b) = sum(sum(resections(a).connectome1(thalamusl,lobes{b})));
    end
end

for a=1:length(resections)
    for b=1:5
        resections2thalconn(a,b) = sum(sum(resections(a).connectome2(thalamusr,lobes{b})));
    end
        for b=6:10
        resections2thalconn(a,b) = sum(sum(resections(a).connectome2(thalamusl,lobes{b})));
    end
end

clear a b 

%% Z score lobar-thalamic connectivity and plot

for b = 1:10

controltable = table([controls.age]',{controls.sex}',controlsthalconn(:,b),'VariableNames', {'age' 'sex' 'conn'});
resectiontable1 = table([resections.age1]',{resections.sex}',resections1thalconn(:,b),'VariableNames', {'age' 'sex' 'conn'});
resectiontable2 = table([resections.age2]',{resections.sex}',resections2thalconn(:,b),'VariableNames', {'age' 'sex' 'conn'});
model = fitglm(controltable);
resectionfitted1 = predict(model,resectiontable1);
resectionfitted2 = predict(model,resectiontable2);
resectionresidual1 = resections1thalconn(:,b) - resectionfitted1;
resectionresidual2 = resections2thalconn(:,b) - resectionfitted2;

[controlsz,mu,sig] = zscore([model.Residuals.raw]);
resectionsz1 = (resectionresidual1 - mu)/sig;
resectionsz2 = (resectionresidual2 - mu)/sig;

p = signrank(resectionsz1,resectionsz2);
d = computeCohen_d(resectionsz1,resectionsz2,'paired');
all(b,1)=p;
all(b,2)=d;

% plot

subplot(2,5,b)
[h, ~, ~, ~, ~] = al_goodplot([controlsz],1,0.5,cols(1,:));
[j, ~, ~, ~, ~] = al_goodplot([resectionsz1],3,0.5,cols(2,:));
[k, ~, ~, ~, ~] = al_goodplot([resectionsz2],2,0.5,cols(3,:));
if p<0.01
    sigstar([2,3])
end

title(strcat('p=',string(round(p,2)),'; d=',string(round(d,2))))
xticks([1,2,3])
xticklabels({'Controls','Patients - Early','Patients - Late'});
ylabel('Z-score')
xlim([0.5 3.5])
ylim([-3 4.5])

% Put z-scores into separate container

controlsthalz(:,b) = controlsz;
resections1thalz(:,b) = resectionsz1;
resections2thalz(:,b) = resectionsz2;

clearvars -except controls resections cols all controlsthalconn resections2thalconn resections1thalconn lobes thalamusl thalamusr resections2thalz resections1thalz controlsthalz;

end

set(gcf,'position',[0 0 1600 600])

subplot(2,5,1)
text(-2,0.6,'Right Thalamocortical','FontWeight','bold')
text(-2,0.25,'Connectivity','FontWeight','bold')

subplot(2,5,6)
text(-2,0.6,'Left Thalamocortical','FontWeight','bold')
text(-2,0.25,'Connectivity','FontWeight','bold')

subplot(2,5,1)
text(2,5.5,'Frontal Lobe','HorizontalAlignment','center','FontWeight','bold')
subplot(2,5,2)
text(2,5.5,'Parietal Lobe','HorizontalAlignment','center','FontWeight','bold')
subplot(2,5,3)
text(2,5.5,'Occipital Lobe','HorizontalAlignment','center','FontWeight','bold')
subplot(2,5,4)
text(2,5.5,'Temporal Lobe','HorizontalAlignment','center','FontWeight','bold')
subplot(2,5,5)
text(2,5.5,'Insula','HorizontalAlignment','center','FontWeight','bold')
%% Save

saveas(gcf,'PrelimFigs/Lobes.png')


%% Is connectivity change to implicated lobes different to lobes chosen at random?

% Add in lobar involvement & code the lobe 'number' from 1:10

load('Data/resectionlobes.mat');

for a = 1:length(resectionlobes)

      if resectionlobes(a).laterality == 'R'
          resectionlobes(a).lat = 0;
      else resectionlobes(a).lat = 5;
      end

      if resectionlobes(a).lobe == string('Frontal')
          resectionlobes(a).lob = 1;
      elseif resectionlobes(a).lobe == string('Parietal')
          resectionlobes(a).lob = 2;
      elseif resectionlobes(a).lobe == string('Occipital')
          resectionlobes(a).lob = 3;
      elseif resectionlobes(a).lobe == string('Temporal')
          resectionlobes(a).lob = 4;
      elseif resectionlobes(a).lobe == string('Insula')
          resectionlobes(a).lob = 5;
      end

      resections(a).lobescore = resectionlobes(a).lat + resectionlobes(a).lob;
end

clear resectionlobes

% Create struct of z score differences of affected lobe vs randomly chosen permutations

resectionsthalzdiff = resections1thalz - resections2thalz;

for a = 1:length(resections)
    thalzdiff(a,1) = resectionsthalzdiff(a,resections(a).lobescore);
end

% Create a z-of-z score and test if different from 0

for a = 1:length(resections)
    [~,mu,sig] = zscore(resectionsthalzdiff(a,:));
    zofz(a,1) = (thalzdiff(a,1) - mu)/sig;
    clear mu sig
end

% Plot (not included in manuscript)
 
[k, ~, ~, ~, ~] = al_goodplot([zofz],1,0.5);

[h,p] = ttest(zofz);









