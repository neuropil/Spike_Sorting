%% plot_clu: plot spikes in feature space labelled by color of clustering
% By Chongxi Lai
% Updated Mon Jul 18 16:01:03 EDT 2013

function plot_tetrode(Samples, clu, ISI, Timestamps_in_Clusters, cluster_chosen, quality_matrix, Intra_similarity)

set(gcf, 'position', [0 0 850 600]);
for electrodeNo = 1:4
    waveform = Samples(:, electrodeNo, clu==cluster_chosen);
    waveform = squeeze(waveform);     % plot can not plot 32*1*ncluster structure, spqueeze it to 32*ncluster
    subplot(3,2,electrodeNo);
    plot(waveform);
    ylim([-2e4 2e4]);
    h=legend(['iSim: ' num2str(Intra_similarity(cluster_chosen, electrodeNo))]);
    set(h,'Fontsize',10);
    title(['Cluster: ' num2str(cluster_chosen) ';  Electrode: ' num2str(electrodeNo)]);
end
subplot(3,2,5);
plot_isi(ISI{cluster_chosen});
subplot(3,2,6);
plot_autocorr(Timestamps_in_Clusters{cluster_chosen}, 120);
h=legend(['lRatio: ' num2str(quality_matrix(cluster_chosen,2)), '    ; cAc: ' num2str(quality_matrix(cluster_chosen,3))]);
set(h,'Fontsize',10);