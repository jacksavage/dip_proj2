function distance = euclid_distance(row1, col1, row2, col2)
    distance = sqrt((row1 - row2) .^ 2 + (col1 - col2) .^2);
end
