function [frequencyPower, fftVector] = FFTFreqAndPower(signalVector, samplingRate)
% Function: [frequencyPower, fftVector] = FFTFreqAndPower(signalVector, samplingRate)
% Author: William Michael Mortl
% Feel free to use this code for educational purposes, any other use
%     requires citations and recompence to William Michael Mortl
% Description: analyzes the signal using FFT
% Inputs: 
%    signalVector === the column vector containing the signal
%    samplingRate === the sampling rate for the vector
% Outputs:
%    frequencyPower === 2 column matrix, 1st column is frequencies, 2nd column is the power of that frequency
%    fftVector === the raw fast fourier transformed vector
        
    %% init vars
    [lenVector, ~] = size(signalVector);
    
    %% transform to frequency space via FFT
    transformLength = pow2(nextpow2(lenVector));
    fftVector = fft(signalVector, transformLength);
    freqRange = ((0 : transformLength - 1) * (samplingRate / transformLength))';
    signalPower = fftVector .* conj(fftVector) / transformLength;
    frequencyPower = horzcat(freqRange, signalPower);

end

