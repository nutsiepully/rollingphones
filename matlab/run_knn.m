function run_knn( X_train, y_train, X_test, y_test, k, dist )
    if nargin < 5
        k = 10;
    end
    if nargin < 6
        dist = 'euclidean';
    end

    res = knnclassify(X_test, X_train, y_train, k, dist);
    accuracy = getAccuracy(res, y_test);
    
    fprintf('Accuracy : %0.2f\n', accuracy);
end
