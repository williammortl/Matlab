function [index] = GetTransitionProbablityIndex(transitionProbabilities, chainLength, numGranualizedValues)

    %% initialize vars
    index = 1;

    %% calculate index in transition probabilities where the probability
    %%  for the transition expressed in the transitionVector is stored
    for i = 1:(chainLength)
        powVal = chainLength - i;
        index = index + ((numGranualizedValues ^ powVal) * (transitionProbabilities(i) - 1));
    end
end

