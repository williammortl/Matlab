function [vectorOut] = FilterPower(signalVector, samplingRate, lowerOrHigher, cutoff)
% Function: [vectorOut] = FilterPower(signalVector, samplingRate, lowerOrHigher, cutoff)
% Author: William Michael Mortl
% Feel free to use this code for educational purposes, any other use
%     requires citations and recompence to William Michael Mortl
% Description: Filters frequencies that are lower or higher than a percent
%              of the maximum power
% Inputs: 
%    signalVector === the column vector containing the signal
%    samplingRate === the sampling rate for the vector
%    lowerOrHigher === 1 if power has to be greater than cutoff, 0 if lower
%    cutoff === the frequency power to use as a cutoff
% Outputs:
%    vectorOut === filtered signal

    %% fft
    [frequencyPower, fftVector] = FFTFreqAndPower(signalVector, samplingRate);

    %% edit fftVectorIn to only allow frequencies with less or more power than max
    if (lowerOrHigher >= 1)
        
        % only allow frequencies with power GREATER THAN the percent of the max 
        fftVector(find(frequencyPower(:, 2) <= cutoff)) = 0;
        
    else
        
        % only allow frequencies with power LESS THAN the percent of the max
        fftVector(find(frequencyPower(:, 2) >= cutoff)) = 0;
    
    end
    
    %% transform back
    vectorOut = ifft(fftVector, 'symmetric');
    
end





