function [accuracy] = run_NaiveBayes( X_train, y_train, X_test, y_test )
    model = NaiveBayes.fit(X_train, y_train);
    res = model.predict(X_test);
    
    accuracy = getAccuracy(res, y_test);
    
    fprintf('Accuracy : %0.2f\n', accuracy);
end

