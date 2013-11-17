function [features] = genFeatures(bax, bay, baz, bgx, bgy, bgz, tax, tay, taz)
% This function, when given a number of matricies representing the various
% Readings of our accelerometer over a block of time,
% Will generate a feature matrix
% Each row of the input represents a single block of time.
% Each row of the output represents a feature vector for that block in time



%tBodyAcc-XYZ        
bax; 
bay;
baz;

%tGravityAcc-XYZ     low pass filter?
%[b,a] = butter(3, .3, 'low');
%tgTax = filter(b, a, tax);
tgax = tax - bax;
tgay = tay - bay;
tgaz = taz - baz;

%tBodyAccJerk-XYZ
jBax = diff(bax,1,2);
jBay = diff(bay,1,2);
jBaz = diff(baz,1,2);

%tBodyGyro-XYZ       
bgx; 
bgy;
bgz;

%tBodyGyroJerk-XYZ
% Should we use gradient?
jBgx = diff(bgx,1,2);
jBgy = diff(bgy,1,2);
jBgz = diff(bgz,1,2);

%tBodyAccMag
mBa = mag(bax, bay, baz);

%tGravityAccMag
mTga = mag(tgax, tgay, tgaz);

%tBodyAccJerkMag
mJBa = mag(jBax, jBay, jBaz);

%tBodyGyroMag
mBg = mag(bgx, bgy, bgz);

%tBodyGyroJerkMag
mJBg =mag(jBgx, jBgy, jBgz);

%fBodyAcc-XYZbax; 
fbax = abs(fft(bax,[],2));
fbay = abs(fft(bay,[],2));
fbaz = abs(fft(baz,[],2));

%fBodyAccJerk-XYZ
fjBax = abs(fft(jBax,[],2));
fjBay = abs(fft(jBay,[],2));
fjBaz = abs(fft(jBaz,[],2));

%fBodyGyro-XYZ
fbgx = abs(fft(bgx,[],2)); 
fbgy = abs(fft(bgy,[],2));
fbgz = abs(fft(bgz,[],2));

%fBodyAccMag
fmBa = abs(fft(mBa,[],2));

%fBodyAccJerkMag
fmJBa = abs(fft(mJBa,[],2));

%fBodyGyroMag
fmBg = abs(fft(mBg,[],2));

%fBodyGyroJerkMag
fmJBg = abs(fft(mJBg,[],2));

tBodyAccMean = [ mean(bax, 2), mean(bay, 2), mean(baz, 2) ];
gravityMean = [ mean(tgax, 2), mean(tgay, 2), mean(tgaz, 2) ];
tBodyAccJerkMean = [ mean(jBax, 2), mean(jBay, 2), mean(jBaz, 2) ];
tBodyGyroMean = [ mean(bgx, 2), mean(bgy, 2), mean(bgz, 2) ];
tBodyGyroJerkMean = [ mean(jBgx, 2), mean(jBgy, 2), mean(jBgz, 2) ];

features = [
    genSingleMatFeatures(bax), ...
    genSingleMatFeatures(bay), ...
    genSingleMatFeatures(baz), ...
    getCorrelationFeatures(bax, bay, baz), ...
    genSingleMatFeatures(tgax), ...
    genSingleMatFeatures(tgay), ...
    genSingleMatFeatures(tgaz), ...
    getCorrelationFeatures(tgax, tgay, tgaz), ...
    genSingleMatFeatures(jBax), ...
    genSingleMatFeatures(jBay), ...
    genSingleMatFeatures(jBaz), ...
    getCorrelationFeatures(jBax, jBay, jBaz), ...
    genSingleMatFeatures(bgx), ...
    genSingleMatFeatures(bgy), ...
    genSingleMatFeatures(bgz), ...
    getCorrelationFeatures(bgx, bgy, bgz), ...
    genSingleMatFeatures(jBgx), ...
    genSingleMatFeatures(jBgy), ...
    genSingleMatFeatures(jBgz), ...
    getCorrelationFeatures(jBgx, jBgy, jBgz), ...
    genSingleMatFeatures(mBa), ...
    genSingleMatFeatures(mTga), ...
    genSingleMatFeatures(mJBa), ...
    genSingleMatFeatures(mBg), ...
    genSingleMatFeatures(mJBg), ...
    %{
    genSinglefMatFeatures(fbax), ...
    genSinglefMatFeatures(fbay), ...
    genSinglefMatFeatures(fbaz), ...
    genSinglefMatFeatures(fjBax), ...
    genSinglefMatFeatures(fjBay), ...
    genSinglefMatFeatures(fjBaz), ...
    genSinglefMatFeatures(fbgx), ...
    genSinglefMatFeatures(fbgy), ...
    genSinglefMatFeatures(fbgz), ...
    genSinglefMatFeatures(fmBa), ...
    genSinglefMatFeatures(fmJBa), ...
    genSinglefMatFeatures(fmBg), ...
    genSinglefMatFeatures(fmJBg)
    %}
    angle(tBodyAccMean, gravityMean), ...
    angle(tBodyAccJerkMean, gravityMean), ...
    angle(tBodyGyroMean, gravityMean), ...
    angle(tBodyGyroJerkMean, gravityMean)
    ];

    %maxInds(): index of the frequency component with largest magnitude
    % max(mat, [], 2) of fft
    %meanFreq(): Weighted average of the frequency components to obtain a mean frequency
    % mean(mat, [], 2) of fft   
    %bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
    % sma(bax, bay, baz);    
end

function [feat] = genSingleMatFeatures(mat)
%Generates a matrix of features that only require one matrix input
feat = horzcat(...
   mean(mat,2), ...
   std(mat,0,2),   ...
   mad(mat')', ...
   max(mat,[],2), ...
   min(mat,[],2), ...
   energy(mat), ...
   iqr(mat,2), ...
   signalEntropy(mat),...
   arCoefByRow(mat));
end

function [feat] = genSinglefMatFeatures(mat)
%Generates a matrix of features that only require one matrix input
% Smoothing helped test accuracy improve only from 64 to 74
for i = 1:size(mat, 1)
    mat(i, :) = smooth(mat(i, :), 18);
end

feat = horzcat(...
   mean(mat,2), ...
   std(mat,0,2),   ...
   mad(mat')', ...
   max(mat,[],2), ...
   min(mat,[],2), ...
   energy(mat), ...
   iqr(mat,2), ...
   signalEntropy(mat),...
   skewness(mat, [],2),...
   kurtosis(mat, [],2));
end

function [ret] = sma(x,y,z)
%Signal magnitude area
   ret = mean(abs(x)+abs(y)+abs(z), 2);
end

function [ret] = energy(a)
%Energy measure. Sum of the squares divided by the number of values. 
   ret = mean((a.*a),2);
end

function [ang] = angle(a,b)
% Angle between two vectors, should be done row by row
ang = acosd(dot(a,b,2)./(rowNorm(a) .* rowNorm(b)));
end

function [rnorm] = rowNorm(a)
% Takes the norm of each row 
   rnorm = sqrt(sum(abs(a).^2,2));
end

function [ret] = mag(x, y, z)
% Returns the matrix that gives the magnitude pointwise
   ret = sqrt(x.^2 + y.^2 + z.^2);
end

function [ret] = signalEntropy(x)
%Returns the entropy of a signal
   hisP = hist(x', 25)';
   numrows = size(hisP,1);
   hisP(~hisP) = 1;
   hisP = spdiags(1./sum(hisP,2),0,numrows,numrows)*hisP;
   ret = -sum(hisP.*log2(hisP) ,2);
end

function [ret] = arCoefByRow(x)
% Alternate implementation - Slightly slower. Abandoning.
% arFunc = @(x) arburg(x, 4);
% applyToGivenRow = @(func, matrix) @(row) func(matrix(row, :));
% applyToRows = @(func, matrix) arrayfun(applyToGivenRow(func, matrix), 1:size(matrix,1), 'UniformOutput', false)';
%     ret = applyToRows(arFunc, baxtrain);
%     ret = cell2mat(ret);
%     ret = ret(:, 2:5);
   C = num2cell(x,2);
   ret = cellfun(@(a) arburg(a,4),C, 'UniformOutput', false);
   ret = cell2mat(ret);
   ret = ret(:,2:5);
end