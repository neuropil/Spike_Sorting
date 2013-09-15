% By Chongxi Lai
%% don't clear workspace if you would like to use [directory, filename] from other file
% clc;clear

%% 1. Feature Extraction

% a. Set the file
% i>
% [directory, filename, nttfilename, S_KlustaKwik] = set_nttfile(4);
% ii>
% [filename,directory] = uigetfile('*.ntt');
% filename(end-3:end)='';
nttfilename = [directory filename];

% b. Extract feature


% Load ntt file
[TimeStamps, ScNumbers, CellNumbers, Features, Samples, Header] = ...
    getRawSE(nttfilename);
% Extract Feature
[fet, FName] = getFeaturespace(nttfilename,...
                                          'Peak',fetcomb(1)*[1,1,1,1],...
                                          'Energy',fetcomb(2)*[1,1,1,1],...
                                          'PCA1',fetcomb(3)*[1,1,1,1],...
                                          'EnergyD1',fetcomb(4)*[1,1,1,1],...
                                          'mpca_WAV',fetcomb(5)*[1,1,1,1]...
                                          );
% ----------------sort fet and choose best ks fet-----------
[fet, FName] = ks_sort(fet, FName, Enable_KS);
% ---------------Calculate nFet, nSpikes and fd----------------------
nSpikes = size(fet,1); % number of spikes
nFet = size(fet,2); % number of feature dimensions
[ks, nmodes, modedistance] = fd(fet, 0);
% ------------------disp and write fd file---------------------------
fd_fileID = fopen([tempfolder filename '_fd.txt'],'w');
fdReport(fd_fileID, FName, ks, nmodes); % FName is feature; ks is ks-dist; nmodes is #modes
% -------------------------------------------------------------------
%% 2. Clustering
% Input: fet
% Output: clu

% a) KlustaKwik (EM)
[clu, nClu] = KCluster(directory, filename, fet, S_KlustaKwik);

% b) ETOS (RVB)
% [clu, nClu] = TCluster(nttfilename, 50, 30);
% [fet, nFet] = readFet('All.fet.1');
% fet(:,13)=[];


%% 4. Quality Matrix, ISI distribution, Autocorrelation
% Input: 1. nttfilename; 2. clu; 3. fet

% Report Quality:
% iso-Distance: quality_matrix(:,1)
% l-Ratio: quality_matrix(:,2)
% Central-bin of Autocorrelation: quality_matrix(:,3)
% Similarity Score: quality_matrix(:,4)
% Number of spikes: quality_matrix(:,5)
% [Intrasim_score, Intra_similarity] = Intrasim(clu, Samples);
spikes = {};
for ich = 1:4
    spikes{ich} = squeeze(Samples(:,ich,:));
end
[sim,cor,Intra_similarity] = selfsim(clu,Samples);
trim;
% reassign;
fig_quality = figure;
[quality_matrix, ISI, Timestamps_in_Clusters] = reportQuality(Samples, TimeStamps, fet, clu);
% -----------merge-------------------------
mclu = [];nclu = [];
for i = unique(clu)'
    if quality_matrix(i,2) > 0.1 && quality_matrix(i,4) > simCF
        mclu = [mclu i];
    elseif quality_matrix(i,2) < 0.1 && quality_matrix(i,4) > simCF
        nclu = [nclu i];
    end
end
[clu,nClu] = merge(clu, mclu, nclu, spikes);
% ----------quality-------------------------
figure(fig_quality);
[quality_matrix, ISI, Timestamps_in_Clusters] = reportQuality(Samples, TimeStamps, fet, clu);

% Set pb buttons on report figure to inspect the waveforms, ISI and Autocorrelation of each cluster
% for cluNo = unique(clu)'
% pb(cluNo) = uicontrol('Style', 'pushbutton', 'String', num2str(cluNo),...
%         'Position', [25*cluNo 10 20 20]);
% set(pb(cluNo),'Callback',...
%     'buttonlist = get(pb, ''value''); No = find(cell2mat(buttonlist)==1); plot_tetrode(Samples, clu, ISI, Timestamps_in_Clusters, No, quality_matrix, Intra_similarity); figure(fig_galaxy); cla; plot_clu(fet, clu, 3, No);');
% end

%% 5. Display Waveforms and save as pngs

% % Input: 1. Samples; 2. clu; 3. ISI; 4.Timestamps_in_Clusters; 5.quality_matrix
% --Cluster Galaxy Visualization--
% fig_galaxy = figure;
% plot_clu(fet, clu, 3, 0);  %3 for 3d, 0 for no highlight cluster
% --Waveforms Visualization--
fig_tetrode = figure;
for cluster_chosen = unique(clu)'
% ------------plot tetrode--------------------------
    figure(fig_tetrode);
    cla;
    plot_tetrode(Samples, clu, ISI, Timestamps_in_Clusters, cluster_chosen, quality_matrix, Intra_similarity);
    disp(['Display cluster ' num2str(cluster_chosen)]);
    print(gcf,'-dpng',[tempfolder filename '_clu' num2str(cluster_chosen) '.png']);
end

% ------------png of galaxy and quality-------------
% print(fig_galaxy,'-dpng',[tempfolder filename '_galaxy.png']);
print(fig_quality,'-dpng',[tempfolder filename '_quality.png']);
close all

%% 6. Save Results: quality matrix file, mat file, ntt file

% 1. quality_matrix file
% ------------------disp and write Quality Matrix--------------------
Q_fileID = fopen([tempfolder filename '_quality.txt'],'w');
QReport(Q_fileID, quality_matrix, nClu);
fclose(Q_fileID);
% -------------------------------------------------------------------
% % 2. mat
% Outputmat = [directory filename '.mat'];
% save(Outputmat,'nttfilename','nSpikes','nFet','nClu','fet','clu','FName','isoDist','lRatio','cAc',...
%     'ISI','TimeStamps','Samples','Header','quality_matrix'); 
% disp('');
% disp(['Wrote ' Outputmat]);

% 3. Save ntt file (wntt)
Output_nttfile = [tempfolder filename, '.ntt'];
wntt(Output_nttfile, TimeStamps, ScNumbers, clu, fet, Samples, Header); % parameter 4,5 is clu, fet