function [output] = MarkovChainGenerate(length, transitionProbabilities, chainLength, granualizedValues, granualizedValuesLookup)

    %% length of granualizedValues
    [numGranualizedValues, ~] = size(granualizedValues);
    nonZeroProbabilities = find(transitionProbabilities);
    [numNonZeroProbabilities, ~] = size(nonZeroProbabilities);
    
    %% randomly select a start to the data vector
    output = ones(length, 1) * granualizedValues(1);
    output(1 : chainLength) = granualizedValues(GetTransitionsFromIndex(nonZeroProbabilities(randi([1 numNonZeroProbabilities], 1, 1)), chainLength, numGranualizedValues));
    
    %% generate the output
    fprintf('\n');
    tic;
    for i = (chainLength + 1) : length
        
        % get the numGranualizedValues of transitionProbabilities that
        %   represent possible transitions
        transitions = output(i - chainLength + 1 : i);
        transitions = arrayfun(@(x) granualizedValuesLookup(num2str(x)), transitions);
        startIndex = GetTransitionProbablityIndex(transitions, chainLength, numGranualizedValues);
        possibleTransitions = transitionProbabilities(startIndex : startIndex + numGranualizedValues - 1);

        % find the next transition
        indexNext = RandomProbability(possibleTransitions) + startIndex - 1;
        transitions = granualizedValues(GetTransitionsFromIndex(indexNext, chainLength, numGranualizedValues));
        output(i) = transitions(chainLength);
        
        % print status
        if (mod(i, 10000) == 0)
            fprintf('Last operation took %.2f seconds, currently generating new data at ordinal: %d...\n', toc, i);
            tic;
        end
        
    end
    fprintf('\n');

end

function [index] = RandomProbability(probVector)

    %% var init
    index = 0;
    [numProbVector, ~] = size(probVector);
    probSum = sum(probVector);
    r = rand() * probSum;
    
    %% find the index
    accumulator = 0;
    for i = 1 : numProbVector
        accumulator = accumulator + probVector(i);
        if (accumulator >= r)
            index = i;
            break;
        end
    end
    
end
