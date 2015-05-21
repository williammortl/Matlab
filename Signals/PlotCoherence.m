function [fig] = PlotCoherence(signalVector1, samplingRate, signalVector2, frequencyRange)
% Function: [fig] = PlotCoherence(signalVector1, samplingRate, signalVector2, frequencyRange)
% Author: William Michael Mortl
% Feel free to use this code for educational purposes, any other use
%     requires citations and recompence to William Michael Mortl
% Description: Plots frequency vs. power
% Inputs: 
%    signalVector1 === the column vector containing the signal
%    samplingRate === the sampling rate for the vector
%    signalVector2 === the column vector containing the second signal
%    frequencyRange === optional, [freq. min, freq. max]
% Outputs:
%    fig === the plot

    %% calculate
    if (nargin < 4)
        [freqAndCoherence, avgCoherence] = Coherence(signalVector1, signalVector2, samplingRate);
    else
        [freqAndCoherence, avgCoherence] = Coherence(signalVector1, signalVector2, samplingRate, frequencyRange);
    end 

    %% plot
    fig = figure;
    plot(freqAndCoherence(:, 1), freqAndCoherence(:, 2));
    xlabel('Frequency (Hz)');
    ylabel('Percent Similarity');
    titleString = {'{\bf Signal Percent Similarity Graph}'; strcat('{\bf Average Percent Similarity: ', num2str(avgCoherence), '}')};
    title(titleString);            

    %% if frequency range, then limit plot
    if (nargin > 3)
        xlim(frequencyRange);
    end
    
end



