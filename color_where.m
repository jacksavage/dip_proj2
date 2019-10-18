function colored = color_where(image, logic, color)
    if length(size(image)) < 3
        r = image;
        g = image;
        b = image;
    else % assume its a grayscale
        r = image(:,:,1);
        g = image(:,:,2);
        b = image(:,:,3);
    end
    
    r(logic > 0) = color(1);
    g(logic > 0) = color(2);
    b(logic > 0) = color(3);
    
    colored = cat(3, r, g, b);
end
