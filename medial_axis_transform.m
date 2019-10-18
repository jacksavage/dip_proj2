function result = medial_axis_transform(image, ui_fig)
    progress = uiprogressdlg(ui_fig, 'Title','Skeletonizing image');
    [height, width] = size(image);
    result = zeros(height, width);
        
    for p_row = 1:height
        progress.Value = p_row / height;
        for p_col = 1:width
            if image(p_row,p_col) > 0
                % search up
                up = 0;
                for row = p_row-1:-1:1
                    up = up+1;
                    if image(row,p_col) == 0; break; end
                end

                % search down
                down = 0;
                for row = p_row+1:height
                    down = down+1;
                    if image(row,p_col) == 0 || down > up; break; end
                end

                % search left
                left = 0;
                for col = p_col-1:-1:1
                    left = left+1;
                    if image(p_row,col) == 0 || left > up; break; end
                end

                % search right
                right = 0;
                for col = p_col+1:width
                    right = right+1;
                    if image(p_row,col) == 0 || right > up; break; end
                end

                % check if this is on the medial axis
                dist = [up down left right];
                if numel(dist(dist == min(dist))) > 1; result(p_row,p_col) = 1; end
            end
        end
    end
end
