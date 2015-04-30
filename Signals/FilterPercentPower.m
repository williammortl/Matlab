function [ vectorOut ] = FilterPercentPower(vectorIn, samplingRate, lowerOrHigher, percent)

    %% fft
    [~, signalPower, fftVectorIn] = FFTAnalyze(vectorIn, samplingRate);

    %% edit fftVectorIn to only allow frequencies with less or more power than max
    cutoff = max(signalPower) * percent;
    if (lowerOrHigher >= 1)
        
        % only allow frequencies with power GREATER THAN the percent of the max 
        fftVectorIn(find(signalPower <= cutoff)) = 0;
        
    else
        
        % only allow frequencies with power LESS THAN the percent of the max
        fftVectorIn(find(signalPower >= cutoff)) = 0;
    
    end
    
    %% transform back
    vectorOut = ifft(fftVectorIn, 'symmetric');
    
end



