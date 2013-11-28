function [ ret ] = maxInds(mat)
    [~, ret] = max(mat, [], 2);
end