function spikeslide(hObj,event,spikes) %#ok<INUSL>
    % Called to set zlim of surface in figure axes
    % when user moves the slider control 
    idx = round(get(hObj,'Value'));
    nSample = size(spikes,1);
    plot(1:nSample,spikes(:,idx),1:nSample,spikes(:,idx+1),1:nSample,spikes(:,idx+2))
    legend(num2str(idx), num2str(idx+1), num2str(idx+2));
end