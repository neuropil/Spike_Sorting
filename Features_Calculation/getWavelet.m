function [wavelet, l] = getWavelet(V, ttChannelValidity, level, motherwavelet)

TTData=permute(V,[3,2,1]);
[nspk, nCh, ls] = size(TTData);
f = find(ttChannelValidity);
wavelet = {};
cc=[];

for iC = 1:length(f)
    spikes = squeeze(TTData(:,f(iC),:));    % get data in nSpikes x nSamp array in iC Channel
    for i=1:nspk                                % Wavelet decomposition
        [c,l]=wavedec(spikes(i,:),level, motherwavelet);
        cc(i,:)=c;
    end
    wavelet{iC}=cc;
end