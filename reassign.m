[cNo, eNo] = find(Intra_similarity > 0.67); % reassign criteria 1

for i = 1:numel(cNo)
    seedclu = cNo(i); seedch = eNo(i);
    m_spike = mean(squeeze(Samples(:,seedch,clu==seedclu)),2);
    for iclu = min(clu):max(clu)
        if iclu~=seedclu
        nspk = size(Samples(:,1,clu==iclu), 2);
        idx = find(clu == iclu);
            for ispk = 1:nspk
                spike = squeeze(Samples(:,seedch,ispk));
                s = similarity(spike, m_spike);
                c = corr(spike, m_spike);
                if s > 0.7 && c > 0.92  % reassign criteria 2
                    clu(idx(ispk)) = seedclu;
                end
            end
        end
    end
end