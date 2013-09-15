% By Chongxi Lai
%% selfsim(clu,samples): Calculate the similarity matrix, correlation coeff matrix and mean of each similarity distribution
% Input: 1.clu 2.samples
% Output: 1.similarity matrix in which each cell is a cluster, in each cell there is #ich=4 distribution across all #nSpikes
% Output: 2.correlation coeff matrix which shares the same structure with similarity matrix
% Output: 3.mean of the similarity distribution: #Clu*#Ch

function [sim, cor, In_sim, In_correrr] = selfsim(clu,samples)
spikes = {};
m_spike = {};
sim = {};
cor = {};
nClu=length(unique(clu));
In_sim = zeros(nClu,4);
In_correrr = zeros(nClu,4);
for iclu = unique(clu)'
    for ich = 1:4
        spikes{iclu, ich} = squeeze(samples(:, ich, clu==iclu));
        m_spike{iclu, ich} = mean(spikes{iclu, ich},2);
        i = 0;
        for ispk = 1:size(spikes{iclu, ich}, 2)
            sim{iclu}(ich, ispk) = similarity(spikes{iclu, ich}(:, ispk), m_spike{iclu, ich});
            cor{iclu}(ich, ispk) = corr(spikes{iclu, ich}(:, ispk), m_spike{iclu, ich});
        end
        In_sim(iclu, ich) = mean(sim{iclu}(ich, :));
        In_correrr(iclu, ich) = length(find(cor{iclu}(ich,:)<0.9));
    end
end