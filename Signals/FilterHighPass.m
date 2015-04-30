function [ vectorOut ] = FilterHighPass(vectorIn, samplingRate, cutoff)

    %% fft
    [freqRange, ~, fftVector] = FFTAnalyze(vectorIn, samplingRate);

    %% edit fftVectorIn to only allow higher than cutoff
    fftVector(find(freqRange < cutoff)) = 0;
    
    %% transform back
    vectorOut = ifft(fftVector, 'symmetric');
    
end



