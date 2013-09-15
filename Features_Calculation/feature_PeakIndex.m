function [PeakData, PeakNames] = feature_PeakIndex(V, ttChannelValidity)

% MClust
% [PeakData, PeakNames] = feature_PeakIndex(V, ttChannelValidity)
% Returns index of peak point for each channel
%
% INPUTS
%    V = TT tsd
%    ttChannelValidity = nCh x 1 of booleans
%
% OUTPUTS
%    Data - nSpikes x nCh peak values
%    Names - "Peak: Ch"
%

% ADR May 2002
% version M1.0
% RELEASED as part of MClust 3.0
% See standard disclaimer in Contents.m



% TTData = Data(V);
TTData=permute(V,[3,2,1]);

[nSpikes, nCh, nSamp] = size(TTData);

f = find(ttChannelValidity);

PeakData = zeros(nSpikes, length(f));

PeakNames = cell(length(f), 1);
PeakPars = {};

for iCh = 1:length(f)
    [m,im] = max(squeeze(TTData(:, iCh, :)), [], 2);
    PeakData(:, iCh)=shiftdim(im);
    PeakNames{iCh} = ['PeakIndex: ' num2str(f(iCh))];
end
PeakData = PeakData.*1e3;