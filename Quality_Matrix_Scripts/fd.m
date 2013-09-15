function [kdistance, n, modedistance] = fd(fet, method)

FData = fet';
fNo = size(FData,1);
figureNo = fNo;
h=[];kdistance=[];n=[];modedistance=[];
    for fn = 1:fNo
        % fv is one feature vector contains all spikes (one dimension)
        fv=FData(fn,:);
        % k-s criterion, see detail in lillietest
        kdistance_ = test_ks(fv);
        kdistance = [kdistance;kdistance_];
        % ksd analysis
        [f,xi] = ksdensity(fv);
        [ymax,imax,ymin,imin] = extrema(f);
        % don't turn the order, eliminate imax first because it depends on the ymax
        imax((ymax<0.2e-5)) =[];
        ymax((ymax<0.2e-5)) = [];
        n_ = length(ymax);
        modedistance_ = fix(max(diff(xi(imax))));
        if isempty(modedistance_)
            modedistance_=0;
        end
        if method == 1
            subplot(figureNo/2,2,fn) % plot figureNo subplot in total
            plot(xi,f)
            hold on
            plot(xi(imax),ymax,'r*',xi(imin),ymin,'g*')
            hold off
            legend(['k-s distance=',num2str(kdistance_)],['mode-distace=',num2str(modedistance_)]);
        end
        n = [n;n_];
        modedistance = [modedistance;modedistance_];
    end
end