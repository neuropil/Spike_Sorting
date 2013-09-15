function [PeakData, PeakNames, PeakPars] = feature_Peak(V, ttChannelValidity, Params)

% MClust
% [PeakData, PeakNames] = feature_Peak(V, ttChannelValidity)
% Calculate peak feature max value for each channel
%
% INPUTS
%    V = TT tsd
%    ttChannelValidity = nCh x 1 of booleans
%
% OUTPUTS
%    Data - nSpikes x nCh peak values
%    Names - "Peak: Ch"
%
% ADR April 1998
% version M1.0
% RELEASED as part of MClust 2.0
% See standard disclaimer in Contents.m

% TTData = Data(V);
TTData=permute(V,[3,2,1]);

[nSpikes, nCh, nSamp] = size(TTData);

f = find(ttChannelValidity);

PeakData = zeros(nSpikes, length(f));
PeakNames = cell(length(f), 1);
PeakPars = {};
for iCh = 1:length(f)
	PeakData(:,iCh) = squeeze(max(TTData(:, f(iCh), 6:10), [], 3));
	PeakNames{iCh} = ['Peak:' num2str(f(iCh))];
    disp(['Peak--Channel:' num2str(f(iCh)) ' Extracted']);
end
