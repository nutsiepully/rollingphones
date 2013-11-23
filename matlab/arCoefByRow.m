function [ret] = arCoefByRow(x)
% Alternate implementation - Slightly slower. Abandoning.
% arFunc = @(x) arburg(x, 4);
% applyToGivenRow = @(func, matrix) @(row) func(matrix(row, :));
% applyToRows = @(func, matrix) arrayfun(applyToGivenRow(func, matrix), 1:size(matrix,1), 'UniformOutput', false)';
%     ret = applyToRows(arFunc, baxtrain);
%     ret = cell2mat(ret);
%     ret = ret(:, 2:5);
   C = num2cell(x,2);
   ret = cellfun(@(a) arburg(a,4),C, 'UniformOutput', false);
   ret = cell2mat(ret);
   ret = ret(:,2:5);
end
