function out = add_border(in, fill, thickness)
    if nargin < 3; thickness = 1; end
    [h, w] = size(in);
    lr = repmat(fill, h, thickness);
    tb = repmat(fill, thickness, w + thickness * 2);
    out = [tb; [lr, in, lr]; tb;];
end

