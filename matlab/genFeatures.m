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

%fBodyAcc-XYZ
%fft( [],2)
%fBodyAccJerk-XYZ
%fBodyGyro-XYZ
%fBodyAccMag
%fBodyAccJerkMag
%fBodyGyroMag
%fBodyGyroJerkMag

features = [genSingleMatFeatures(bax), ...
    genSingleMatFeatures(bay), ...
    genSingleMatFeatures(baz), ...
    genSingleMatFeatures(tgax), ...
    genSingleMatFeatures(tgay), ...
    genSingleMatFeatures(tgaz), ...
    genSingleMatFeatures(jBax), ...
    genSingleMatFeatures(jBay), ...
    genSingleMatFeatures(jBaz), ...
    genSingleMatFeatures(bgx), ...
    genSingleMatFeatures(bgy), ...
    genSingleMatFeatures(bgz), ...
    genSingleMatFeatures(jBgx), ...
    genSingleMatFeatures(jBgy), ...
    genSingleMatFeatures(jBgz), ...
    genSingleMatFeatures(mBa), ...
    genSingleMatFeatures(mTga), ...
    genSingleMatFeatures(mJBa), ...
    genSingleMatFeatures(mBg), ...
    genSingleMatFeatures(mJBg)];

%entropy(): Signal entropy
%arCoeff(): Autorregresion coefficients with Burg order equal to 4
%maxInds(): index of the frequency component with largest magnitude
%meanFreq(): Weighted average of the frequency components to obtain a mean frequency
%skewness(): skewness of the frequency domain signal 
%kurtosis(): kurtosis of the frequency domain signal 
%bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
%correlation(): correlation coefficient between two signals
   sma(bax, bay, baz);
   angle(bax, bay);
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
   iqr(mat,2));
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