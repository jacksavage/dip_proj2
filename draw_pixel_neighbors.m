canvas = ones([5 5 3]);
gray = [0.5 0.5 0.5];
canvas(3, 3, :) = [0 0 0];

% diagonal neighbors
img = canvas;
img(2, 2, :) = gray; img(2, 4, :) = gray; img(4, 2, :) = gray; img(4, 4, :) = gray;
figure;
imshow(img, 'InitialMagnification', 'fit');
pixelgrid;
title('D neighbors');

% 4 neighbors
img = canvas;
img(2, 3, :) = gray; img(4, 3, :) = gray; img(3, 2, :) = gray; img(3, 4, :) = gray;
figure;
imshow(img, 'InitialMagnification', 'fit');
pixelgrid;
title('4 neighbors');

% 8 neighbors
img = canvas;
img(2, 2, :) = gray; img(2, 4, :) = gray; img(4, 2, :) = gray; img(4, 4, :) = gray;
img(2, 3, :) = gray; img(4, 3, :) = gray; img(3, 2, :) = gray; img(3, 4, :) = gray;
figure;
imshow(img, 'InitialMagnification', 'fit');
pixelgrid;
title('8 neighbors');