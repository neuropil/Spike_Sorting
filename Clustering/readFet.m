%% readFet: fetch fet(feature) matrix from .fet.1 file
% By Chongxi Lai
% Updated Mon Jul 15 17:23:31 EDT 2013

function [fet, nFet] = readFet(filename)

% For test:
% filename = '/Users/Chongxi/Documents/MATLAB/Spike_sorting/Feature_Calibration/KlustaKwik/TT3.fet.1';
delimiter = '\t';

%% Open the text file.
fileID = fopen(filename,'r');
nFet = str2num(fgets(fileID));
%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
% For more information, see the TEXTSCAN documentation.
% for nFet == 2: formatSpec='%f%f%[^\n\r]'
formatSpec = [];
for n=1:nFet
    formatSpec = [formatSpec '%f'];
end
formatSpec = [formatSpec '%[^\n\r]'];
%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
nSpikes = length(dataArray{1,1});
fet = ones(nSpikes, nFet);
for i=1:nFet
%     dataArray{1,i}(1)=[];
    fet(:,i)=dataArray{1,i};
end
%% Close the text file.
fclose(fileID);
