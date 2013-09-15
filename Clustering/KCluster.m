%% Cluster: Wrap the Cluster_K to cluster fet into clu
% Using fet(feature) matrix to calculate clu(clustering) vector(label), and
% return clu and number of clus
% By Chongxi Lai
% Updated Saturday August 03 14:18:05 EDT 2013

function [clu, nClu] = KCluster(directory, filename, fet, S_KlustaKwik)
Outputfile = [directory filename '.fet.1']; % output fet.1 file, this is our target for KlustaKwik
nFet = size(fet,2); % number of feature dimensions
nSpikes = size(fet,1);
disp('Clustering-------------------------------------------------------------------------------------')
disp('0. KCluster starts... Wrapped with KlustaKwik core in Dr.Colonnese lab in GWU 2013');
% Prepare fet mat for python to transfer to fet.1 file
Outputmat = [directory filename '.mat'];
save(Outputmat,'nFet','fet'); 
disp('');
disp(['1. Matlab Wrote fet to ' Outputmat]);

% Prepare fet.1 file for clustering 
% Note: .mat file is the input of python script(wfet.py) for quick file writing of large data structure
% Thus there two mode below, choose one block to run (python/non-python)
cmd = ['python wfet.py' ' ' directory ' ' filename];
system(cmd);
disp(['2. Python transfer fet to ' Outputfile]);

fetfilename = [directory filename];
clufileReady = 0;  % 0 = need to run KlusterKwik; 1 = read existing clu file
disp(['3. KlustaKwik is acting on ' Outputfile]);
[clu, nClu] = Cluster_K(fetfilename, nFet, 1, S_KlustaKwik, clufileReady);
disp('4. Clustering done');

% Display results
disp('--------------------------------Clustering Report------------------------------------------')
disp(directory)
disp([filename ' is clustered in ' num2str(nFet) ' Feature Dimensions']);
disp(['There are ' num2str(nSpikes) ' spikes and ' num2str(nClu) ' clusters']);
disp('----------------------------------------------------------------------------------------------')
disp('');