function [PVData, PVName] = feature_PeakValleyRatio(V, ttChannelValidity)

% MClust
% [PvData, PvNames] = feature_PeakValleyRatio(V, ttChannelValidity)
% Calculate PeakValleyRatio feature max value for each channel
%
% INPUTS
%    V = TT tsd
%    ttChannelValidity = nCh x 1 of booleans
%
% OUTPUTS
%    Data - nSpikes x nCh pv values
%    Names - "PeakValleyRatio: Ch"
%
% ADR April 1998
%
% Status: PROMOTED (Release version) 
% See documentation for copyright (owned by original authors) and warranties (none!).
% This code released as part of MClust 3.0.
% Version control M3.0.


TTData=permute(V,[3,2,1]);

[nSpikes, nCh, nSamp] = size(TTData);

f = find(ttChannelValidity);

PVData = zeros(nSpikes, length(f));

PVName = cell(length(f), 1);
PVData = squeeze(log10(abs(eps/2+max(TTData(:, f, :), [], 3))) - log10(abs(-eps/2+min(TTData(:, f, :), [], 3))));

for iCh = 1:length(f)
   PVName{iCh} = ['PVRatio: ' num2str(f(iCh))];
   disp(['Peak2Valley--Channel:' num2str(f(iCh)) ' Extracted']);
end
