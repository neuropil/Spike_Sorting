%%
clc;clear;
[FileName,PathName] = uigetfile('*.ntt');
nttfilename = [PathName FileName];
nttfilename(end-3:end)='';
%%
[TimeStamps, ScNumbers, CellNumbers, Params, DataPoints, Header] =  getRawSE(nttfilename);

%% Disassociate the c->d section from original data
c=1;d=0;
c_minutes = 0; d_minutes = 1; step_minutes = 1;
nSpikes = size(TimeStamps,2);
time = TimeStamps-min(TimeStamps);
time = round(time/1e3); % time is timestamps using msec

while(d < nSpikes)
    
    filename = [nttfilename '_' num2str(d_minutes) 'm.ntt'];
    
    c = find(time >= c_minutes*1e3*60, 1, 'first');
    d = find(time < d_minutes*1e3*60, 1, 'last' );
    if exist(filename,'file')
        cmd = ['rm ' filename];
        system(cmd);
    end
    
    Mat2NlxTT(filename, ...
        0, 1, 1, length(TimeStamps(c:d)), ...
        [1 1 1 1 1 1], ...
        TimeStamps(c:d), ScNumbers(c:d), CellNumbers(c:d), Params(:, c:d), DataPoints(:, :, c:d), Header);

%     view_waveform(squeeze(DataPoints(:,1,:)));
    
    c_minutes = c_minutes + step_minutes;
    d_minutes = d_minutes + step_minutes;
    
end

[TimeStamps, ScNumbers, CellNumbers, Params, DataPoints, Header] =  getRawSE(filename);