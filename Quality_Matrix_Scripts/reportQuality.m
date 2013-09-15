% Report the quality of clustering, ISI distribution, Central bin of autocorrelation
% Plot the report and 
% By Chongxi Lai
% Updated Saturday August 03 15:03:09 EDT 2013

function [quality_matrix, ISI, Timestamps_in_Clusters] = reportQuality(Samples, TimeStamps, fet, clu)

% a: ISO-Distance, L-Ratio, nSpikes
[isoDist, lRatio, nSpikes_in_Clusters] = QualityMatrix(clu, fet);

% b: ISI Distribution
Timestamps_in_Clusters = {};
ISI = {};
for cluster_chosen = unique(clu)'
    Timestamps_in_Clusters{cluster_chosen} = TimeStamps(clu==cluster_chosen);
    ISI{cluster_chosen} = diff(Timestamps_in_Clusters{cluster_chosen});
end

% c: Autocorrelation
auto_correlation = {};
cAc=[];
for cluster_chosen = unique(clu)'
    [auto_correlation{cluster_chosen}, cAc(cluster_chosen)] = cluster_autocorrelation(Timestamps_in_Clusters{cluster_chosen}, 120);
end

% d: Intra-similarity
[Intrasim_score, Intra_similarity] = Intrasim(clu, Samples);

% final: Concatenate the quality_matrix and plot it
% remember the structure of quality_matrix
quality_matrix = [isoDist' lRatio' cAc' Intrasim_score nSpikes_in_Clusters'];


% iso-Distance: quality_matrix(:,1)
subplot(511)
bar(quality_matrix(:,1))
for i = 1:length(quality_matrix(:,1))
if quality_matrix(i,1) > 20 && quality_matrix(i,1) < 50  % criteria
    text(i,quality_matrix(i,1)+5.5,'*', 'FontSize', 14, 'Color', 'r');
elseif quality_matrix(i,1) > 50
    text(i,quality_matrix(i,1)+5.5,'**', 'FontSize', 15, 'Color', 'r');  
end
end
title('Iso-Distance');

% l-Ratio: quality_matrix(:,2)
subplot(512)
bar(quality_matrix(:,2))
for i = 1:length(quality_matrix(:,2))
if quality_matrix(i,2) < 0.4 && quality_matrix(i,2) > 0.1% criteria
    text(i,quality_matrix(i,2)+1.5,'*', 'FontSize', 14, 'Color', 'r');
elseif quality_matrix(i,2) < 0.1
    text(i,quality_matrix(i,2)+1.5,'**', 'FontSize', 15, 'Color', 'r');    
end
end
title('L-Ratio');

%  Central-bin of Autocorrelation: quality_matrix(:,3)
subplot(513)
bar(quality_matrix(:,3))
for i = 1:length(quality_matrix(:,3))
if quality_matrix(i,3) < 0.02 && quality_matrix(i,3) ~= 0 % criteria
    text(i,quality_matrix(i,3)+0.01,'*', 'FontSize', 14, 'Color', 'r');
elseif quality_matrix(i,3) == 0
    text(i,quality_matrix(i,3)+0.01,'**', 'FontSize', 15, 'Color', 'r');
end
end
title('C-Autocorr')

% Intra-similarity: quality_matrix(:,4)
subplot(514)
bar(quality_matrix(:,4))
for i = 1:length(quality_matrix(:,4))
if quality_matrix(i,4) > 0.8 && quality_matrix(i,4) < 0.90 % criteria
    text(i,quality_matrix(i,4)+0.03,'*', 'FontSize', 14, 'Color', 'r');
elseif quality_matrix(i,4) >= 0.90
    text(i,quality_matrix(i,4)+0.03,'**', 'FontSize', 15, 'Color', 'r');
end
end
title('Intra-Similarity')

% Number of spikes: quality_matrix(:,5)
subplot(515)
bar(quality_matrix(:,5))
for i = 1:length(quality_matrix(:,5))
if quality_matrix(i,5) > 100    % criteria
    text(i,quality_matrix(i,5)+1.5,'*', 'FontSize', 14, 'Color', 'r');
end
end
title('Number of Spikes');
