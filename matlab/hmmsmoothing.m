function [ newTestY ] = hmmsmoothing( Ytrain, YtrainLb, Ytest )
%HMMSMOOTHING Puts the output of our SVM through a HMM
%  
[~, EMIS_EST] = hmmestimate(YtrainLb, Ytrain);
TRANS_GUESS = eye(6)*.88 + ones(6,6)*.02;

Ytest0 = Ytest(1:(end-4));
Ytest1 = Ytest(2:(end-3));
Ytest2 = Ytest(3:(end-2));
Ytest3 = Ytest(4:(end-1));
Ytest4 = Ytest(5:(end));

YtestMat = [Ytest0, Ytest1, Ytest2, Ytest3, Ytest4];
YtestMat = reshape(YtestMat, size(Ytest0,1),5);

%hmmFunc = @(x) hmmGetVal(x, TRANS_GUESS, EMIS_EST);
%applyToGivenRow = @(func, matrix) @(row) func(matrix(row, :));
%applyToRows = @(func, matrix) arrayfun(applyToGivenRow(func, matrix), 1:size(matrix,1))';
%ret = applyToRows(hmmFunc, YtestMat);
%ret = cell2mat(ret);
%     ret = ret(:, 2:5);
C = num2cell(YtestMat,2);
ret = cellfun(@(x) hmmGetVal(x, TRANS_GUESS, EMIS_EST), C);
newTestY = [Ytest(1:4) ; ret];

end

function [ret] = hmmGetVal(seq, TRANS, EMIS)
   ret =  hmmviterbi(seq, TRANS, EMIS);
   ret = ret(end);
end