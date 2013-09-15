function plot_autocorr(timestamps,range)
ac = cluster_autocorrelation(timestamps, range);
if(length(-range:range)==length(ac))
bar(-range:range,ac);
xlim([-range,range]);
ylim([0, max(ac)+1]);
xlabel('Time lags(msec)')
end
