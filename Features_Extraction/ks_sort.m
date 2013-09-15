% By Chongxi Lai

function [fet, FName] = ks_sort(fet, FName, Enable_KS)
if Enable_KS == 1
ks = fd(fet, 0);
[k,o]=sort(ks, 'descend');
% dim = length(find(k>0.035));
% if dim < 8
%     dim = 8;
% end
dim = 12;
fet(:,1:dim) = fet(:,o(1:dim));
fet(:,dim+1:end) = [];
FName(1:dim) = FName(o(1:dim));
FName(dim+1:end) = [];
disp('ks sort for feature space');
end