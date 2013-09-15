%% 1. Load Cluster: select your clu.1 file

[FileName,PathName] = uigetfile('*.clu.1');
name_clu = [PathName FileName];
clu = dlmread(name_clu);
clu(1) = []; % delete first element of clu vector
nClu = length(unique(clu));
if min(clu)==2;
    clu=clu-1;
end
clu = dlmread(name_clu);
clu(1) = []; % delete first element of clu vector
nClu = length(unique(clu));
if min(clu)==2;
    clu=clu-1;
end

%% 2. Load Feature: select your fet.1 file
[FileName,PathName] = uigetfile('*.fet.1');
name_fet = [PathName FileName];
[fet, nFet] = readFet(name_fet);
fet(:,13)=[];
save lastfile;

%% 3. Select NTT file
% [filename,directory] = uigetfile('*.ntt');
% filename(end-3:end)='';
% nttfilename = [directory filename];

%% 3. Galaxy Visualization
fig_galaxy = figure;
if nFet<3
    plot_clu(fet, clu, 2, 0);  %2 for 2d, 0 for no highlight cluster
else
    plot_clu(fet, clu, 3, 0);  %3 for 3d, 0 for no highlight cluster
end


%% 4. Display information
disp(directory)
disp([filename ' is clustered in ' num2str(nFet) ' Feature Dimensions']);
disp(['There are ' num2str(nSpikes) ' spikes']);
disp(['Clustered into ' num2str(nClu) ' clusters']);

%% 5. Quality Matrix
% Input: 1. nttfilename; 2. clu; 3. fet

% a. ISO-Distance, L-Ratio, nSpikes
[TimeStamps, ScNumbers, CellNumbers, Features, Samples, Header] = ...
    getRawSE(nttfilename);
[isoDist, lRatio, nSpikes_in_Clusters] = QualityMatrix(clu, fet);

% b. ISI Distribution
Timestamps_in_Clusters = {};
ISI = {};
for cluster_chosen = min(clu):max(clu)
    Timestamps_in_Clusters{cluster_chosen} = TimeStamps(clu==cluster_chosen);
    ISI{cluster_chosen} = diff(Timestamps_in_Clusters{cluster_chosen});
end

% c. Autocorrelation
auto_correlation = {};
cAc=[];
for cluster_chosen = min(clu):max(clu)
    [auto_correlation{cluster_chosen}, cAc(cluster_chosen)] = cluster_autocorrelation(Timestamps_in_Clusters{cluster_chosen}, 120);
end

% d. Concatenate the quality_matrix and plot it
quality_matrix = [isoDist' lRatio' cAc' nSpikes_in_Clusters'];
fig_quality = figure;

subplot(411)
bar(quality_matrix(:,1))
for i = 1:length(quality_matrix(:,1))
if quality_matrix(i,1) > 20   % criteria
    text(i,quality_matrix(i,1)+5.5,'*', 'FontSize', 14, 'Color', 'r');
end
end
title('Iso-Distance');

subplot(412)
bar(quality_matrix(:,2))
for i = 1:length(quality_matrix(:,2))
if quality_matrix(i,2) < 0.4   % criteria
    text(i,quality_matrix(i,2)+1.5,'*', 'FontSize', 14, 'Color', 'r');
end
end
title('L-Ratio');

subplot(413)
bar(quality_matrix(:,3))
for i = 1:length(quality_matrix(:,3))
if quality_matrix(i,3) < 0.02   % criteria
    text(i,quality_matrix(i,3)+0.01,'*', 'FontSize', 14, 'Color', 'r');
end
end
title('C-Autocorr')

subplot(414)
bar(quality_matrix(:,4))
for i = 1:length(quality_matrix(:,4))
if quality_matrix(i,4) > 100    % criteria
    text(i,quality_matrix(i,4)+1.5,'*', 'FontSize', 14, 'Color', 'r');
end
end
title('Number of Spikes');

save(Outputmat,'nSpikes','nFet','nClu','fet','clu','FName','isoDist','lRatio','cAc','nSpikes_in_Clusters',...
    'ISI','TimeStamps','Samples','Header','quality_matrix'); 
disp('');
disp(['Wrote ' Outputmat]);

for cluNo=min(clu):max(clu)
pb(cluNo) = uicontrol('Style', 'pushbutton', 'String', num2str(cluNo),...
        'Position', [25*cluNo 10 20 20]);
set(pb(cluNo),'Callback',...
    'buttonlist = get(pb, ''value''); No = find(cell2mat(buttonlist)==1); plot_tetrode(Samples, clu, ISI, Timestamps_in_Clusters, No); figure(fig_galaxy); cla; plot_clu(fet, clu, 3, No);');
end


%% 6. Display Waveform
% Input: 1. Samples; 2. clu; 3. ISI; 4.Timestamps_in_Clusters; 5.quality_matrix
for cluster_chosen = min(clu):max(clu)
    i = cluster_chosen;
    if quality_matrix(i,2) < 0.5 && quality_matrix(i,3) < 0.02 % plot good cluster
        nSpikes_in_clu = plot_tetrode(Samples, clu, ISI, Timestamps_in_Clusters, cluster_chosen, quality_matrix);
        disp(['Display cluster ' num2str(cluster_chosen)]);
        disp(['There are ' num2str(nSpikes_in_clu) ' spikes in this cluster']);
        print(gcf,'-dpng',[nttfilename '_clu' num2str(cluster_chosen) '.png']);
    end
end

%% 7. Save Pictures
print(fig_galaxy,'-dpng',[nttfilename '_galaxy.png']);
print(fig_quality,'-dpng',[nttfilename '_quality.png']);
