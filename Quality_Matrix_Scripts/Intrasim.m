% By Chongxi Lai
function [Intrasim_score, In_sim] = Intrasim(clu, Samples)
%% 1. Intra-similarity matrix and find the best waveform
spikes = {};
m_spike = {};
sim = {};
cor = {};
nClu = length(unique(clu));
In_sim = zeros(nClu,4);
for iclu = unique(clu)'
    for ich = 1:4
        spikes{iclu, ich} = squeeze(Samples(:, ich, clu==iclu));
        m_spike{iclu, ich} = mean(spikes{iclu, ich},2);
        i = 0;
        for ispk = 1:size(spikes{iclu, ich}, 2)
            sim{iclu}(ich, ispk) = similarity(spikes{iclu, ich}(:, ispk), m_spike{iclu, ich});
%             cor{iclu}(ich, ispk) = corr(spikes{iclu, ich}(:, ispk), m_spike{iclu, ich});
% --------------------------30% outlier-------------------
%             if sim{iclu}(ich, ispk) < 0.4  % < 0.4 similarity is outlier
%                 i = i + 1;
%             end
% --------------------------30% outlier--------------------
        end
% --------------------------30% outlier--------------------
%           In_sim(iclu, ich) = i/size(spikes{iclu, ich}, 2);
% ---------------------------------------------------------
% --------------------------mean-------------------
          In_sim(iclu, ich) = mean(sim{iclu}(ich, :));
%           In_cor(iclu, ich) = mean(cor{iclu}(ich, :));
% -------------------------------------------------          
    end
end
% -----------------mean-----------------
Intrasim_score = max(In_sim,[],2);
% Intracor_score = max(In_cor,[],2);
% --------------------------------------
% score and find the best cluster
% --------------------------30% outlier-------------------
% temp_sim = In_sim;
% temp_sim(In_sim>0.3) = 1; % 30% outlier is noisy
% In_sim = 1 - In_sim;
% Intrasim_score = 1 - min(temp_sim,[],2);
% --------------------------------------------------------
