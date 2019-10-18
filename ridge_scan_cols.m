function ridge = ridge_scan_cols(dist, ui_fig)
    p = uiprogressdlg(ui_fig, 'Title','Ridge scanning columns');
    [h, w] = size(dist);
    ridge = zeros(h, w);
    
    for c = 1:w
        p.Value = c / w;
        col_dist = dist(:,c);
        ridge_col = ridge_scan(col_dist');
        ridge(:,c) = ridge_col';
    end
    
    ridge(dist == max(dist(:))) = 1;
end

