function [compressedVector] = CompressVector(vector, rate)

    %% init vars
    [vectorLen, ~] = size(vector);
    newSize = ceil(vectorLen / rate);
    compressedVector = zeros(newSize, 1);
    
    %% create compressedVector using means from vector
    start = 1;
    stop = start + rate - 1;
    fprintf('\n');
    tic;
    for i = 1 : newSize
        
        % compress
        compress = vector(start : stop);
        newValue = mean(compress);
        
        % set output
        compressedVector(i) = newValue;
                
        % update range
        start = stop + 1;
        stop = min(start + rate - 1, vectorLen);
        
        % print status
        if (mod(i, 10000) == 0)
            fprintf('Last operation took %.2f seconds, currently compressing at ordinal: %d...\n', toc, start);
            tic;
        end

    end
    fprintf('\n');

end

