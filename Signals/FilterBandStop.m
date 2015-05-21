function [vectorOut] = FilterBandStop(signalVector, samplingRate, cutoffLow, cutoffHigh)
% Function: [ vectorOut ] = FilterBandStop(signalVector, samplingRate, cutoffLow, cutoffHigh)
% Author: William Michael Mortl
% Feel free to use this code for educational purposes, any other use
%     requires citations and recompence to William Michael Mortl
% Description: Band Stop filter, blocks within range
% Inputs: 
%    signalVector === the column vector containing the signal
%    samplingRate === the sampling rate for the vector
%    cutoffLow === the low end of the band
%    cutoffHigh === the high end of the band
% Outputs:
%    vectorOut === filtered signal

    %% seperately get the low and high
    lowAllow = FilterLowPass(signalVector, samplingRate, cutoffLow);
    highAllow = FilterHighPass(signalVector, samplingRate, cutoffHigh);
    
    %% merge and return
    vectorOut = lowAllow + highAllow;

end

