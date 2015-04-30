classdef MarkovChain

    % PUBLIC properties
    properties
        Granularity
        ChainLength
        GranualizedValues
        TransitionProbabilities
    end
        
    % PRIVATE properties
    properties (Access = private)
        GranualizedValuesLookup
    end

    % PUBLIC methods
    methods
        
        %% get transition probability for the transitionVector, which contains ordinals for values
        function [probability] = TransitionProbability(obj, transitionVector)
            probability = obj.TransitionProbabilities(obj.GetTransitionProbabilityIndex(transitionVector));
        end
        
        %% get transition probability index for the transitionVector, which contains ordinals for values
        function [index] = TransitionProbabilityIndex(obj, transitionVector)
            [numGranualizedValues, ~] = size(obj.GranualizedValues);
            index = GetTransitionProbablityIndex(transitionVector, obj.ChainLength, numGranualizedValues);
        end    
        
        %% get the transitions for an index
        function [transitions] = GetTransitionsFromIndex(obj, index)
            [numGranualizedValues, ~] = size(obj.GranualizedValues);
            transitions = GetTransitionsFromIndex(index, obj.ChainLength, numGranualizedValues);
        end
        
        %% builds a matrix representing the chain in the following format: 
        %%  horzcat(probabilities, granualized_values, [granularity; chain length])
        function [matrix] = GetMatrixDehydration(obj)
            
            %% get sizes of things to save
            [sizeTransitionProbabilities, ~] = size(obj.TransitionProbabilities);
            [sizeGranualizedValues, ~] = size(obj.GranualizedValues);
            
            %% create matrix to save
            matrix = zeros(sizeTransitionProbabilities, 3);
            
            %% set values
            matrix(:, 1) = obj.TransitionProbabilities;
            matrix(1 : sizeGranualizedValues, 2) = obj.GranualizedValues;
            matrix(1, 3) = obj.Granularity;
            matrix(2, 3) = obj.ChainLength;
            
        end
        
        %% load a markov chain from a file
        function SaveToFile(obj, fileName)
            
            %% save to file
            csvwrite(fileName, obj.GetMatrixDehydration());
            
        end
        
        %% compare this markov chain
        function [distance] = DistanceFrom(obj, differentChain)
            distance = DistanceBetweenMarkovChains(obj, differentChain);
        end
        
        %% generate new data from chain
        function [output] = Generate(obj, length)
            output = MarkovChainGenerate(length, obj.TransitionProbabilities, obj.ChainLength, obj.GranualizedValues, obj.GranualizedValuesLookup);
        end
        
    end

    % PUBLIC STATIC methods
    methods(Static)
        
        %% load a markov chain from a file
        function [obj] = FactoryFile(fileName)
            
            %% load csv
            matrix = csvread(fileName);
            
            %% create object to return
            obj = MarkovChain.FactoryRehydrateMatrix(matrix);
            
        end
        
        %% rehydrate from a dehydration matrix
        function [obj] = FactoryRehydrateMatrix(matrix)
            
            %% create object to return
            obj = MarkovChain();

            %% set object properties
            obj.Granularity = matrix(1, 3);
            obj.ChainLength = matrix(2, 3);
            obj.GranualizedValues = matrix(1 : obj.Granularity, 2);
            obj.TransitionProbabilities = matrix(:, 1);
            
            %% create GranualizedValuesLookup
            obj.GranualizedValuesLookup = containers.Map;
            for i = 1 : obj.Granularity
                obj.GranualizedValuesLookup(num2str(obj.GranualizedValues(i))) = i;
            end
        end
        
        %% train the markov chain from data
        function [obj] = FactoryTrain(vector, chainLength, granualizedValues, granualizedValuesLookup)
            
            %% create object to return
            obj = MarkovChain();
            
            %% set object properties
            [granularity, ~] = size(granualizedValues);
            obj.Granularity = granularity;
            obj.ChainLength = chainLength;
            obj.GranualizedValues = granualizedValues;
            obj.GranualizedValuesLookup = granualizedValuesLookup;

            %% train markov chain
            [obj.TransitionProbabilities] = TrainMarkovChain(vector, obj.ChainLength, obj.GranualizedValues, obj.GranualizedValuesLookup);
            
        end
        
        %% train the markov chain from data
        function [obj] = FactoryParallelTrain(vector, chainLength, granualizedValues, granualizedValuesLookup, threads)
            
            %% create object to return
            obj = MarkovChain();
            
            %% set object properties
            [granularity, ~] = size(granualizedValues);
            obj.Granularity = granularity;
            obj.ChainLength = chainLength;
            obj.GranualizedValues = granualizedValues;
            obj.GranualizedValuesLookup = granualizedValuesLookup;

            %% train markov chain
            [obj.TransitionProbabilities] = ParallelTrainMarkovChain(vector, obj.ChainLength, obj.GranualizedValues, obj.GranualizedValuesLookup, threads);
            
        end
        
        %% granualize and compress
        function [obj] = FactoryCompressGranualizeTrain(vector, chainLength, compressRate, granularity)
            
            %% compress
            vector = CompressVector(vector, compressRate);
            
            %% granualize
            [vector, granualizedValues, granualizedValuesLookup] = GranualizeVector(vector, granularity, minVal, maxVal);
            
            %% train
            obj = MarkovChain.FactoryTrain(vector, chainLength, granualizedValues, granualizedValuesLookup);
            
        end
        
        %% parallel granualize and compress
        function [obj] = FactoryParallelCompressGranualizeTrain(vector, chainLength, compressRate, granularity, threads)
            
            %% compress
            vector = CompressVector(vector, compressRate);
            
            %% granualize
            [vector, granualizedValues, granualizedValuesLookup] = GranualizeVector(vector, granularity, minVal, maxVal);
            
            %% train
            obj = MarkovChain.ParallelTrainMarkovChain(vector, chainLength, granualizedValues, granualizedValuesLookup, threads);
            
        end
        
    end
    
    % PRIVATE methods
    methods (Access = private)
        
        %% private constructor
        function [obj] = MarkovChain()

            %% do nothing... this is to force the factory pattern
            
        end
        
    end
         
end

