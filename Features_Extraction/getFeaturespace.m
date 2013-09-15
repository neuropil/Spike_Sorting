%% getFeaturespace: return the Feature Data according to ntt file(filename) and feature space discription(varargin)
% By Chongxi Lai
% Updated Wed Jul 10 01:02:42 EDT 2013
function [Data, Name, TimeStamps] = getFeaturespace(filename,varargin)
% filename is ntt filename without '.ntt'
% Data is the content of feature sapce: feature space
% Name is the name of the dimension: Name of feature space
% varagin should be concatenation of pairs such as:  Peak, [1,1,1,1], Valley, [1,1,1,1]
% nargin is the number of varagin

%% Extract DataPoints from NTT file
[TimeStamps, ScNumbers, CellNumbers, Params, DataPoints, header] =  getRawSE(filename);
disp('Feature Extraction------------------------------------------------------------------')
disp('Extracting Feature from:');
disp(filename);
% Three of the above parameters are useful:
% 1. DataPoints is the (32 points)*(4 channels)*(No. of spikes)
% 2. Params is the feature space stored in NTT file
% 3. TimeStamps is time stamps
Data=[];Name=[];

% make sure that varargin is not {1*n} structure
if nargin==2 % nargin == 2 means varargin all feature_space input is stored in varagin{1}
    varargin=varargin{1}; 
end

%% Extract Feature Space to [Data,Name]
% For PCA Analysis, go to : http://www.mathworks.com/help/stats/feature-transformation.html#zmw57dd0e37106
for i = 1:2:size(varargin,2)-1
	featureName = varargin{i};
	ttChannelValidity = varargin{i+1};
	switch featureName
        case 'mpca_WAV'
            if sum(ttChannelValidity) == 4
                TCluster(filename, 40, 20);
                fet = readFet('All.fet.1');
                fet(:,4:end)=[];
                Data = [Data fet];
                Name = [Name;'mpca_WAV1';'mpca_WAV2';'mpca_WAV3'];
                disp('mpca_WAV1 Extracted');
                disp('mpca_WAV2 Extracted');
                disp('mpca_WAV3 Extracted');
            end
		case 'Peak'
			[Data_p,Name_p] = feature_Peak(DataPoints, ttChannelValidity);
            Data = [Data Data_p];
            Name = [Name;Name_p];
		case 'Valley'
			[Data_v,Name_v] = feature_Valley(DataPoints, ttChannelValidity);
            Data = [Data Data_v];
            Name = [Name;Name_v];
        case 'PeaktoValley'
			[Data_p2v,Name_p2v] = feature_PeaktoValley(DataPoints, ttChannelValidity);
            Data = [Data Data_p2v];
            Name = [Name;Name_p2v];
		case 'Energy'
			[Data_e,Name_e] = feature_Energy(DataPoints, ttChannelValidity);
            Data = [Data Data_e];
            Name = [Name;Name_e];
		case 'EnergyD1'
			[Data_ed,Name_ed] = feature_EnergyD1(DataPoints, ttChannelValidity);
            Data = [Data Data_ed];
            Name = [Name;Name_ed];
		case 'PCA0'
			[Data_pca,Name_pca] = feature_PCA(DataPoints, ttChannelValidity, 1);
            Data = [Data Data_pca];
            Name = [Name;Name_pca];  
		case 'PCA1'
			[Data_pca,Name_pca] = feature_PCA(DataPoints, ttChannelValidity, 2);
            Data = [Data Data_pca];
            Name = [Name;Name_pca];  
		case 'PCA2'
			[Data_pca,Name_pca] = feature_PCA(DataPoints, ttChannelValidity, 3);
            Data = [Data Data_pca];
            Name = [Name;Name_pca]; 
		case 'PCA3'
			[Data_pca,Name_pca] = feature_PCA(DataPoints, ttChannelValidity, 4);
            Data = [Data Data_pca];
            Name = [Name;Name_pca];
        case 'WAV1'
            [Data_wav,Name_wav] = feature_Wavelet(DataPoints, ttChannelValidity, 1);
            Data = [Data Data_wav];
            Name = [Name;Name_wav];
        case 'WAV2'
            [Data_wav,Name_wav] = feature_Wavelet(DataPoints, ttChannelValidity, 2);
            Data = [Data Data_wav];
            Name = [Name;Name_wav];
        case 'WAV3'
            [Data_wav,Name_wav] = feature_Wavelet(DataPoints, ttChannelValidity, 3);
            Data = [Data Data_wav];
            Name = [Name;Name_wav];               
		otherwise
			Data=[];Name=[];
	end
end

%% Integerize the feature space
% fix: Round toward zero
% round: Round to nearest integer
% floor: Round toward negative infinity
% ceil: Round toward positive infinity
Data = fix(Data);
disp('Feature Extraction Done')
disp('');
