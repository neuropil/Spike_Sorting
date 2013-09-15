%% wntt: Write new ntt file with fet and clu
% By Chongxi Lai
function [outputs] = wntt(Output_nttfile, TimeStamps, ScNumbers, CellNumbers, Features, Samples, Header)


CellNumbers = CellNumbers';
Features = Features';

nFet = size(Features,1);
if nFet>8
	Features(9:end,:) = []; % ntt can only hold 8 dimensions
elseif nFet<8
	Features(nFet+1:8,:)=0;
end

% ---------------------------Mac OS X-----------------------------------
if exist(Output_nttfile)
  delete(Output_nttfile);
end
Mat2NlxTT(Output_nttfile, ...
    0, 1, 1, length(TimeStamps), ...
    [1 1 1 1 1 1], ...
    TimeStamps, ScNumbers, CellNumbers, Features, Samples, Header);
% ---------------------------Windows------------------------------------
% Mat2NlxSpike([tempfolder filename '_' fetname '.ntt'], ...
%     0, 1, [], ...
%     [1 1 1 1 1 1], ...
%     TimeStamps, ScNumbers, CellNumbers, Features, Samples, Header);

end