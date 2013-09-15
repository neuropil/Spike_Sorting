function [output, cAc] = cluster_autocorrelation(Timestamps, range)
time = Timestamps-min(Timestamps);
binwidth = 1e3; % 1 msec bin
[spike_train,bin] = hist(time,(max(time)/binwidth)); 
% unique(round(diff(bin)))==binwidth;
% x is the 
[ac, lags] = xcorr(spike_train);
pos = find(lags==0); % pos is the central bin
ac(pos)=0;
if (pos-range) >= 0
    output = ac(pos-range:pos+range);
    if sum(ac(pos-2:pos+2)) < 1e-5
        cAc=0;
    else
        cAc = sum(ac(pos-2:pos+2))/sum(ac(pos-range:pos+range));
    end
else
    output = 0; cAc = 1;
end
