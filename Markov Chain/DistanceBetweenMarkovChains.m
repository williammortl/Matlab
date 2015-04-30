function [distance] = DistanceBetweenMarkovChains(markovChain1, markovChain2)

    %% default return value
    distance = Inf;

    %% value for comparison
    THRESHOLD = 1e-6;

    %% check basic properties for sameness
    if ((markovChain1.Granularity ~= markovChain2.Granularity) || ...
        (markovChain1.ChainLength ~= markovChain2.ChainLength))
        return;
    end

    %% check to make sure that the two chains have the same granualized values
    [len1, ~] = size(markovChain1.GranualizedValues);
    [len2, ~] = size(markovChain2.GranualizedValues);
    if (len1 ~= len2)
        return;
    end
    diffSum = sum(abs(markovChain1.GranualizedValues - markovChain2.GranualizedValues));
    if (diffSum >= THRESHOLD)
        return;
    end

    %% at this point, the markov chains are comparable, distance
    %%  metric is implemented here
    distance = sum(abs(markovChain1.TransitionProbabilities - markovChain2.TransitionProbabilities)) / 2;

end

