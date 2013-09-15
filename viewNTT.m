[directory, filename, nttfilename, S_KlustaKwik] = set_nttfile(3);
[TimeStamps, ScNumbers, CellNumbers, Params, DataPoints, header] =  getRawSE(nttfilename);

tetrode = 1;
spikes = squeeze(DataPoints(:,tetrode,:));
figure
subplot(211)
plot(spikes);
legend(['tetrode' num2str(tetrode) ' contains ' num2str(size(spikes,2)) ' spikes']);
subplot(212)
plot(spikes)
%% slide the spikes in the cluster
uicontrol('Style', 'slider',...
        'Min', 1, 'Max', size(spikes,2)-2, 'Value', 41,...
        'Position', [200 10 180 20],...
        'Callback', {@spikeslide,spikes});
    