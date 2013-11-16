%loadMat;

XgenTrain = genFeatures(baxtrain, baytrain, baztrain, bgxtrain, bgytrain, ...
            bgztrain, taxtrain, taytrain, taztrain);
        
XgenTest = genFeatures(baxtest, baytest, baztest, bgxtest, bgytest, ...
            bgztest, taxtest, taytest, taztest);


        
SVMStruct = libsvmtrain(Ytrain, XgenTrain);
Group = libsvmpredict(Ytrain ,XgenTrain,SVMStruct);
Group2 = libsvmpredict(Ytest ,XgenTest,SVMStruct);


  
SVMStruct2 = libsvmtrain(Ytrain, Xtrain);
Group3 = libsvmpredict(Ytest ,Xtest,SVMStruct2);


Group(2)
Group2(2)
Group3(2)