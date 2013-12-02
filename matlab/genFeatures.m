function [features, mR, rR] = genFeatures(bax, bay, baz, bgx, bgy, bgz, tax, tay, taz, minRow, rangeRow)
% This function, when given a number of matricies representing the various
% Readings of our accelerometer over a block of time,
% Will generate a feature matrix
% Each row of the input represents a single block of time.
% Each row of the output represents a feature vector for that block in time

% Number of training examples
m = size(bax, 1);

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
    genThreeDimFeatures(bax, bay, baz, 1), ...
    genThreeDimFeatures(tgax, tgay, tgaz, 1), ...
    genThreeDimFeatures(jBax, jBay, jBaz, 1), ...
    genThreeDimFeatures(bgx, bgy, bgz, 1), ...
    genThreeDimFeatures(jBgx, jBgy, jBgz, 1), ...
    genSingleMatFeatures(mBa, 1), ...
    genSingleMatFeatures(mTga, 1), ...
    genSingleMatFeatures(mJBa, 1), ...
    genSingleMatFeatures(mBg, 1), ...
    genSingleMatFeatures(mJBg, 1), ...
    genThreeDimFeatures(fbax, fbay, fbaz), ...
    genThreeDimFeatures(fjBax, fjBay, fjBaz), ...
    genThreeDimFeatures(fbgx, fbgy, fbgz), ...
    genSingleMatFeatures(fmBa), ...
    genSingleMatFeatures(fmJBa), ...
    genSingleMatFeatures(fmBg), ...
    genSingleMatFeatures(fmJBg), ...
    angle(tBodyAccMean, gravityMean), ...
    angle(tBodyAccJerkMean, gravityMean), ...
    angle(tBodyGyroMean, gravityMean), ...
    angle(tBodyGyroJerkMean, gravityMean), ...
    angle([ ones(m, 1) zeros(m, 1) zeros(m, 1) ], gravityMean), ...
    angle([ ones(m, 1) zeros(m, 1) zeros(m, 1) ], gravityMean), ...
    angle([ ones(m, 1) zeros(m, 1) zeros(m, 1) ], gravityMean), ...
    ];
    
    isreal(features)
    
    if nargout == 1
        if nargin == 9
            fprintf('Normalizing\n');
            features = normalize(features);
        else
            fprintf('Normallizing using input\n');
            features = normalize(features,  minRow, rangeRow);
        end
    else
        if nargin == 9
            fprintf('Normalizing, computing rows\n');
            [features, mR, rR] = normalize(features);
        else
            fprintf('Normalizing, not recomputing rows\n')
            features = normalize(features,minRow, rangeRow);
            mR = minRow;
            rR = rangeRow;
        end
    end
end

% if time is 1, calculates time domain features, 
% else frequency domain features.
function [feat] = genThreeDimFeatures(matX, matY, matZ, time)
if nargin < 4
    time = 0;
end

feat = horzcat(...
   mean(matX,2), ...
   mean(matY,2), ...
   mean(matZ,2), ...
   std(matX,0,2),   ...
   std(matY,0,2),   ...
   std(matZ,0,2),   ...
   mad(matX')', ...
   mad(matY')', ...
   mad(matZ')', ...
   max(matX,[],2), ...
   max(matY,[],2), ...
   max(matZ,[],2), ...
   min(matX,[],2), ...
   min(matY,[],2), ...
   min(matZ,[],2), ...
   sma(matX, matY, matZ), ...
   energy(matX), ...
   energy(matY), ...
   energy(matZ), ...
   iqr(matX,2), ...
   iqr(matY,2), ...
   iqr(matZ,2), ...
   signalEntropy(matX),...
   signalEntropy(matY),...
   signalEntropy(matZ));

if time
   feat = horzcat(...
       feat, ...
       arCoefByRow(matX), ...
       arCoefByRow(matY), ...
       arCoefByRow(matZ), ...
       getCorrelationFeatures(matX, matY, matZ));
else
   feat = horzcat(...
       feat, ...
       maxInds(matX), ...
       maxInds(matY), ...
       maxInds(matZ), ...
       meanFreq(matX), ...
       meanFreq(matY), ...
       meanFreq(matZ), ...
       skewness(matX, [],2),...
       kurtosis(matX, [],2),...
       skewness(matY, [],2),...
       kurtosis(matY, [],2),...
       skewness(matZ, [],2),...
       kurtosis(matZ, [],2),...
       bandsEnergy(matX), ...
       bandsEnergy(matY), ...
       bandsEnergy(matZ) ...
   );
end
end

function [feat] = genSingleMatFeatures(mat, time)
% Generates a matrix of features that only require one matrix input
% if time is 1, calculates time domain features, 
% else frequency domain features.

if nargin < 4
    time = 0;
end

% Smoothing can help reduce overfitting
% Only used for freq-domain features
% if ~time
%     for i = 1:size(mat, 1)
%         mat(i, :) = smooth(mat(i, :), 18);
%     end
% end

feat = horzcat(...
        mean(mat,2), ...
        std(mat,0,2), ...
        mad(mat')', ...
        max(mat,[],2), ...
        min(mat,[],2), ...
        sma(mat), ...
        energy(mat), ...
        iqr(mat,2), ...
        signalEntropy(mat)...
   );

if time
    feat = [ feat arCoefByRow(mat) ];
else
    feat = horzcat( ...
        feat, ...
        maxInds(mat), ...
        meanFreq(mat), ...
        skewness(mat, [],2), ...
        kurtosis(mat, [],2) ...
    );
end

end
