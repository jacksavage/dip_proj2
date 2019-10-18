function [r,c] = lin2grid(h,i)
    r = mod(i+1, h) + 1;
    c = floor((i-1) / h) + 1;
end

