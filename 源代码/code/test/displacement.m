%用于配准图像，利用重心
clear
clc
path_data ='L:\Data\pat1\';
path_save ='L:\课题一(Online updata 已经完成)\matachdata2\pat1\';
num = 10;

radius_ROI_x = 75;
radius_ROI_y = 75;
radius_ROI_z = 11;

sice = 20;

for i = 1:num
    
temp_path = strcat(path_data,'img',num2str(i),'.mhd');
image = read_mhd(temp_path) ;
temp_path = strcat(path_data,'img',num2str(i),'_pro.mhd');
model = read_mhd(temp_path) ;

[x,y,z] = cal_center(image,model);
temp_data = set_roi(image,radius_ROI_x,radius_ROI_y,radius_ROI_z,[x,y,z]);
figure,imshow(temp_data(:,:,sice),[])
temp_path = strcat(path_save,'img',num2str(i),'.mat');
save(temp_path,'temp_data');
clear temp_data

temp_data = set_roi(model,radius_ROI_x,radius_ROI_y,radius_ROI_z,[x,y,z]);
temp1 = temp_data(:,:,1);

if ~isempty(find(temp1 == 255))
    error('z设置有误')
end
temp1 = temp_data(:,:,size(temp_data,3));
if ~isempty(find(temp1 == 255))
    error('z设置有误')
end

%figure,imshow(temp_data(:,:,sice))
temp_path = strcat(path_save,'img',num2str(i),'_pro.mat');
save(temp_path,'temp_data');

% imshow(temp_image(:,:,silce),[])
% figure,imshow(temp_model(:,:,silce),[])
end