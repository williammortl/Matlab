classdef MarkovChain
% Class: MarkovChain
% Author: William Michael Mortl
% Feel free to use this code for educational purposes, any other use
%     requires citations and recompence to William Michael Mortl
% Description: this class is not meant to be contructed, instead 
%              it is inherited by all markov chain classes

    % PUBLIC properties
    properties
        Granularity                 % how many values exist
        ChainLength                 % how long the chain is
        GranualizedValues           % list of all the values
    end
    
    % PUBLIC abstract methods
    methods (Abstract)
        
        %% get the probability of the transition
        [probability] = TransitionProbability(obj, transitionVector)            
        
        %% given the transitionVector of length ChainLength - 1, randonly select next
        [nextValue] = GenerateNext(obj, transitionVector)

        %% generate new data non-deterministically based upon Markov Chain
        [output] = Generate(obj, length, startValue)
        
        %% save this chain to a file
        SaveChainToFile(obj, file)

    end
    
    % PUBLIC STATIC methods
    methods(Static)
    end
    
    % PRIVATE methods
    methods (Access = private)
        
        function [obj] = MarkovChain()
        % Method: [obj] = MarkovChain()
        % Programmed by: William M Mortl
        % Description: private MarkovChain contructor, used to  
        %              stop construction
        % Inputs: 
        % Outputs:
        %    obj === the CustomSignal object
        
            %% do nothing... this is to stop construction
            
        end
        
    end
end

