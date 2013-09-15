%% Set_Parameters: pre-define the directory where 
function [directory, filename, nttfilename, S_KlustaKwik] = set_nttfile(No)
directory = '/Users/Chongxi/Documents/MATLAB/Spike_sorting/Feature_Calibration/Data/p1921/2013-03-15_18-13-16p/';
directory = '/Users/Chongxi/Documents/MATLAB/Spike_sorting/Feature_Calibration/Data/p911/2013-03-04_17-37-24p/';
filebase = 'TT';
% directory = '/Users/Chongxi/Documents/MATLAB/Spike_sorting/Feature_Calibration/Data/';
% filebase = 'Sample';
filename = [filebase num2str(No)];
nttfilename = [directory filename];
S_KlustaKwik = '~/Documents/MATLAB/Spike_sorting/Feature_Calibration/KlustaKwik/MaskedKlustaKwik';