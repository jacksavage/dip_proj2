im = imread('img\bars.jpg');
n4 = [0 1 0; 1 -4 1; 0 1 0];
n8 = [1 1 1; 1 -8 1; 1 1 1];
thr = 180;
bin = add_border(im > thr, 0, 1);
dist = find_distances(bin);
dist = dist / max(dist(:));
l4 = conv2(dist, n4, 'same') < 0;
l8 = conv2(dist, n8, 'same') < 0;

l8 = post_process(l8);

grn = [0 255 0];
bin_l4 = color_where(bin * 255, l4, grn);
bin_l8 = color_where(bin * 255, l8, grn);

%figure; imshow(im);
%figure; imshow(dist); title('dist'); 
%figure; imshow(bin_l4); title('bin L4'); 
figure; imshow(bin_l8); title('bin L8');

function out = post_process(in)
    [h,w] = size(in);
    out = zeros(h,w);
    
    for r = 2:h-1
        for c = 2:w-1
            if in(r,c) > 0
                 frame = in(r-1:r+1,c-1:c+1);
                 out(r,c) = has_corner(frame);
            end
        end
    end
end

function result = has_corner(frame)
    result = false;
    corner = [1 0 1];

    % north, south, east, west checks
    if isequal(frame(1,:), corner); result = true; return; end
    if isequal(frame(end,:), corner); result = true; return; end
    if isequal(frame(:,1), corner); result = true; return; end
    if isequal(frame(:,end), corner); result = true; return; end
    
    % north east, north west, south west, south east checks
    if isequal([frame(2,1) frame(1,1) frame(1,2)], corner); result = true; return; end
    if isequal([frame(1,2) frame(1,3) frame(2,3)], corner); result = true; return; end
    if isequal([frame(2,3) frame(3,3) frame(3,2)], corner); result = true; return; end
    if isequal([frame(3,2) frame(3,1) frame(2,1)], corner); result = true; return; end
end
