% Updated by Chongxi for both unix/win usage
% Mon Jul 15 18:35:10 EDT 2013
function [TimeStamps, ScNumbers, CellNumbers, Params, DataPoints,header] =  getRawSE(Filename)

%Filename = '/home/urut/MPI/data/testData/SE1_CSC34.nse';
%Filename='/tmp/TT_test2.ntt';
%     1. Timestamps   
%     2. Sc Numbers
%     3. Cell Numbers
%     4. Params
%     5. Data Points

if(~strcmp(Filename(end-3:end),'.ntt'))
    Filename = [Filename '.ntt'];
end

archstr = computer('arch');
%this file can read SE and TT
if archstr == 'maci64'
    [TimeStamps, ScNumbers, CellNumbers, Params, DataPoints,header] = ...
    Nlx2MatSpike_v3(Filename, [1 1 1 1 1], 1, 1, []);
%     which Nlx2MatSpike_v3

elseif archstr == 'win64'
    [TimeStamps, ScNumbers, CellNumbers, Params, DataPoints,header] = ...
    Nlx2MatSpike(filename,[1 1 1 1 1], 1, 1, []);
%     which Nlx2MatSpike

end

% which Nlx2MatSpike_v3
% spikes=squeeze(DataPoints(:,1,:));  %take so many spikes to display
% figure;
% plot(spikes);
