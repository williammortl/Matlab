function [transitionProbabilities] = GetTransitionsFromIndex(index, chainLength, numGranualizedValues)

    %% initialize vars
    transitionProbabilities = zeros(chainLength, 1);

    %% calculate index in transition probabilities where the probability
    %%  for the transition expressed in the transitionVector is stored
    for i = chainLength : -1 : 1
        
        % calculate vals for loop
        powVal = i - 1;
        divisor = (numGranualizedValues ^ powVal);
        
        % check for mod = 0
        if (mod(index, divisor) == 0)
            transition = floor(index / divisor);
        else
            transition = floor(index / divisor) + 1;
        end
        index = index - (divisor * (transition - 1));
        
        % store in transitions
        transitionProbabilities(chainLength - i + 1) = transition;
    end
end

