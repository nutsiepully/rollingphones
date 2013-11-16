%loadMat;

XgenTrain = genFeatures(baxtrain, baytrain, baztrain, bgxtrain, bgytrain, ...
            bgztrain, taxtrain, taytrain, taztrain);
        
XgenTest = genFeatures(baxtest, baytest, baztest, bgxtest, bgytest, ...
            bgztest, taxtest, taytest, taztest);


        
SVMStruct = svmtrain(Ytrain, XgenTrain);
Group = svmpredict(Ytrain ,XgenTrain,SVMStruct);
Group2 = svmpredict(Ytest ,XgenTest,SVMStruct);


  
SVMStruct2 = svmtrain(Ytrain, Xtrain);
Group3 = svmpredict(Ytest ,Xtest,SVMStruct2);


Group(2)
Group2(2)
Group3(2)