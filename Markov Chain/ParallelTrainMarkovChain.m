function [transitionProbabilities] = ParallelTrainMarkovChain(vector, chainLength, granualizedValues, granualizedValuesLookup, threads)

    %% get length of the vector, and split
    [lenVector, ~] = size(vector);
    [numGranualizedValues, ~] = size(granualizedValues);
    vectorChunk = uint64(lenVector / threads);
    
    %% multitask
    cluster = parcluster;
    job = createJob(cluster);
    start = 0;
    finish = 0;
    for i = 1 : threads
        start = finish + 1;
        finish = min((start + vectorChunk), lenVector);
        createTask(job, @TrainMarkovChain, 1, {vector(start : finish), chainLength, granualizedValues, granualizedValuesLookup});
    end
    
    %% submit, wait, and retrieve data
    fprintf('\n%d threads started to train a markov chain...\n', threads);
    tic;
    submit(job);
    wait(job);
    data = fetchOutputs(job);
    fprintf('The operation took %.2f minutes.\n', toc / 60);
    
    %% combine
    transitionProbabilities = zeros(numGranualizedValues ^ chainLength, 1);
    for i = 1 : threads
        transitionProbabilities = transitionProbabilities + data{i};
    end
    transitionProbabilities = transitionProbabilities / threads;
    
end

