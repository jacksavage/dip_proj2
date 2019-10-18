function colormap = color_segmented_image(segmented_image)
%color_segmented_image creates a colormap for a segmented image 

    % calc the segment sizes relative to the total image area
    segment_ids = 1:max(segmented_image(:));
    segment_pixel_counts = histc(segmented_image(:), segment_ids);
    segment_sizes = segment_pixel_counts / numel(segmented_image);
    num_segments = length(segment_sizes);
    
    % create a default color map that is all white
    colormap = ones(num_segments, 3);
    
    % sort the segments by size
    [~, sort_indices] = sort(segment_pixel_counts, 'descend');
    
    % replace colors in colormap for colored segments
    num_colored_segments = length(sort_indices);
    color_pallet = fliplr(parula(num_colored_segments));
    colormap(sort_indices, :) = color_pallet;
    
    % segment_id 0 always gets black
    black = [0 0 0];
    colormap = [black; colormap];
end

