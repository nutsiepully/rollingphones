datafolder = '../datasets/phone_data';

filenames = strsplit(perl('files.pl', datafolder));
filenames(end) = [];
filenames = reshape(filenames, 2, [])';

baxphone = [];
bayphone = [];
bazphone = [];
bgxphone = [];
bgyphone = [];
bgzphone = [];
taxphone = [];
tayphone = [];
tazphone = [];
Yphone = [];

for i = 1:size(filenames, 1)
    runname = filenames{i, 1};
    runlabel = str2num(filenames{i, 2});
    nbaxphone = importdata(strcat(datafolder, '/body_acc_x_' , runname ,'.txt'));
    baxphone = [baxphone ; nbaxphone];
    bayphone = [bayphone ; importdata(strcat(datafolder, '/body_acc_y_' , runname ,'.txt'))];
    bazphone = [bazphone ; importdata(strcat(datafolder, '/body_acc_z_' , runname ,'.txt'))];
    bgxphone = [bgxphone ; importdata(strcat(datafolder, '/body_gyro_x_', runname ,'.txt'))];
    bgyphone = [bgyphone ; importdata(strcat(datafolder, '/body_gyro_y_', runname ,'.txt'))];
    bgzphone = [bgzphone ; importdata(strcat(datafolder, '/body_gyro_z_', runname ,'.txt'))];
    taxphone = [taxphone ; importdata(strcat(datafolder, '/total_acc_x_', runname ,'.txt'))];
    tayphone = [tayphone ; importdata(strcat(datafolder, '/total_acc_y_', runname ,'.txt'))];
    tazphone = [tazphone ; importdata(strcat(datafolder, '/total_acc_z_', runname ,'.txt'))];
    Yphone = [Yphone ; ones(size(nbaxphone, 1),1).*runlabel];
end