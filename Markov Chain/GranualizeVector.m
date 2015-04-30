function [granualizedVector, granualizedValues, granualizedValuesLookup] = GranualizeVector(vector, granularity, minVal, maxVal)

    %% get rows
    [rowCount, ~] = size(vector);
    
    %% generate breaks
    if (nargin < 4)
        minVal = min(vector);
        maxVal = max(vector);
    else
        minVal = min(min(vector), minVal);
        maxVal = max(max(vector), maxVal);
    end
    breakSpacing = (maxVal - minVal) / granularity;

    %% return new unique values
    granualizedValues = zeros(granularity, 1);
    granualizedValuesLookup = containers.Map;
    newValue = minVal + (0.5 * breakSpacing);
    for i = 1 : granularity
        granualizedValues(i) = newValue;
        granualizedValuesLookup(num2str(newValue)) = i;
        newValue = newValue + breakSpacing;
    end

    %% value for comparison
    THRESHOLD = 1e-6;
    
    %% replace values in the vectors with the mean value between breaks
    granualizedVector = zeros(rowCount, 1);
    for row = 1:rowCount
        breakVal = minVal;
        for i = 1:granularity
            breakVal = breakVal + breakSpacing;
            difference = abs(breakVal - vector(row));
            if ((vector(row) <= breakVal) || (difference <= THRESHOLD))
                newValue = breakVal - (0.5 * breakSpacing); 
                granualizedVector(row) = newValue;
                break;
            end
        end
    end
        
end

