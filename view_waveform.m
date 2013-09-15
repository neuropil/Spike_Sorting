function view_waveform(waveform)

% waveform is squeezed DataPoints or wavelet coeffs
% waveform structure: nSample * nSpikes

idx = 1;

figure
subplot(211)
plot(waveform);
legend([num2str(size(waveform,2)) ' waveforms']);
subplot(212)
plot(waveform(:,idx))

%% slide the spikes in the cluster
uicontrol('Style', 'slider',...
        'Min',1,'Max',size(waveform,2)-2,'Value',1,...
        'Position', [200 10 180 20],...
        'Callback', {@spikeslide,waveform});
end