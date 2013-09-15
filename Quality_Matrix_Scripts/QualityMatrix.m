function [isoDist, lRatio, nSpikes_in_Clusters] = QualityMatrix(idx, fet)
%% load 1.idx from *.NTT  2.fet from *.fd
% idx is the N*1 vector indicate the number of cluster each spike belongs to
% fet is the N*D feature matrix: N is the amout of spikes, D is the dimention of feature vector
% max(idx) is the amout of clusters, because idx is a set that idx:{1,2,3,4,...max(idx)}
% For Mac OS X, 64 Bit
% [TimeStamps, ScNumbers, CellNumbers, Params, DataPoints,header] = getRawSE('TT3try2oldclu.ntt');
% For Windows 7 64 Bit

%% calculate the isoDist and lRatio
isoDist = zeros(1, max(idx) - min(idx) + 1); 
lRatio = zeros(1, max(idx)- min(idx) + 1);
nClu = zeros(1, max(idx) - min(idx) + 1);

for n = min(idx):max(idx)
    iCluster = find(idx==n);
    [rx,cx] = size(fet(iCluster,:));
    if rx > cx
        m = mahal(fet,fet(iCluster,:));
        isoDist(n) = IsolationDistance(fet,iCluster,m);
        lRatio(n) = L_Ratio(fet,iCluster,m);
        nClu(n) = size(iCluster,1);
    else
        isoDist(n) = 0;
        lRatio(n) = 1;
        nClu(n) = size(iCluster,1);
    end
end

nSpikes_in_Clusters = nClu;

% subplot(313)
% %% scatter tetrode spike vectors in feature space
% icluster = find(idx==9);
% ncluster = setdiff(1:size(fet,1), icluster);
% fd=1;
% scatter(fet(icluster,fd),fet(icluster,fd+5),10,'r+');
% hold on
% scatter(fet(ncluster,fd),fet(ncluster,fd+5),10,'bo');
% hold off
% legend('Cluster','Location','NW')

