% By Chongxi Lai
clc;clear
%% Get the file list of all ntt file
cmd = 'python listntt.py';
[status, filelist] = system(cmd);
list = strsplit(filelist);

% Criteria used in Trim, Merge and QReport
global simCF;
simCF = 0.56;   % >
global nSpikeCF;
nSpikeCF = 20;  % >
global cbCF;
cbCF = 0.02;    % <
%% Cluster buntch of ntt files
% don't use '/' in the end
outDirec = '/Users/Chongxi/Installer/Exp_Result_0.56';
name_traits = '/Users/Chongxi/Documents/MATLAB/Spike_sorting/Data/p911';
S_KlustaKwik = '/Users/Chongxi/Documents/MATLAB/Spike_sorting/KlustaKwik/MaskedKlustaKwik';


for i=1:length(list)
    if ~isempty(strfind(list{i}, name_traits))
        [directory, filename, extension] = fileparts(list{i});
        dirtmp = strsplit( directory, '/' );
        nttdir = ['/' dirtmp{end} '/'];
        directory = [directory '/'];
        fcomball = [unique(perms([0 0 0 0 0]),'rows');...
                    unique(perms([0 0 0 0 1]),'rows');...
                    unique(perms([0 0 0 1 1]),'rows');...
                    unique(perms([0 0 1 1 1]),'rows');...
                    unique(perms([0 1 1 1 1]),'rows');...
                    unique(perms([1 1 1 1 1]),'rows')];
        fetcomb_s = ['P','E','A','D','W'];   %---- temp
        nCombn = size(fcomball, 1);
        
        Enable_KS = 0;
        
        for nComb = 1:nCombn
            fetcomb = fcomball(nComb,:);
            %----temp
            fetname = fetcomb_s(fetcomb==1); % s = 'PV'
            if Enable_KS == 1
                fetname = [fetname 'S'];
            end
            if ismember('P', fetname) && ...
               ismember('E', fetname) && ...
               ~ismember('A', fetname) && ...
               ~ismember('D', fetname) && ...
               ismember('W', fetname)
                    tempfolder = [outDirec nttdir fetname '/'];
                    if ~exist(tempfolder)
                      mkdir(tempfolder);
                    end
                    %----tempfolder is output folder of spike sorting
                    disp([tempfolder ' is the output directory']);
                    disp('...');
                    Spike_Sorting
            end
        end
    end
end

%% Process some or all ntt files
% Calculate and save wavelet matrix: {4 tetrodes} for each cell: nSpikes*l(length of wavelet coeffs)
% for i=1:length(list)
% if ~isempty(strfind(list{i},'TT3.ntt'))...
%             || ~isempty(strfind(list{i},'TT4.ntt'))...
%             || ~isempty(strfind(list{i},'TT5.ntt'))...
%             || ~isempty(strfind(list{i},'TT6.ntt'))
%     filename = list{i};
%     filename(end-3:end)='';
%     level = 5;
%     [TimeStamps, ScNumbers, CellNumbers, Params, DataPoints, header] = getRawSE(filename);
%     [wavelet,l]=getWavelet(DataPoints, [1 1 1 1], level, 'dmey');
%     disp(['wavelet extracted for' filename]);
%     mat = [filename '_wavelet_dmey.mat'];
%     save(mat, 'wavelet', 'l');
%     disp([mat 'saved']);
% end
% end