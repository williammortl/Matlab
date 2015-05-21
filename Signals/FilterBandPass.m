function [vectorOut] = FilterBandPass(signalVector, samplingRate, cutoffLow, cutoffHigh)
% Function: [ vectorOut ] = FilterBandPass(signalVector, samplingRate, cutoffLow, cutoffHigh)
% Author: William Michael Mortl
% Feel free to use this code for educational purposes, any other use
%     requires citations and recompence to William Michael Mortl
% Description: Band Pass filter, only allows within range
% Inputs: 
%    signalVector === the column vector containing the signal
%    samplingRate === the sampling rate for the vector
%    cutoffLow === the low end of the band
%    cutoffHigh === the high end of the band
% Outputs:
%    vectorOut === filtered signal

    %% seperately get the low and high
    vectorOut = FilterLowPass(signalVector, samplingRate, cutoffHigh);
    vectorOut = FilterHighPass(vectorOut, samplingRate, cutoffLow);

end

