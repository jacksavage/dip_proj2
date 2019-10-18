function ridge = ridge_scan_rows(dist, ui_fig)
    p = uiprogressdlg(ui_fig, 'Title','Ridge scanning rows');
    [h, w] = size(dist);
    ridge = zeros(h, w);
    
    for r = 1:h
        p.Value = r / h;
        ridge(r,:) = ridge_scan(dist(r,:));
    end
    
    ridge(dist == max(dist(:))) = 1;
end

