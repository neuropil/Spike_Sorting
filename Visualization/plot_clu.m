%% plot_clu: plot spikes in feature space labelled by color of clustering
% By Chongxi Lai
% Updated Mon Jul 15 18:01:09 EDT 2013

function n_clu = plot_clu(fet, clu, way, cluNo)
%% Caculate the number of clustering
% INPUT:
% 1. fet matrix
% 2. clu vector
% 3. way: 2 or 3 for 2D/3D

n_clu = length(unique(clu)); % claculate nClu, number of elements of clustering
color = lines(n_clu); % assign colors, color is nClu * 3 matrix in which each row is a color to draw for a cluster
shape = ones(length(fet(:,1)),1);
clu_start = min(clu);
if cluNo ~= 0
    shape(clu==cluNo)=5;
    shape(clu~=cluNo)=1;
end

if way == 2 %2D
    scatter(fet(:,1), fet(:,2), shape, color(clu-clu_start+1, :), 'Marker','o'); % 45 is size, color(clu,:) indicate this sipike's color
elseif way == 3 %3D
    scatter3(fet(:,1), fet(:,2), fet(:,3), shape, color(clu-clu_start+1, :), 'filled'); % 10 is size, color(clu,:) indicate this sipike's color
    view([-75,9]), axis vis3d, box on, rotate3d on
else
    disp('the third parameter should be 2 for 2D or 3 for 3D')
end
