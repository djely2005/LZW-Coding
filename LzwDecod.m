function decoded = LzwDecod(encoded)
    % Create initial dictionary with ASCII characters (0 to 255)
    dictionary = containers.Map('KeyType', 'double', 'ValueType', 'char');
    for idx = 0:255
        dictionary(idx) = char(idx);
    end

    % Start code assignment from 32768
    newCode = 32768;
    
    % Initialize variables
    if isempty(encoded)
        decoded = '';
        return;
    end
    
    % Process the first code
    oldCode = encoded(1);
    decoded = dictionary(oldCode);
    current = decoded;
    
    % Process remaining codes
    for idx = 2:length(encoded)
        code = encoded(idx);
        
        if isKey(dictionary, code)
            entry = dictionary(code);
        else
            % Special case for code not in dictionary
            entry = [current current(1)];
        end
        
        decoded = [decoded entry];
        
        % Add new sequence to dictionary
        newEntry = [current entry(1)];
        dictionary(newCode) = newEntry;
        newCode = newCode + 1;
        
        current = entry;
    end
end

