% By Chongxi Lai
%% merge: merge mclu into similar clu in nclu
%
function [clu, nClu] = merge(clu, mclu, nclu, spikes)
% find and assign m -> n
% mclu is cluster of bad iso-dist, lratio but of good self-sim, which means it needs to be merged in other cluster
% nclu is of all good quality matrix
for m = mclu
	for n = nclu
		merge_ave_spike = mean([spikes{1}(:,clu==m); spikes{2}(:,clu==m); spikes{3}(:,clu==m); spikes{4}(:,clu==m)], 2);
		ave_spike = mean([spikes{1}(:,clu==n); spikes{2}(:,clu==n); spikes{3}(:,clu==n); spikes{4}(:,clu==n)], 2);
		if similarity(merge_ave_spike, ave_spike) > 0.63
			clu(find(clu==m)) = n;
		end
	end
end
nClu = length(unique(clu));
