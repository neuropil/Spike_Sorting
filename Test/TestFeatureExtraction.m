clear;clc;
% run parameters first
[directory, filename, nttfilename] = set_nttfile(1);
% [TimeStamps, ScNumbers, CellNumbers, Params, DataPoints, header] =  getRawSE(nttfilename);
[FData,FName,TimeStamps] = getFeaturespace(nttfilename,'Energy',[1,1,1,1],'PCA0',[1,1,1,1], 'WAV1', [1 1 1 1]);
