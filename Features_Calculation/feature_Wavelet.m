function [WavData, WavName] = feature_Wavelet(V, ttChannelValidity, inputs)

scales = 5;
TTData=permute(V,[3,2,1]);
[nSpikes, nCh, nSamp] = size(TTData);
nspk = nSpikes;
f = find(ttChannelValidity);
WavName = cell(length(f), 1);
cc=[];

for iC = 1:length(f)
    spikes = squeeze(TTData(:,f(iC),:));    % get data in nSpikes x nSamp array in iC Channel
    for i=1:nspk                                % Wavelet decomposition
        [c,l]=wavedec(spikes(i,:),scales,'dmey');
        cc(i,:)=c(1,:);
        ls = sum(l)-32;
    end
        for i=1:ls                                  % KS test for coefficient selection   
            thr_dist = std(cc(:,i)) * 3;
            thr_dist_min = mean(cc(:,i)) - thr_dist;
            thr_dist_max = mean(cc(:,i)) + thr_dist;
            aux = cc((cc(:,i)>thr_dist_min & cc(:,i)<thr_dist_max),i);
                if length(aux) > 10;
                    [ksstat]=test_ks(aux);
                    sd(i)=ksstat;
                else
                    sd(i)=0;
                end
        end
        [max_, ind]=sort(sd);
        coeff(1:inputs)=ind(ls:-1:ls-inputs+1);
        inspk = zeros(nspk,inputs);
        for j=1:inputs
            inspk(:,j)=cc(:,coeff(j));
        end
    WavData(:,iC) = inspk(:,inputs);
	WavName{iC} = ['Wavelet' num2str(inputs) ':' num2str(f(iC))];
    disp(['Wavelet' num2str(inputs) '--Channel:' num2str(f(iCh)) ' Extracted']);
end
