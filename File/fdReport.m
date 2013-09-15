%% fdReport: disp and write fd file
function fdReport(fd_fileID, FName, ks, n)

nFet = size(FName,1);
disp('-----------------Feature Distribution------------------');
disp(['Feature    ' '   ' 'ks' '           #modes']);
fprintf(fd_fileID,'%-8s\t%s\t%s\n', 'Feature', 'ks', '#');
for i=1:nFet
    fprintf(fd_fileID,'%-10s\t%.4f\t%d\n', FName{i}, ks(i), n(i));
    fqua = sprintf('%-10s    %f     %d', FName{i}, ks(i), n(i));
    disp(fqua);
end
fclose(fd_fileID);

end