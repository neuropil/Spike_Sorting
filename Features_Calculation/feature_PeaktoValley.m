% Calculate the PCA Score for arbitrary matrix, core function build-in'pca'
% By Chongxi Lai
% Thu Jul 11 20:51:58 EDT 2013
function [PVData, PVName] = feature_PeaktoValley(V, ttChannelValidity)
%
% INPUTS
%    V = TT tsd
%    ttChannelValidity = nCh x 1 of booleans
%
% OUTPUTS
%    Data - nSpikes x nCh peak values
%    Names - "Peak: Ch"

TTData=permute(V,[3,2,1]);

[nSpikes, nCh, nSamp] = size(TTData);

f = find(ttChannelValidity);

PVData = zeros(nSpikes, length(f));

PVName = cell(length(f), 1);
PVData = squeeze(log10(abs(eps/2+max(TTData(:, f, :), [], 3))) - log10(abs(-eps/2+min(TTData(:, f, :), [], 3))));
PVData = PVData.*1e4;

for iCh = 1:length(f)
   PVName{iCh} = ['PVRatio: ' num2str(f(iCh))];
   disp(['Peak2Valley--Channel:' num2str(f(iCh)) ' Extracted']);
end
