function result = laplacian_scan(dist, neighbor_type, ui_fig)
    d = uiprogressdlg(ui_fig, 'Title','Performing Laplacian scan','Indeterminate','on');

    n4 = [0 1 0; 1 -4 1; 0 1 0];
    n8 = [1 1 1; 1 -8 1; 1 1 1];
    if neighbor_type == 4; n = n4; else; n = n8; end
    tmp = conv2(dist, n, 'same');
    result = tmp < 0;
    
    close(d);
end
