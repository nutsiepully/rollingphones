function [ norm_mat ] = normalize( mat )
    norm_mat = bsxfun(@minus, mat, min(mat));              % 0 - max
    maxCol = max(norm_mat);
    maxCol(~maxCol) = 1;    %Replace all 0s with 1s (to prevent /0)
    norm_mat = bsxfun(@rdivide, norm_mat, maxCol);  % 0 - 1 scaling
    norm_mat = norm_mat .* 2 - 1;                          % -1 - 1 scaling
    %end
end
