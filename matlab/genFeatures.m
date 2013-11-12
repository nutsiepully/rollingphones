function [features] = genFeatures(bax, bay, baz, bgx, bgy, bgz, tax, tay, taz)

%tBodyAcc-XYZ        bax bay baz
%tGravityAcc-XYZ     low pass filter?
%tBodyAccJerk-XYZ
%tBodyGyro-XYZ       bgx bgy bgz
%tBodyGyroJerk-XYZ
%tBodyAccMag
%tGravityAccMag
%tBodyAccJerkMag
%tBodyGyroMag
%tBodyGyroJerkMag
%fBodyAcc-XYZ
%fBodyAccJerk-XYZ
%fBodyGyro-XYZ
%fBodyAccMag
%fBodyAccJerkMag
%fBodyGyroMag
%fBodyGyroJerkMag

features = horzcat(...
   mean(bax,2), ...
   std(bax,0,2),   ...
   mad(bax')', ...
   max(bax,[],2), ...
   min(bax,[],2), ...
   sma(bax, bay, baz), ...
   energy(bax), ...
   iqr(bax,2));
%entropy(): Signal entropy
%arCoeff(): Autorregresion coefficients with Burg order equal to 4
%maxInds(): index of the frequency component with largest magnitude
%meanFreq(): Weighted average of the frequency components to obtain a mean frequency
%skewness(): skewness of the frequency domain signal 
%kurtosis(): kurtosis of the frequency domain signal 
%bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.

%correlation(): correlation coefficient between two signals
angle(bax, bay);
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
ang = acosd(dot(a,b)/(norm(a)*norm(b)));
end