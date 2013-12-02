function [norm_mat, mR, rR] = normalize( mat, minRow, rangeRow )
    if nargin <2
         minRow = min(mat);
         rangeRow = max(mat) - min(mat);
    end
    norm_mat = bsxfun(@minus, mat, minRow);              % 0 - max
    rangeRow(~rangeRow) = 1;    %Replace all 0s with 1s (to prevent /0)
    norm_mat = bsxfun(@rdivide, norm_mat, rangeRow);  % 0 - 1 scaling
    norm_mat = norm_mat .* 2 - 1; % -1 - 1 scaling
    if nargout > 1
        mR = minRow;
        rR = rangeRow;
    end
end
