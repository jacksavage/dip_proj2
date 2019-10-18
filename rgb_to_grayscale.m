function grayscale = rgb_to_grayscale(rgb)
%RGB_TO_GRAYSCALE Convert a 3D RGB matrix to a 1D grayscale matrix
    norm_rgb = normalize_ints(rgb);
    
    r = norm_rgb(:,:,1);
    g = norm_rgb(:,:,2);
    b = norm_rgb(:,:,3);
    
    grayscale = 0.2126 * r + 0.7152 * g + 0.0722 * b;
end
