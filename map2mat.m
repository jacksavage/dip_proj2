function result = map2mat(map)
    keys = cell2mat(map.keys);
    values = zeros(size(keys));
    
    for i = 1:length(keys)
        key = keys(i);
        value = map(key);
        values(i) = value;
    end
    
    result = [keys; values];
end

