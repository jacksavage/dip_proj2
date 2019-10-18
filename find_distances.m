function result = find_distances(img, ui_fig)
    if nargin > 1; progress = uiprogressdlg(ui_fig, 'Title','Computing distance transform'); end
    [h, w] = size(img);
    
    % scans
    ew = zeros(h, w);
    we = zeros(h, w);
    ns = zeros(h, w);
    sn = zeros(h, w);
    
    for r = 1:h
        if nargin > 1; progress.Value = r / h / 2; end
        
        cnt = 0;
        for c = 1:w
            if img(r,c) > 0; cnt = cnt+1; else; cnt = 0; end
            ew(r,c) = cnt;
        end
        
        cnt = 0;
        for c = w:-1:1
            if img(r,c) > 0; cnt = cnt+1; else; cnt = 0; end
            we(r,c) = cnt;
        end
    end
    
    for c = 1:w
        progress.Value = 0.5 + c / w / 2;
        
        cnt = 0;
        for r = 1:h
            if img(r,c) > 0; cnt = cnt+1; else; cnt = 0; end
            ns(r,c) = cnt;
        end
        
        cnt = 0;
        for r = h:-1:1
            if img(r,c) > 0; cnt = cnt+1; else; cnt = 0; end
            sn(r,c) = cnt;
        end
    end
    
    ew_we = min(ew, we);
    ns_sn = min(ns, sn);
    result = min(ew_we, ns_sn);
end
