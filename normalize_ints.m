function normalized = normalize_ints(intensities)
    %NORMALIZE_INTS Convert integers to doubles between 0 and 1
    if isinteger(intensities)
        class_name = class(intensities);
        int_min = double(intmin(class_name));
        int_max = double(intmax(class_name));
        normalized = (double(intensities) - int_min) / int_max;
    else
        normalized = intensities;
    end
end
