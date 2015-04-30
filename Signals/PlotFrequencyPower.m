function [fig] = PlotFrequencyPower(vector, samplingRate, subTitle, maxFreq)

    % same as -> [P2,f2] = periodogram(vector,[],[],samplingRate,'power');

    %% get the fft
    [freqRange, signalPower, ~] = FFTAnalyze(vector, samplingRate);
    
    %% max freq limit?
    if (nargin <= 2)
        [maxFreq, ~] = size(freqRange);
    end
        
    %% plot frequency to power
    fig = figure;
    plot(freqRange, signalPower);
    xlabel('Frequency (Hz)');
    ylabel('Power');
    titleString = strcat('{\bf Frequency vs. Power: ', subTitle, '}');
    title(titleString);
    xlim([1 maxFreq]);
    
end

