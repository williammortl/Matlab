classdef CustomSignal
% Class: CustomSignal
% Author: William Michael Mortl
% Feel free to use this code for educational purposes, any other use
%     requires citations and recompence to William Michael Mortl
% Description: this class wraps a signal, use the static Factory methods to construct

    % PUBLIC properties
    properties
        SignalVector                % the column vector containing the signal
        LengthSignalVector          % length of the signal
        SamplingRate                % the sampling rate for the signal
    end
        
    % PRIVATE properties
    properties (Access = private)
    end
    
    % PUBLIC methods
    methods
        
        function [fig] = PlotFreqPower(obj, frequencyRange)
        % Method: [fig] = PlotFreqPower(obj, frequencyRange)
        % Description: creates a plot of frequency vs. power
        % Inputs: 
        %    frequencyRange === optional, [freq. min, freq. max]
        % Outputs:
        %    obj === the signal object
            
            %% plot frequency to power
            if (nargin < 2)
                fig = PlotFrequencyVsPower(obj.SignalVector);
            else
                fig = PlotFrequencyVsPower(obj.SignalVector, frequencyRange);                
            end
                    
        end
        
        function [freqAndCoherence, avgCoherence] = Coherence(obj, signalCompareTo, frequencyRange)
        % Method: [freqAndCoherence] = Coherence(obj, signalVector, frequencyRange)
        % Description: calculates the coherences for each frequency
        % Inputs: 
        %    signalCompareTo === a Custom Signal to compare to
        %    frequencyRange === optional, the frequency range to get the coherences for
        % Outputs:
        %    freqAndCoherence === 2 column matrix, 1st column is frequencies, 2nd column is the coherence of that frequency
        %    avgCoherence === the average coherence across all frequencies
            
            %% check to make sure sampling rates are the same
            if (obj.SamplingRate ~= signalCompareTo.SamplingRate)
                freqAndCoherence = [];
                avgCoherence = 0;
                return;
            end
        
            %% calculate and return
            if (nargin < 3)
                [freqAndCoherence, avgCoherence] = Coherence(obj.SignalVector, signalCompareTo.SignalVector, obj.SamplingRate);
            else
                [freqAndCoherence, avgCoherence] = Coherence(obj.SignalVector, signalCompareTo.SignalVector, obj.SamplingRate, frequencyRange);
            end 
            
        end
        
        function [fig] = PlotCoherence(obj, signalCompareTo, frequencyRange)
        % Method: [freqAndCoherence] = CoherenceTo(obj, signalVector, frequencyRange)
        % Description: plots the coherence
        % Inputs: 
        %    signalCompareTo === a Custom Signal to compare to
        %    frequencyRange === optional, the frequency range to get the coherences for
        % Outputs:
        %    fig === plots the coherence between the signals
        
            %% calculate
            if (nargin < 3)
                [fig] = PlotCoherence(obj.SignalVector, obj.SamplingRate, signalCompareTo.SignalVector);
            else
                [fig] = PlotCoherence(obj.SignalVector, obj.SamplingRate, signalCompareTo.SignalVector, frequencyRange);
            end 
            
        end
        
        function [frequencyPower, fftVector] = FFTFreqAndPower(obj)
        % Method: [frequencyPower, fftVector] = FFTFreqAndPower()
        % Author: William Michael Mortl
        % Feel free to use this code for educational purposes, any other use
        %     requires citations and recompence to William Michael Mortl
        % Description: analyzes the signal using FFT
        % Inputs: 
        % Outputs:
        %    frequencyPower === 2 column matrix, 1st column is frequencies, 2nd column is the power of that frequency
        %    fftVector === the raw fast fourier transformed vector  
        
            [frequencyPower, fftVector] = FFTFreqAndPower(obj.SignalVector, obj.SamplingRate);
        end
        
    end

    % PUBLIC STATIC methods
    methods(Static)
        
        function [obj] = FactoryVector(signalVector, samplingRate)
        % Method: [obj] = FactoryVector(signalVector, samplingRate)
        % Description: static, creates a Signal object from the signal vector using the sampling rate
        % Inputs: 
        %    signalVector === the column vector containing the signal
        %    samplingRate === the sampling rate for the vector
        % Outputs:
        %    obj === the signal object

            %% create custom signal object
            obj = CustomSignal();
            
            %% set attributes
            obj.SignalVector = signalVector;
            [obj.LengthSignalVector, ~] = size(signalVector);
            obj.SamplingRate = samplingRate;
            
        end
        
        function [obj] = FactoryMP3(fileName)
        % Method: [obj] = FactoryMP3(fileName)
        % Description: static, creates a Signal object from the MP3 file
        % Inputs: 
        %    fileName === MP3 file name
        % Outputs:
        %    obj === the signal object
    
            %% load song and parse
            song = audioread(fileName);
            songInfo = audioinfo(fileName);
            
            %% call into other factory method
            obj = CustomSignal.FactoryVector(song(:, 1), songInfo.SampleRate);
            
        end

    end
    
    % PRIVATE methods
    methods (Access = private)
        
        function [obj] = CustomSignal()
        % Method: [obj] = CustomSignal()
        % Programmed by: William M Mortl
        % Description: private CustomSignal contructor, used to force 
        %              factory pattern
        % Inputs: 
        % Outputs:
        %    obj === the CustomSignal object
        
            %% do nothing... this is to force the factory pattern
            
        end
        
    end
         
end

