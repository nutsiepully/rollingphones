
fprintf('Generating Train Features.\n');
XgenTrain = genFeatures(baxtrain, baytrain, baztrain, bgxtrain, bgytrain, ...
            bgztrain, taxtrain, taytrain, taztrain);

fprintf('Generating Test Features.\n');
XgenTest = genFeatures(baxtest, baytest, baztest, bgxtest, bgytest, ...
           bgztest, taxtest, taytest, taztest);

save('genFeatures.mat', 'XgenTrain', 'XgenTest');