function indices = add_rectangle(image, row, col, height, width)
    [image_height, image_width] = size(image);
    [col_grid, row_grid] = meshgrid(1:image_width, 1:image_height);
    rows = (row_grid >= row) & (row_grid <= row + height - 1);
    cols = (col_grid >= col) & (col_grid <= col + width - 1);
    indices = find(rows & cols);
end
