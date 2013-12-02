
function verifyFeatures( X_actual, X_generated )
    diff = abs(X_actual - X_generated);
    sumErrors = sum(diff);
    meanErrors = mean(diff);
    stdErrors = std(diff);
end
