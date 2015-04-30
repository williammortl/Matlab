function [ vectorOut ] = FilterBandPass(vectorIn, samplingRate, cutoffLow, cutoffHigh)

    %% seperately get the low and high
    vectorOut = FilterLowPass(vectorIn, samplingRate, cutoffHigh);
    vectorOut = FilterHighPass(vectorOut, samplingRate, cutoffLow);

end

