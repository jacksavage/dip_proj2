function out = ridge_scan(in)
    dir = [0, in(2:end)-in(1:end-1)];
    out = zeros(1, length(in));
    
    for i = 1:length(dir)-1
        if dir(i) > 0 && dir(i+1) <= 0; out(i) = 1; end
        if dir(i) == 0 && dir(i+1) < 0; out(i) = 1; end
    end
end
