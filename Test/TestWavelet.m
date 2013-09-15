clc;clear;

level = 5;
[FileName,PathName] = uigetfile('*.ntt');
filename = [PathName FileName];
filename(end-3:end)='';
[TimeStamps, ScNumbers, CellNumbers, Params, DataPoints, header] =  getRawSE(filename);
[wavelet,l]=getWavelet(DataPoints, [1 1 1 1], level, 'haar');
multimodeIdx=[];
for i=1:32
    for electrode=1:4
        [f,xi] = ksdensity(wavelet{electrode}(:,i));
        [ymax,imax,ymin,imin] = extrema(f);
        imax((ymax<0.2e-4)) =[];
        ymax((ymax<0.2e-4)) = [];
        n(i) = length(ymax);
        dis = fix(max(diff(xi(imax))));
        if isempty(dis)
            modedistance(i)=0;
        else
            modedistance(i)=dis;
            figure;
            ksdensity(wavelet{electrode}(:,i));
            hold on
            plot(xi(imax),ymax,'r*',xi(imin),ymin,'g*')
            hold off
            legend(['electrode:', num2str(electrode), '    wavelet:',num2str(i)]);
            multimodeIdx = [multimodeIdx; electrode*100+i];
        end
    end
mat = [filename ['_wavelet.mat']];
save(mat, 'wavelet', 'l', 'multimodeIdx');
end

% plot(1:32, DataPoints(:,1,1), 1:32, waverec(wavelet{1}(1,:),l,'haar'))