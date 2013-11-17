function [ corrs ] = getCorrelationFeatures(mat_x, mat_y, mat_z)
    m = size(mat_x, 1);
    corrs = zeros(m, 3);
    for i = 1:m
        corrs(i, :) = [ 
            corr_coeff(mat_x(i, :), mat_y(i, :))
            corr_coeff(mat_x(i, :), mat_z(i, :))
            corr_coeff(mat_x(i, :), mat_y(i, :))
        ];
    end
end

function [ ret ] = corr_coeff(vec1, vec2)
    ret = corrcoef(vec1, vec2);
    ret = ret(1, 2);
end
