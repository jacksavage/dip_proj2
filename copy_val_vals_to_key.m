function copy_val_vals_to_key(dictionary, key, value)
    % if the value is a key
    if dictionary.isKey(value)
        
        % copy all of its values over
        for val_val = dictionary(key)
            if ~dictionary.isKey(val_val) 
                if ~ismember(val_val, d(key))
                	dictionary(key) = [d(key), val_val];
                end
            else
                copy_val_vals_to_key(dictionary, key, val_val);
            end
        end
        
        dictionary.remove(value);
    end
end

