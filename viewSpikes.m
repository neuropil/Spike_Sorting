
% Prepare: Have Samples, clu in workspace
%% Change parameters
cluster = 4; % choose the cluster
tetrode = 2; % choose the electrode
idx=1; % idx is which spike in the chosen cluster needs to be viewed

%% Don't change this part
spikes = squeeze(Samples(:,tetrode,clu==cluster));
figure(1)
subplot(211)
plot(spikes);
legend(['tetrode' num2str(tetrode) ' cluster' num2str(cluster) ' contains ' num2str(size(spikes,2)) ' spikes']);
subplot(212)
plot(spikes(:,idx))

%% slide the spikes in the cluster
uicontrol('Style', 'slider',...
        'Min',1,'Max',size(spikes,2)-2,'Value',1,...
        'Position', [200 10 180 20],...
        'Callback', {@spikeslide,spikes});

