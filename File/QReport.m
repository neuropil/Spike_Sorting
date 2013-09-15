%% QReport: Quality Matrix File Output and Display in log
% By Chongxi Lai
function QReport(Q_fileID, quality_matrix, nClu)
% quality_matrix: nClu * nQuality
% iso-Distance: quality_matrix(:,1)
% l-Ratio: quality_matrix(:,2)
% Central-bin of Autocorrelation: quality_matrix(:,3)
% Similarity Score: quality_matrix(:,4)
% Number of spikes: quality_matrix(:,5)
% simCF is cut-off value of self-similarity

global simCF;
global nSpikeCF;
global cbCF;
n = 0;nspk = 0;
disp('---------------------------------Quality Matrix----------------------------------');
fprintf(Q_fileID,'%s\t %8s\t %8s\t %8s\t %8s\t %s\n', 'nClu', 'IsoDist', 'lRatio', 'cAc', 'Sim', '#Spike');
fprintf('%s\t %8s\t %8s\t %8s\t %8s\t %s\n', 'nClu', 'IsoDist', 'lRatio', 'cAc', 'Sim', '#Spike');
for i=1:nClu
    if quality_matrix(i,4) > simCF && quality_matrix(i,5) > nSpikeCF && quality_matrix(i,3) < cbCF
        fprintf(Q_fileID,'%s\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %d\n', ['Clu' num2str(i) '*'], quality_matrix(i,1), quality_matrix(i,2), quality_matrix(i,3), quality_matrix(i,4), quality_matrix(i,5));
        fqua = sprintf('%s\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %d', ['Clu' num2str(i) '*'], quality_matrix(i,1), quality_matrix(i,2), quality_matrix(i,3), quality_matrix(i,4), quality_matrix(i,5));
        n = n + 1;
        nspk = nspk + quality_matrix(i,5);
    else
        fprintf(Q_fileID,'%s\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %d\n', ['Clu' num2str(i)], quality_matrix(i,1), quality_matrix(i,2), quality_matrix(i,3), quality_matrix(i,4), quality_matrix(i,5));
        fqua = sprintf('%s\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %d', ['Clu' num2str(i)], quality_matrix(i,1), quality_matrix(i,2), quality_matrix(i,3), quality_matrix(i,4), quality_matrix(i,5));        
    end
    disp(fqua);
end
fprintf('%-16s\t%d\n%-16s\t%d/%d\n', 'Useable #Cluster:', n, 'Useable #Spikes:', nspk, sum(quality_matrix(:,5)));
fprintf(Q_fileID, '%-16s\t%d\n%-16s\t%d/%d\n', 'Useable #Cluster:', n, 'Useable #Spikes:', nspk, sum(quality_matrix(:,5)));
% fprintf(Q_fileID, '%d\t%d\t%d', nGoodClu(1), nGoodClu(2), nGoodClu(3));
disp('---------------------------------------------------------------------------------');

end