function [ norm_mat ] = normalize( mat )
    norm_mat = bsxfun(@minus, mat, min(mat));              % 0 - max
    norm_mat = bsxfun(@rdivide, norm_mat, max(norm_mat));  % 0 - 1 scaling
    norm_mat = norm_mat .* 2 - 1;                          % -1 - 1 scaling
end
