function [ vectorOut ] = FilterLowPass(vectorIn, samplingRate, cutoff)

    %% fft
    [freqRange, ~, fftVector] = FFTAnalyze(vectorIn, samplingRate);

    %% edit fftVectorIn to only allow lower than cutoff
    fftVector(find(freqRange > cutoff)) = 0;
    
    %% transform back
    vectorOut = ifft(fftVector, 'symmetric');
    
end

