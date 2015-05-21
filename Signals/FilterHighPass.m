function [vectorOut] = FilterHighPass(signalVector, samplingRate, cutoff)
% Function: [ vectorOut ] = FilterHighPass(signalVector, samplingRate, cutoff)
% Author: William Michael Mortl
% Feel free to use this code for educational purposes, any other use
%     requires citations and recompence to William Michael Mortl
% Description: High Pass Filter, only allow higher than cutoff
% Inputs: 
%    signalVector === the column vector containing the signal
%    samplingRate === the sampling rate for the vector
%    cutoff === the frequency cutoff
% Outputs:
%    vectorOut === filtered signal

    %% fft
    [frequencyPower, fftVector] = FFTFreqAndPower(signalVector, samplingRate);

    %% edit fftVectorIn to only allow higher than cutoff
    fftVector(find(frequencyPower(:, 1) < cutoff)) = 0;
    
    %% transform back
    vectorOut = ifft(fftVector, 'symmetric');
    
end



