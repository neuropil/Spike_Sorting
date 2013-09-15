clc;clear;

% set parameters first
% for i = 3:6

% [directory, filename, nttfilename] = set_nttfile(3);
[filename,directory] = uigetfile('*.ntt');
filename(end-3:end)='';
nttfilename = [directory filename];
[FData, FName, h, kdistance, n, modedistance] = Modedistance(nttfilename, ...
                                                             'Energy', 1*[1,1,1,1],  ...
                                                             'Peak', 1*[1,1,1,1],  ...
                                                             'Valley', 1*[1,1,1,1], ...
                                                             'PCA1', 1*[1,1,1,1]  ...
                                                             );
Output = [h kdistance n modedistance];
Output = num2cell(Output);
Output = [FName Output];
temp={'Feature' 'h' 'kdistance' 'n' 'modedistance'};
Output=[temp;Output];
Outputfilename = [nttfilename '_fd.txt']
dlmcell(Outputfilename,Output);

% end
