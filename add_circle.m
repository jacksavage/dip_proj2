function indices = add_circle(image, row, col, radius)
    [height, width] = size(image);
    [cols, rows] = meshgrid(1:width, 1:height);
    distances = euclid_distance(rows, cols, row, col);
    indices = find(distances <= radius);
end
