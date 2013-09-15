%% Modedistance: return the Feature Data, k-s distance and modedistance according to ntt file(filename) and feature space discription(varargin)
% By Chongxi Lai
% Updated Wed Jul 10 01:02:42 EDT 2013

function [FData , FName, h, kdistance, n, modedistance] = Modedistance(filename,varargin)
% file is nttfile
% h = 0 means that vector is from a normal distribution (details in lillietest)
% kdistance is the max distance of empirical CDF from Normal CDF with the same MEAN and STD
% n is the No. of max extrema in the Kernel Smoothing Density Estimate which indicate how many modes are there in the vector
% modedistance is the max distance from two mode
[FData,FName] = getFeaturespace(filename,varargin);

fNo = size(FData,1);
figureNo = fNo;
h=[];kdistance=[];n=[];modedistance=[];
for fn = 1:fNo
    % fv is one feature vector contains all spikes (one dimension)
	fv=FData(fn,:);
    % k-s criterion, see detail in lillietest
	[h_,p_,kdistance_,c_] = lillietest(fv);
%     kdistance_ = sprintf('%8.3f',kdistance_);
    h = [h;h_];
    kdistance = [kdistance;kdistance_];
    % ksd analysis
	[f,xi] = ksdensity(fv);
	subplot(figureNo/2,2,fn) % plot figureNo subplot in total
	plot(xi,f)
	[ymax,imax,ymin,imin] = extrema(f);
	% don't turn the order, eliminate imax first because it depends on the ymax
	imax((ymax<0.5e-5)) =[];
	ymax((ymax<0.5e-5)) = [];
	n_ = length(ymax);
	modedistance_ = fix(max(diff(xi(imax))));
	if isempty(modedistance_)
		modedistance_=0;
	end
	hold on
	plot(xi(imax),ymax,'r*',xi(imin),ymin,'g*')
	hold off
    legend(['k-s distance=',num2str(kdistance_)],['mode-distace=',num2str(modedistance_)]);
    n = [n;n_];
    modedistance = [modedistance;modedistance_];
end
