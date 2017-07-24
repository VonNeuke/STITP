function [ image_roi ]= set_roi( image , radius_ROI_x , radius_ROI_y , radius_ROI_z,displace )
%imageΪҪ��������ROI�����ͼ��
%radius_ROI_x��radius_ROI_y��radius_ROI_zΪROI������Χ����
%n_size = size(image);
if exist('displace','var')
center_x = displace(1) ;%��ȡͼ�����ĵ�
center_y = displace(2) ;
center_z = displace(3) ;
else
    error('û������ƫ�Ƶ�')
end


%�޶���Χ����ֹROI�����ܳ�ͼ��Χ
if radius_ROI_x >= center_x || radius_ROI_y >= center_y || radius_ROI_z >= center_z
    error('����ROI����Χ����')
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