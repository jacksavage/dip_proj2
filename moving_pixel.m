image = ones(10, 10);
[height, width] = size(image);

for row = 1:height
    for col = 1:width
        image(row, col) = 0;
        draw(image);
        pause(1);
        image(row, col) = 1;
    end
end

function draw(image)
    imshow(image, 'InitialMagnification', 'fit');
    pixelgrid;
end
