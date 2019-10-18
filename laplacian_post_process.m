function out = laplacian_post_process(in, ui_fig)
    p = uiprogressdlg(ui_fig, 'Title','Laplacian post processing');
    [h,w] = size(in);
    out = zeros(h,w);

    for r = 2:h-1
        p.Value = r / (h - 1);
        
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
