function [fig] = PlotFrequencyVsPower(signalVector, samplingRate, frequencyRange)
% Function: [fig] = PlotFrequencyVsPower(signalVector, frequencyRange)
% Author: William Michael Mortl
% Feel free to use this code for educational purposes, any other use
%     requires citations and recompence to William Michael Mortl
% Description: Plots frequency vs. power
% Inputs: 
%    signalVector === the column vector containing the signal
%    samplingRate === the sampling rate for the vector
%    frequencyRange === optional, [freq. min, freq. max]
% Outputs:
%    fig === the plot

    %% fft
    [frequencyPower, ~] = FFTFreqAndPower(signalVector, samplingRate);

    %% max freq limit?
    if (nargin < 3)
        frequencyRange = [1 0];
        [frequencyRange(2), ~] = size(obj.FrequencyPower);
        frequencyRange(2) = obj.FrequencyPower(frequencyRange(2), 1);
    end

    %% plot frequency to power
    fig = figure;
    plot(frequencyPower(:, 1), frequencyPower(:, 2));
    xlabel('Frequency (Hz)');
    ylabel('Power');
    title('{\bf Frequency vs. Power}');
    xlim(frequencyRange);
    
end

