function [ image_roi ]= set_roi( image , radius_ROI_x , radius_ROI_y , radius_ROI_z,displace )
%image为要进行设置ROI区域的图像
%radius_ROI_x，radius_ROI_y，radius_ROI_z为ROI的区域范围设置
%n_size = size(image);
if exist('displace','var')
center_x = displace(1) ;%获取图像中心点
center_y = displace(2) ;
center_z = displace(3) ;
else
    error('没有设置偏移点')
end


%限定范围，防止ROI区域跑出图像范围
if radius_ROI_x >= center_x || radius_ROI_y >= center_y || radius_ROI_z >= center_z
    error('设置ROI区域范围过大')
else
    x = center_x - radius_ROI_x : center_x + radius_ROI_x;
    y = center_y - radius_ROI_y : center_y + radius_ROI_y;
    z = center_z - radius_ROI_z : center_z + radius_ROI_z;
    image_roi = zeros(size(x,2),size(y,2),size(z,2));
    for i = 1 : size(z,2)
     image_roi(:,:,i) = image(x,y,z(i));
    end
end
%image_roi = imresize(image_roi,[size(image_roi,1)/2,size(image_roi,2)/2]);
end