function [transitionProbabilities] = TrainMarkovChain(vector, chainLength, granualizedValues, granualizedValuesLookup)

    %% get length of the vector
    [lenVector, ~] = size(vector);

    %% get granualized values
    [numGranualizedValues, ~] = size(granualizedValues);

    %% create empty probability vector
    transitionProbabilities = zeros(numGranualizedValues ^ chainLength, 1);

    %% loop through the vector, train the Markov chain
    fprintf('\n');
    previousValues = [arrayfun( @(x) granualizedValuesLookup(num2str(x)), vector(1 : (chainLength - 1))); 0];
    tic;
    for i = chainLength:lenVector

        % add current value to end of previousValues
        previousValues(chainLength) = granualizedValuesLookup(num2str(vector(i)));

        % add a count to the probability
        index = GetTransitionProbablityIndex(previousValues, chainLength, numGranualizedValues);
        transitionProbabilities(index) = transitionProbabilities(index) + 1;

        % delete oldest previousValues
        previousValues(1 : (chainLength - 1)) = previousValues(2 : chainLength);

        % print status
        if (mod(i, 10000) == 0)
            fprintf('Last operation took %.2f seconds, currently training at input vector ordinal: %d...\n', toc, i);
            tic;
        end

    end
    fprintf('\n');

    %% divide by vector length to get probability from counts
    transitionProbabilities = transitionProbabilities / lenVector;

end