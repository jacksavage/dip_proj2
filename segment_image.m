function [result, map] = segment_image(image, connectivity, ui_fig)
% *image* must be grayscale (depth = 1)
% *threshold* is a double from 0 to 1
% *mode* is a connectivity char ('4', '8', 'M')
% *active* is a logical - when true, intensities above the threshold will be
% considered for segments - when false, intensities below the threshold
% will be

    [height, width] = size(image);
    result = zeros(height, width);
    segment_index = 1;
    
    map = [];
    progress = uiprogressdlg(ui_fig, 'Title','Segmenting image');
    
    switch connectivity
        case '4'
            % step through rows
            for row = 1:height
                progress.Value = row / height;
                
                % step through columns
                for col = 1:width
                    % current pixel active?
                    if image(row, col)
                        % check west neighbor when not in col 1
                        if col ~= 1
                            % west pixel active?
                            if image(row, col-1)
                                % west pixel already part of a segment?
                                if result(row, col-1) ~= 0
                                    % add current pixel to the segment
                                    result(row, col) = result(row, col-1);
                                else
                                    % create new segment
                                    result(row, col) = segment_index;
                                    result(row, col-1) = segment_index; 
                                end
                            end
                        end

                        % check north neighbor when not in row 1
                        if row ~= 1
                            % north neighbor active?
                            if image(row-1, col)
                                % is north pixel part of existing segment?
                                n = result(row-1, col) ~= 0;

                                % is west pixel part of existing segment?
                                if col ~= 1
                                    w = result(row, col-1) ~= 0;
                                else
                                    w = false;
                                end
                                
                                if n && w 
                                    % if they are the same segment
                                    if result(row-1, col) == result(row, col-1) 
                                        % add current pixel to that segment
                                        result(row, col) = result(row-1, col);
                                    else
                                        % add association between the two segs
                                        % sort it to prevent duplicate relationships
                                        relation = sort([result(row-1, col), result(row, col-1)]);
                                        if isempty(map) || ~ismember(relation, map, 'rows')
                                            map = [map; relation]; 
                                        end
                                    end
                                elseif n && ~w
                                    % add current pixel to north group
                                    result(row, col) = result(row-1, col);
                                elseif ~n && w 
                                    % add north pixel to west group
                                    result(row-1, col) = result(row, col-1);
                                elseif n && ~w
                                    % add north/curr pixel to a new group
                                    result(row, col) = segment_index;
                                    result(row - 1, col) = segment_index; 
                                end
                            end
                        end

                        % new segment found?
                        if result(row, col) == segment_index
                            % increment the segment index
                            segment_index = segment_index + 1;
                        end
                    end
                end
            end
        case '8'
            [result, map] = eight(image, progress);
        case 'M'
            [result, map] = m(image, progress);
        otherwise
            disp('unknown connectivity type selected');
            return;
    end
end

function [result, map] = eight(img, prog)
    map = [];
    [h, w] = size(img);
    result = zeros(h, w);
    id = 1;
    
    for r = 2:h
        prog.Value = r / h;
        for c = 2:w
            % active?
            if img(r,c) > 0
                % find linear index of potential neighbors
                % including the current pixel
                if c ~= w
                    pnr = [r, r, r-1, r-1, r-1];
                    pnc = [c, c-1, c-1, c, c+1];
                else
                    pnr = [r, r, r-1, r-1];
                    pnc = [c, c-1, c-1, c];
                end
                pn = grid2lin(h, pnr, pnc);
                
                % where are connected neighbors?
                n = pn(img(pn) > 0);
                if length(n) > 1
                    % what segments do neighbors already belong to?
                    seg = result(n);
                    if ~isempty(find(seg ~= 0)) % at least one is in an existing segment
                        % split into those w/ and w/o seg ids
                        hobos = n(seg == 0);
                        dwellers = n(seg ~= 0);
                        
                        % assign seg id of first dweller to all hobos
                        result(hobos) = result(dwellers(1));
                        
                        % more than one dweller?
                        if length(dwellers) > 1
                            % add relation for each dwellers seg id to that of the first
                            for di = 2:length(dwellers)
                                relation = sort([result(dwellers(1)), result(dwellers(di))]);
                                if isempty(map) || ~ismember(relation, map, 'rows')
                                    map = [map; relation]; 
                                end
                            end
                        end
                    else % none of them are in segments yet
                        % add them to the next unused segment id
                        result(n) = id;
                        
                        % increment the id
                        id = id+1;
                    end
                end
            end            
        end
    end
end

function [result, map] = m(img, prog)
    map = [];
    [h, w] = size(img);
    result = zeros(h, w);
    id = 1;
    
    for r = 2:h
        prog.Value = r / h;
        for c = 2:w
            % active?
            if img(r,c) > 0
                % find linear index of potential neighbors
                % including the current pixel
                if c ~= w
                    pnr = [r, r, r-1, r-1, r-1];
                    pnc = [c, c-1, c-1, c, c+1];
                else
                    pnr = [r, r, r-1, r-1];
                    pnc = [c, c-1, c-1, c];
                end
                pn = grid2lin(h, pnr, pnc);
                
                % which potential neighbors are active?
                apn = img(pn) > 0;
                
                % north west is connected if north and west are not
                if apn(3) && (apn(2) || apn(4)); apn(3) = false; end 
                
                % north east is connected if north and east are not
                if c ~= w && apn(5) && (apn(4) || (img(r,c+1) > 0)); apn(5) = false; end
                
                % where are connected neighbors?
                n = pn(apn);
                
                % select which seg ids to give neighbors
                if length(n) > 1
                    % what segments do neighbors already belong to?
                    seg = result(n);
                    if ~isempty(find(seg ~= 0)) % at least one is in an existing segment
                        % split into those w/ and w/o seg ids
                        hobos = n(seg == 0);
                        dwellers = n(seg ~= 0);
                        
                        % assign seg id of first dweller to all hobos
                        result(hobos) = result(dwellers(1));
                        
                        % more than one dweller?
                        if length(dwellers) > 1
                            % add relation for each dwellers seg id to that of the first
                            for di = 2:length(dwellers)
                                relation = sort([result(dwellers(1)), result(dwellers(di))]);
                                if isempty(map) || ~ismember(relation, map, 'rows')
                                    map = [map; relation]; 
                                end
                            end
                        end
                    else % none of them are in segments yet
                        % add them to the next unused segment id
                        result(n) = id;
                        
                        % increment the id
                        id = id+1;
                    end
                end
            end            
        end
    end
end
