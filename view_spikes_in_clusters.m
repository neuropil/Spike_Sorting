%% Read NTT and clu files

% 1. Read NTT
clc;clear;
[FileName,PathName] = uigetfile('*.ntt');
filename = [PathName FileName];
filename(end-3:end)='';
[TimeStamps, ScNumbers, CellNumbers, Params, DataPoints, header] =  getRawSE(filename);

% 2. Read .clu.1
[FileName,PathName] = uigetfile('*.clu.1');
name_clu = [PathName FileName];
clu = dlmread(name_clu);
clu(1) = []; % delete first element of clu vector
nClu = length(unique(clu));
if min(clu)==2;
    clu=clu-1;
end

% 3. Read .fet.1
[FileName,PathName] = uigetfile('*.fet.1');
name_fet = [PathName FileName];
[fet, nFet] = readFet(name_fet);
save lastfile;

% ------------------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------------------
%% View spikes in certain cluster
load lastfile % don't need to run the first part again
cluster = 2; % choose the cluster
idx=3; % idx is which spike in the chosen cluster needs to be viewed

%% View spikes in 4 electrodes, and slide through
figure
for tetrode=1:4
    subplot(2,2,tetrode)
    spikes = squeeze(DataPoints(:,tetrode,clu==cluster));
    plot(spikes);
    legend(['tetrode' num2str(tetrode) ' cluster' num2str(cluster) ' contains ' num2str(size(spikes,2)) ' spikes']);
end

figure
tetrode = 1;
spikes = squeeze(DataPoints(:,tetrode,clu==cluster));
subplot(211)
plot(spikes)
subplot(212)
plot(spikes(:,idx))
%% slide the spikes in the cluster
uicontrol('Style', 'slider',...
        'Min',1,'Max',size(spikes,2)-2,'Value',1,...
        'Position', [200 10 180 20],...
        'Callback', {@spikeslide,spikes});