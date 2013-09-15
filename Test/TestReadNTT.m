clc;clear;
[FileName,PathName] = uigetfile('*.ntt');
filename = [PathName FileName];
filename(end-3:end)='';
[TimeStamps, ScNumbers, CellNumbers, Params, DataPoints, header] =  getRawSE(filename);

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
        'Min',1,'Max',size(spikes,2)-2,'Value',41,...
        'Position', [200 10 180 20],...
        'Callback', {@spikeslide,spikes});   