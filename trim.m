
[cNo, eNo] = find(Intra_similarity > simCF); % trim criteria 1

% 2. Trim the best cluster
for i = 1:numel(cNo)
    spk_trim = [];
    iclu = cNo(i); ich = eNo(i);
    if sum(clu == iclu) ~= 0
        idx = find(clu == iclu);
        nspk = size(idx);
        for ispk = 1:nspk
            if cor{iclu}(ich, ispk) < 0.88 || sim{iclu}(ich, ispk) < 0.4  % trim criteria 2
                spk_trim = [spk_trim, idx(ispk)];
            end
        end
        clu(spk_trim) = 1;
        [sim,cor,Intra_similarity] = selfsim(clu,Samples);
    end
end
