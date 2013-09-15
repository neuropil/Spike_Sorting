%% Cluster: Wrap the klustakwik to call in matlab to return the clustering of the spikes
% Using fet(feature) matrix to calculate clu(clustering) vector(label), and return both
% By Chongxi Lai
% Updated Wed Jul 17 14:55:05 EDT 2013

function [clu, nClu] = Cluster_K(filename, nFet, No, S_KlustaKwik, clufileReady)

%% Prepare clustering
% Input: suppose the file need to be clustered is test.fet.1
% 1. filename is the name of nttfile without '.ntt'
% 2. No is the No of feature matrix such as 1
% 3. S_KlustaKwik is the full path of KlustaKwik used to cluster
% 4. clufileReady: 0 means read .clu.1 file only; 1 means need to cluster with KlustaKwik
% Output:
% clu is the clu vector of the spikes(idx) [nSpikes*1]
% nClu is the number of cluster
featurecode='0';
for j=1:nFet
featurecode = ['1' featurecode];
end
% S_KlustaKwik = '~/Documents/MATLAB/Spike_sorting/Feature_Calibration/KlustaKwik/KlustaKwik';
CmdClu=[S_KlustaKwik ' ' filename ' ' num2str(No) ' -MinClusters ' num2str(15) ' -MaxClusters ' num2str(25) ' -MaxPossibleClusters ' num2str(28) ' -UseFeatures ' featurecode ' -Screen ' num2str(0)];

%% run KlustaKwik to do cluster
% comment this out if you've already *.clu.1 file there
if clufileReady==0
    system(CmdClu);
end

%% fetch the clustering label
name_clu = [filename '.clu.' num2str(No)];
clu = dlmread(name_clu);
% Note: the first element of fet matrix was nFet, which is already removed in readFet function
% Thus,
% 1. fet is nSpikes * nFet matrx
% 2. clu is nSpikes * 1 vector which label the cluster to which eachspikes belong
clu(1) = []; % delete first element of clu vector
nClu = length(unique(clu));
%% EXAMPLE:
% for input name:'test.fet.1', use:
% [clu,fet] = KlustaKwik('test',1);