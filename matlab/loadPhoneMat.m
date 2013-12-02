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
    baxphone = [baxphone ; nbaxphone(2:end-1,:)];
    nbayphone = importdata(strcat(datafolder, '/body_acc_y_' , runname ,'.txt'));
    bayphone = [bayphone ; nbayphone(2:end-1,:)];
    nbazphone = importdata(strcat(datafolder, '/body_acc_z_' , runname ,'.txt'));
    bazphone = [bazphone ; nbazphone(2:end-1,:)];
    nbgxphone = importdata(strcat(datafolder, '/body_gyro_x_', runname ,'.txt'));
    bgxphone = [bgxphone ; nbgxphone(2:end-1,:)];
    nbgyphone = importdata(strcat(datafolder, '/body_gyro_y_', runname ,'.txt'));
    bgyphone = [bgyphone ; nbgyphone(2:end-1,:)];
    nbgzphone = importdata(strcat(datafolder, '/body_gyro_z_', runname ,'.txt'));
    bgzphone = [bgzphone ; nbgzphone(2:end-1,:)];
    ntaxphone = importdata(strcat(datafolder, '/total_acc_x_', runname ,'.txt'));
    taxphone = [taxphone ; ntaxphone(2:end-1,:)];
    ntayphone = importdata(strcat(datafolder, '/total_acc_y_', runname ,'.txt'));
    tayphone = [tayphone ; ntayphone(2:end-1,:)];
    ntazphone = importdata(strcat(datafolder, '/total_acc_z_', runname ,'.txt'));
    tazphone = [tazphone ; ntazphone(2:end-1,:)];
    Yphone = [Yphone ; ones(size(nbaxphone, 1)-2,1).*runlabel];
end
