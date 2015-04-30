function [coherence, freq] = Coherence(audio1, audio2, samplingRate, cutoffComparePercentage)

    %% make sure that songs are now the same length by padding zeros
    [len1, ~] = size(audio1);
    [len2, ~] = size(audio2);
    if (len1 > len2)
        songTemp = zeros(len1, 1);
        songTemp(1 : len2) = audio2;
        audio2 = songTemp;
    elseif (len1 < len2)
        songTemp = zeros(len2, 1);
        songTemp(1 : len1) = audio1;
        audio1 = songTemp;
    end
    
    %% cuts out frequencies that are small compared to peak
    if (nargin == 4)
        audio1 = FilterPercentPower(audio1, samplingRate, 1, cutoffComparePercentage);
        audio2 = FilterPercentPower(audio2, samplingRate, 1, cutoffComparePercentage);
    end
    
    %% get coherence
    [coherence, freq] = mscohere(audio1, audio2, [], [], [], samplingRate);
    
end

