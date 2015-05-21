function [freqAndCoherence, avgCoherence] = Coherence(signalVector1, signalVector2, samplingRate, frequencyRange)
% Function: [freqAndCoherence] = Coherence(signalVector1, signalVector2, samplingRate)
% Author: William Michael Mortl
% Feel free to use this code for educational purposes, any other use
%     requires citations and recompence to William Michael Mortl
% Description: calculates coherence by frequency 
% Inputs: 
%    signalVector1 === the column vector containing signal1
%    signalVector2 === the column vector containing signal2
%    samplingRate === the sampling rate for the vector
%    frequencyRange === optional, the frequency range to get the average coherence for
% Outputs:
%    freqAndCoherence === 2 column matrix, 1st column is frequencies, 2nd column is the coherence of that frequency
        
    %% make sure that songs are now the same length by padding zeros
    [len1, ~] = size(signalVector1);
    [len2, ~] = size(signalVector2);
    if (len1 > len2)
        songTemp = zeros(len1, 1);
        songTemp(1 : len2) = signalVector2;
        signalVector2 = songTemp;
    elseif (len1 < len2)
        songTemp = zeros(len2, 1);
        songTemp(1 : len1) = signalVector1;
        signalVector1 = songTemp;
    end
    
    %% get coherence
    [coherence, freq] = mscohere(signalVector1, signalVector2, [], [], [], samplingRate);
    
    %% only return the selected range
    freqAndCoherence = horzcat(freq, coherence);
    if (nargin > 3)    
        withinRange = find((freqAndCoherence(:, 1) >= frequencyRange(1)) && ...
                           (freqAndCoherence(:, 1) <= frequencyRange(2)));
        freqAndCoherence = freqAndCoherence(withinRange, :);   
    end
    
    %% average coherence in range
    avgCoherence = mean(freqAndCoherence(:, 2));
    
end

