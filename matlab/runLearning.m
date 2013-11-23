%loadMat;

%fprintf('Generating Train Features.');
%XgenTrain = genFeatures(baxtrain, baytrain, baztrain, bgxtrain, bgytrain, ...
%            bgztrain, taxtrain, taytrain, taztrain);
% XgenTrain = genFeatures(baxtrain(1:50, :), baytrain(1:50, :), baztrain(1:50, :), bgxtrain(1:50, :), bgytrain(1:50, :), ...
%             bgztrain(1:50, :), taxtrain(1:50, :), taytrain(1:50, :), taztrain(1:50, :));

%fprintf('Generating Test Features.');
%XgenTest = genFeatures(baxtest, baytest, baztest, bgxtest, bgytest, ...
%           bgztest, taxtest, taytest, taztest);
        

sSize = size(XgenTrain,1)/10;   
%{
for i = 1:10 
    sSrt = (i-1)*sSize + 1;
    sEnd = i*sSize;
    trainSub = XgenTrain( [ 1:sSrt-1, sEnd+1:end] , :);
    trainSubY = Y( [ 1:sSrt-1, sEnd+1:end]);
    testSub = data(sSrt:sEnd,:);
    testSubY = Y(sSrt:sEnd);
end
%}

fprintf('Training on Generated Features.');        
SVMStruct = svmtrain(Ytrain, XgenTrain);
fprintf('Testing on Generated Features.');
Group = svmpredict(Ytrain, XgenTrain, SVMStruct);
Group2 = svmpredict(Ytest, XgenTest, SVMStruct);

fprintf('Training on Given Features.');
SVMStruct2 = svmtrain(Ytrain, Xtrain);
fprintf('Testing on Given Features.');
Group3 = svmpredict(Ytest ,Xtest,SVMStruct2);

Group(2)
Group2(2)
Group3(2)
