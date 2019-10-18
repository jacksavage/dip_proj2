function result = merge_partial_segments(image, map, ui_fig)
    result = image;   
    
    if isempty(map)
        return;
    end
    
    g = graph(map(:,1), map(:,2));
    plot(g);
    groups = conncomp(g); 
    new_group_ids = unique(groups);
    
    progress = uiprogressdlg(ui_fig, 'Title','Merging partial segments');
    
    for new_group_id_i= 1:length(new_group_ids)
        progress.Value = new_group_id_i / length(new_group_ids);
        
        group_ids_to_replace = find(groups == new_group_id_i);
        new_group_id = new_group_ids(new_group_id_i);
        result(ismember(image, group_ids_to_replace)) = new_group_id;
    end
end
