%% plot_clu: plot spikes in feature space labelled by color of clustering
% By Chongxi Lai
% Updated Mon Jul 22 23:53:39 EDT 2013

function plot_isi(ISI)

[xout,n] = hist(log10(ISI),100);
xlabel = unique(fix(n));
j=1;
for i = min(xlabel):max(xlabel)
    time = (10^i)/1e3;
%     s_xlabel{j} = ['1e' num2str(i)];
    s_xlabel{j} = [num2str(time) ' ms'];
    j=j+1;
end
bar(n,xout)
set(gca,'XTick',xlabel);
set(gca,'XTickLabel',s_xlabel);
nSpikes = length(ISI)+1;
legend([num2str(nSpikes) ' Spikes']);
