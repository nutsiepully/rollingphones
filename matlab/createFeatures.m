
%fprintf('Generating Train Features.\n');
%XgenTrain = genFeatures(baxtrain, baytrain, baztrain, bgxtrain, bgytrain, ...
%            bgztrain, taxtrain, taytrain, taztrain);
%
%fprintf('Generating Test Features.\n');
%XgenTest = genFeatures(baxtest, baytest, baztest, bgxtest, bgytest, ...
%           bgztest, taxtest, taytest, taztest);

fprintf('Generating Test/Train Features.\n');
%The minRow and rangeRow exist so that we can have a consistant
%normalization over all data we work with.
% If you want to test new data, add minRow, maxRow as additional arguments
% after you give the nine input matricies
[Xgen, minRow, rangeRow] = genFeatures([baxtest; baxtrain], [baytest; baytrain], ...
           [baztest; baztrain], ... 
           [bgxtest; bgxtrain], [bgytest; bgytrain], ...
           [bgztest; bgztrain], [taxtest; taxtrain], ... 
           [taytest; taytrain], [taztest; taztrain]);

teSz = size(baztest, 1);
trSz = size(baztrain, 1);
       
XgenTest = Xgen(1:teSz  , :);
XgenTrain = Xgen((teSz+1):(teSz+trSz), :);
       
save('genFeatures.mat', 'XgenTrain', 'XgenTest');