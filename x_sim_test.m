% Prepare: Have Samples, clu in workspace
%% Change parameters
tetrode = 4; % choose the electrode;
nClu = size(unique(clu),1);
x_matrix = zeros(nClu,nClu);
for cluster = 1:nClu; % choose the cluster
for refClu = 1:cluster-1; % reference cluster for cross similarity

idx=3; % idx is which spike in the chosen cluster needs to be viewed

%% Don't change this part
spikes = squeeze(Samples(:,tetrode,clu==cluster));
refspikes = squeeze(Samples(:,tetrode,clu==refClu));
m_spike = mean(spikes,2);
m_ref = mean(refspikes,2);
x_sim = similarity(m_spike, m_ref);
x_matrix(cluster, refClu) = x_sim;

if(x_sim>0.00 && cluster~=refClu)
    figure
    subplot(211)
    plot(spikes);
    legend(['tetrode' num2str(tetrode) ' cluster' num2str(cluster) ' contains ' num2str(size(spikes,2)) ' spikes']);
    subplot(212)
    hold on;
    plot(m_spike);
    plot(m_ref);
    legend(['Cluster=' num2str(cluster) '    Ref Cluster=' num2str(refClu) '    Similarity=' num2str(x_sim)]);
    hold off;
    disp(['Cluster=' num2str(cluster) '    Ref Cluster=' num2str(refClu) '    Similarity=' num2str(x_sim)]);
%% slide the spikes in the cluster
    uicontrol('Style', 'slider',...
            'Min',1,'Max',size(spikes,2)-2,'Value',1,...
            'Position', [200 10 180 20],...
            'Callback', {@spikeslide,spikes});
   
end 
end
end