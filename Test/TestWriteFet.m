%% 
clc;clear
%% 
% 1. Set the file
% 2. Extract feature
[directory, filename, nttfilename] = set_nttfile(4);
[FData,FName,TimeStamps] = getFeaturespace(nttfilename,...
                                'Energy',[1,1,1,1],...
                                'PCA0',[1,1,1,1]...
                                );
fet = FData';
Outputfile = [directory filename '.fet.1'];
Outputmat = [directory filename '.mat'];
nFet = size(fet,2); % number of feature dimensions
nSpikes = size(fet,1);

%% Outputmat and Outputmat, choose one block to run (python/non-python)

% For non-python
% dlmwrite(Outputfile,nFet);
% for i=1:nSpikes
%     dlmwrite(Outputfile, fet(i,:), 'delimiter', '\t', '-append');
% end

% For python
save(Outputmat,'nSpikes','nFet','fet','FName'); 
disp([' Wrote ' Outputmat]);
% python wfet.py directory_of_mat_file TT3
cmd = ['python wfet.py' ' ' directory ' ' filename];
system(cmd);
disp([' Wrote ' Outputfile]);