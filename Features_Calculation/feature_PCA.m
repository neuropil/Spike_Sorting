% Calculate the PCA Score for arbitrary matrix, core function build-in'pca'
% By Chongxi Lai
% Mon Jul 8 08:38:22 EDT 2013
% For PCA Analysis, refer to: http://www.mathworks.com/help/stats/feature-transformation.html#zmw57dd0e37106
function [PCA, PCAName] = feature_PCA(V, ttChannelValidity, PCANo)

% INPUTS:
%    V = DataPoints nSample(32)*nChannel(4)*nSpikes(61439 for example), need to be permuted
%    ttChannelValidity = 1 * nChannel of booleans: [1 1 1 1] for tetrode
%    PCANo: 1 for PCA1, 2 for PCA2

% OUTPUTS:
%    PCA is nSpikes*nChannel(4) in which each column represents the position of that channel of Spikes in the principal component space.
%    PCAName is nChannel * 1 name of output

%%   Set the stage:
TTData=permute(V,[3,2,1]);
[nSpikes, nCh, nSamp] = size(TTData);
f = find(ttChannelValidity);
lf = length(f);
PCAName = cell(lf, 1);
PCA  = zeros(nSpikes, lf);

%%  Calculate PCA and put it into PCA(:,iC) for all iC channel.
for iC = 1:lf
%%  1.Extract the nSpikes * nSamp(32) array for 1:4 Channel
    w = squeeze(TTData(:,f(iC),:));    % get data in nSpikes x nSamp array in iC Channel
    
%%  2.Calculate the PCA score for the array
    [coeff,score,latent,tsquared] = pca(w);
    
%%  3.Pick the PCANo column, which is PCANo st Principal Component

%   [COEFF, SCORE] = PCA(X) returns the principal component score, which is
%   the representation of X in the principal component space. Rows of SCORE
%   correspond to observations, columns to components. The centered data
%   can be reconstructed by SCORE*COEFF'.
    PCA(:,iC) = - score(:,PCANo);
    PCAName{iC} = ['PCA' num2str(PCANo-1) ':' num2str(f(iC))]; 
    disp(['PCA' num2str(PCANo-1) '--Channel:' num2str(f(iC)) ' Extracted']);
end
