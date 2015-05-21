function [vectorOut] = FilterPercentPower(signalVector, samplingRate, lowerOrHigher, percent)
% Function: [ vectorOut ] = FilterPercentPower(signalVector, samplingRate, lowerOrHigher, percent)
% Author: William Michael Mortl
% Feel free to use this code for educational purposes, any other use
%     requires citations and recompence to William Michael Mortl
% Description: Filters frequencies that are lower or higher than a percent
%              of the maximum power
% Inputs: 
%    signalVector === the column vector containing the signal
%    samplingRate === the sampling rate for the vector
%    lowerOrHigher === 1 if power has to be greater than cutoff, 0 if lower
%    percent === the percent of the max frequency power used as a cutoff
% Outputs:
%    vectorOut === filtered signal

    %% call FilterPower
    cutoff = max(signalPower) * percent;
    vectorOut = FilterPower(signalVector, samplingRate, lowerOrHigher, cutoff);
    
end



