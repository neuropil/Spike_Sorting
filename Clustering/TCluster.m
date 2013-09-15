% TCluster
% etos Wrapper
% By Chongxi Lai
% Sun Aug  4 21:35:01 EDT 2013
function [clu, nClu] = TCluster(filename, Gamma, Mu)

S_etos = './etos/etos3_for_ntt.sh';

if(strcmp(filename(end-3:end),'.ntt'))
    filename(end-3:end)='';
end

cmd = [S_etos ' ' filename ' ' num2str(Gamma) ' ' num2str(Mu)];
system(cmd);

name_clu = 'All.clu.1';
clu = dlmread(name_clu);
clu(1) = []; % delete first element of clu vector
nClu = length(unique(clu));

delete([filename '.model']);
delete([filename '.det']);
delete([filename '.cla.etos']);
delete([filename '.cla.kmeans']);
delete([filename '.ext']);
delete([filename '.ext.orig']);
delete([filename '.model.kmeans']);
delete([filename '.log']);
end
