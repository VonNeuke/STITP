%显示图片，获取查看真实值和分割值的比较
clear
clc
sice = 15;
image = load_image('D:\data\trandata\changedata\img4.mat');
% model = read_mhd('D:\data\trandata\data\img11_pro.mhd');
model = load_image('D:\data\trandata\changedata\img4_pro.mat');
load('D:\data\trandata\savedata\result\result_Day1.mat');
% model = set_roi(model,40,40,25);
% load('D:\data\trandata\savedata\result\result_Day8.mat')
T = max(max(max(temp_result)))*0.99;
temp_result(temp_result>=0.75)=1;
temp_result(temp_result<0.75)=0;
imshow(image(:,:,sice),[])
figure,imshow(model(:,:,sice),[])
figure,imshow(temp_result(:,:,sice),[])
% figure,imshow(temp_result(:,:,sice),[])
