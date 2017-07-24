clear;
clc;
path_image =  'F:\DHJ\¿ÎÌâÈı\seg_data\pat20\';
image = load_image([path_image,'img1.mat']);
label_image = load_image([path_image,'img1_pro.mat']);
all_pos = get_allpos(image);
temp_haar_feature = random_harr( image , all_pos );