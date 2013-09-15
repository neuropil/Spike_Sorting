% Input: 
% 1. fet, clu
% 2. nttfilename = [directory filename]

%% 5. Cluster Galaxy Visualization
fig_galaxy = figure;
if nFet<3
    plot_clu(fet, clu, 2, 0);  %2 for 2d, 0 for no highlight cluster
else
    plot_clu(fet, clu, 3, 0);  %3 for 3d, 0 for no highlight cluster
end

%% 6. Quality Matrix, ISI distribution, Autocorrelation
% Input: 1. nttfilename; 2. clu; 3. fet
[TimeStamps, ScNumbers, CellNumbers, Features, Samples, Header] = ...
    getRawSE(nttfilename);
[Intrasim_score, Intra_similarity] = Intrasim(clu, Samples);
fig_quality = figure;
[quality_matrix, ISI, Timestamps_in_Clusters] = reportQuality(Samples, TimeStamps, fet, clu);
for cluNo = unique(clu)'
pb(cluNo) = uicontrol('Style', 'pushbutton', 'String', num2str(cluNo),...
        'Position', [25*cluNo 10 20 20]);
set(pb(cluNo),'Callback',...
    'buttonlist = get(pb, ''value''); No = find(cell2mat(buttonlist)==1); figure; plot_tetrode(Samples, clu, ISI, Timestamps_in_Clusters, No, quality_matrix, Intra_similarity); figure(fig_galaxy); cla; plot_clu(fet, clu, 3, No);');
end