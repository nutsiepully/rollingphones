testfolder = '../datasets/UCI HAR Dataset/test/';
trainfolder = '../datasets/UCI HAR Dataset/train/';

Xtest = importdata(strcat(testfolder, 'X_test.txt'));
Ytest = importdata(strcat(testfolder, 'y_test.txt'));

baxtest = importdata(strcat(testfolder, 'Inertial Signals/body_acc_x_test.txt'));
baytest = importdata(strcat(testfolder, 'Inertial Signals/body_acc_y_test.txt'));
baztest = importdata(strcat(testfolder, 'Inertial Signals/body_acc_z_test.txt'));
bgxtest = importdata(strcat(testfolder, 'Inertial Signals/body_gyro_x_test.txt'));
bgytest = importdata(strcat(testfolder, 'Inertial Signals/body_gyro_y_test.txt'));
bgztest = importdata(strcat(testfolder, 'Inertial Signals/body_gyro_z_test.txt'));
taxtest = importdata(strcat(testfolder, 'Inertial Signals/total_acc_x_test.txt'));
taytest = importdata(strcat(testfolder, 'Inertial Signals/total_acc_y_test.txt'));
taztest = importdata(strcat(testfolder, 'Inertial Signals/total_acc_z_test.txt'));

Xtrain = importdata(strcat(trainfolder, 'X_train.txt'));
Ytrain = importdata(strcat(trainfolder, 'y_train.txt'));

baxtrain = importdata(strcat(trainfolder, 'Inertial Signals/body_acc_x_train.txt'));
baytrain = importdata(strcat(trainfolder, 'Inertial Signals/body_acc_y_train.txt'));
baztrain = importdata(strcat(trainfolder, 'Inertial Signals/body_acc_z_train.txt'));
bgxtrain = importdata(strcat(trainfolder, 'Inertial Signals/body_gyro_x_train.txt'));
bgytrain = importdata(strcat(trainfolder, 'Inertial Signals/body_gyro_y_train.txt'));
bgztrain = importdata(strcat(trainfolder, 'Inertial Signals/body_gyro_z_train.txt'));
taxtrain = importdata(strcat(trainfolder, 'Inertial Signals/total_acc_x_train.txt'));
taytrain = importdata(strcat(trainfolder, 'Inertial Signals/total_acc_y_train.txt'));
taztrain = importdata(strcat(trainfolder, 'Inertial Signals/total_acc_z_train.txt'));