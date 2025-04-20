function encoded = LzwEncod16(inputData)
    % Ensure the input is treated as a character array
    inputData = char(inputData(:));

    % Create initial dictionary with ASCII characters (0 to 255)
    dictionary = containers.Map('KeyType', 'char', 'ValueType', 'double');
    for idx = 0:255
        dictionary(char(idx)) = idx;
    end

    % Start code assignment from 32768
    newCode = 32768;
    encoded = [];
    current = '';

    % Perform the LZW encoding
    for idx = 1:length(inputData)
        symbol = inputData(idx);
        combined = [current symbol];

        if isKey(dictionary, combined)
            current = combined;
        else
            % Output code for current sequence
            encoded(end+1) = dictionary(current);
            % Add new sequence to dictionary
            dictionary(combined) = newCode;
            newCode = newCode + 1;
            % Reset current to the new symbol
            current = symbol;
        end
    end

    % Output the code for the final sequence
    if ~isempty(current)
        encoded(end+1) = dictionary(current);
    end

    % Compute sizes in bits
    originalBits = length(inputData) * 8;
    compressedBits = length(encoded) * 9;  % Using 16 bits per code
    compressionRatio = 1 - (compressedBits / originalBits);

    % Display compression statistics
    fprintf('Original: %d bits\n', originalBits);
    fprintf('Compressed: %d bits\n', compressedBits);
    fprintf('Compression ratio: %.4f\n', compressionRatio);
end

