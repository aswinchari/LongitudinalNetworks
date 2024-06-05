%% Set-up

clc
clear all

cd('/Users/aswinchari/Desktop/GOSH/47. LongitudinalNetworks');

filename = 'Data/dataset_scale3.mat';       % Check this is the right scale

load(filename); 

%% Zero the diagonals

for a = 1:length(controls)
    
    controls(a).connectome = controls(a).connectome - diag(diag(controls(a).connectome));
    
end

for a = 1:length(resections)
    
    resections(a).connectome1 = resections(a).connectome1 - diag(diag(resections(a).connectome1));
    resections(a).connectome2 = resections(a).connectome2 - diag(diag(resections(a).connectome2));
end

clear a

%% Calculate graph and controllability metrics - controls

for a = 1:length(controls)
    
    disp(strcat('Calculating Metrics:',string(controls(a).id)));
    
    A = controls(a).connectome;
    NormA = A./(1+svds(A,1));     % Matrix normalization 
    [U, T] = schur(NormA,'real'); % Schur stability
    
    % Calculaute avecont 
    
    midMat = (U.^2)';
    v = diag(T);
    P = repmat(diag(1 - v*v'),1,size(NormA,1));
    controls(a).avecont = sum(midMat./P)';
    controls(a).meanavecont = mean(controls(a).avecont);
    
    % Calculate modalcont 
    
    eigVals = diag(T);
    N = size(NormA,1);
    phi = zeros(N,1);
    for i = 1 : N
        phi(i) = (U(i,:).^2) * (1 - eigVals.^2);
    end
    controls(a).modalcont = phi;
    controls(a).meanmodalcont = mean(controls(a).modalcont);
    
    % calulate graph theory metrics
    
    [module,modularity] = community_louvain(controls(a).connectome);
    gefficiency = efficiency_wei(controls(a).connectome);
    partcoef = participation_coef(controls(a).connectome,module,0);
    degree = degrees_und(controls(a).connectome); 
    eigencent = eigenvector_centrality_und(controls(a).connectome);
    %clustercoef = clustering_coef_wu(weight_conversion(controls(a).connectome,'normalize'));
    lefficiency = efficiency_wei(controls(a).connectome,2);
    transitivity = transitivity_wu(controls(a).connectome);
    
   
    controls(a).module = module;
    controls(a).modularity = modularity;
    controls(a).gefficiency = gefficiency;
    controls(a).partcoef = partcoef;
    controls(a).degree = degree';
    controls(a).meandeg = mean(controls(a).degree);
    controls(a).eigencent = eigencent;
    %controls(a).clustercoef = clustercoef;
    controls(a).lefficiency = lefficiency;
    controls(a).transitivity = transitivity;
   
   clear modularity gefficiency module partcoef degree eigencent clustercoef transitivity lefficiency
    
end

clearvars -except controls resections filename;

% Calculate graph and controllability metrics - patients

% Connectome 1

for a = 1:length(resections)
    
    disp(strcat('Calculating Metrics 1:',string(resections(a).id)));
    
    A = resections(a).connectome1;
    NormA = A./(1+svds(A,1));     % Matrix normalization 
    [U, T] = schur(NormA,'real'); % Schur stability
    
    % Calculaute avecont 
    
    midMat = (U.^2)';
    v = diag(T);
    P = repmat(diag(1 - v*v'),1,size(NormA,1));
    resections(a).avecont1 = sum(midMat./P)';
    resections(a).meanavecont1 = mean(resections(a).avecont1);
    
    % Calculate modalcont 
    
    eigVals = diag(T);
    N = size(NormA,1);
    phi = zeros(N,1);
    for i = 1 : N
        phi(i) = (U(i,:).^2) * (1 - eigVals.^2);
    end
    resections(a).modalcont1 = phi;
    resections(a).meanmodalcont1 = mean(resections(a).modalcont1);
    
    % calulate graph theory metrics
    
    [module,modularity] = community_louvain(resections(a).connectome1);
    gefficiency = efficiency_wei(resections(a).connectome1);
    partcoef = participation_coef(resections(a).connectome1,module,0);
    degree = degrees_und(resections(a).connectome1); 
    eigencent = eigenvector_centrality_und(resections(a).connectome1);
    %clustercoef = clustering_coef_wu(weight_conversion(resections(a).connectome1,'normalize'));
    transitivity = transitivity_wu(resections(a).connectome1);
    lefficiency = efficiency_wei(resections(a).connectome1,2);
   
    resections(a).module1 = module;
    resections(a).modularity1 = modularity;
    resections(a).gefficiency1 = gefficiency;
    resections(a).partcoef1 = partcoef;
    resections(a).degree1 = degree';
    resections(a).meandeg1 = mean(resections(a).degree1);
    resections(a).eigencent1 = eigencent;
    %resections(a).clustercoef1 = clustercoef;
    resections(a).transitivity1 = transitivity;
    resections(a).lefficiency1 = lefficiency;
   
   clear modularity gefficiency module partcoef degree eigencent clustercoef transitivity lefficiency
    
end

clearvars -except controls resections filename;

% Connectome 2

for a = 1:length(resections)
    
    disp(strcat('Calculating Metrics 2:',string(resections(a).id)));
    
    A = resections(a).connectome2;
    NormA = A./(1+svds(A,1));     % Matrix normalization 
    [U, T] = schur(NormA,'real'); % Schur stability
    
    % Calculaute avecont 
    
    midMat = (U.^2)';
    v = diag(T);
    P = repmat(diag(1 - v*v'),1,size(NormA,1));
    resections(a).avecont2 = sum(midMat./P)';
    resections(a).meanavecont2 = mean(resections(a).avecont2);
    
    % Calculate modalcont 
    
    eigVals = diag(T);
    N = size(NormA,1);
    phi = zeros(N,1);
    for i = 1 : N
        phi(i) = (U(i,:).^2) * (1 - eigVals.^2);
    end
    resections(a).modalcont2 = phi;
    resections(a).meanmodalcont2 = mean(resections(a).modalcont2);
    
    % calulate graph theory metrics
    
    [module,modularity] = community_louvain(resections(a).connectome2);
    gefficiency = efficiency_wei(resections(a).connectome2);
    partcoef = participation_coef(resections(a).connectome2,module,0);
    degree = degrees_und(resections(a).connectome2); 
    eigencent = eigenvector_centrality_und(resections(a).connectome2);
    %clustercoef = clustering_coef_wu(weight_conversion(resections(a).connectome2,'normalize'));
    transitivity = transitivity_wu(resections(a).connectome2);
    lefficiency = efficiency_wei(resections(a).connectome2,2);
   
    resections(a).module2 = module;
    resections(a).modularity2 = modularity;
    resections(a).gefficiency2 = gefficiency;
    resections(a).partcoef2 = partcoef;
    resections(a).degree2 = degree';
    resections(a).meandeg2 = mean(resections(a).degree2);
    resections(a).eigencent2 = eigencent;
    %resections(a).clustercoef2 = clustercoef;
    resections(a).transitivity2 = transitivity;
    resections(a).lefficiency2 = lefficiency;
    
   
   clear modularity gefficiency module partcoef degree eigencent clustercoef transitivity lefficiency
    
end

clearvars -except controls resections filename;

% Save

save(filename,'controls','resections');

disp('done')