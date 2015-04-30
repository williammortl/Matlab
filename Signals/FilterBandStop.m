function [ vectorOut ] = FilterBandStop(vectorIn, samplingRate, cutoffLow, cutoffHigh)

    %% seperately get the low and high
    lowAllow = FilterLowPass(vectorIn, samplingRate, cutoffLow);
    highAllow = FilterHighPass(vectorIn, samplingRate, cutoffHigh);
    
    %% merge and return
    vectorOut = lowAllow + highAllow;

end

