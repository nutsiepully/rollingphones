%loadMat;

XgenTrain = genFeatures(baxtrain, baytrain, baztrain, bgxtrain, bgytrain, ...
            bgztrain, taxtrain, taytrain, taztrain);
        
XgenTest = genFeatures(baxtest, baytest, baztest, bgxtest, bgytest, ...
            bgztest, taxtest, taytest, taztest);


        
SVMStruct = libsvmtrain(Ytrain, XgenTrain);
Group = libsvmpredict(Ytest ,XgenTest,SVMStruct);


  
SVMStruct2 = libsvmtrain(Ytrain, Xtrain);
Group2 = libsvmpredict(Ytest ,Xtest,SVMStruct2);
