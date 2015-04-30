function [freqRange, signalPower, fftVector] = FFTAnalyze(vector, samplingRate)

    %% init vars
    [lenVector, ~] = size(vector);
    
    %% transform to frequency space via FFT
    transformLength = pow2(nextpow2(lenVector));
    fftVector = fft(vector, transformLength);
    freqRange = ((0 : transformLength - 1) * (samplingRate / transformLength))';
    signalPower = fftVector .* conj(fftVector) / transformLength;

end

