%测试context feature
clear
image=read_mhd('D:\data\trandata\data\img12.mhd');
%image=set_roi(image,100,100,30);
model=read_mhd('D:\data\trandata\data\img12_pro.mhd');
%model=set_roi(model,100,100,30);
n_size=size(image);
all_pos = n_size(1)*n_size(2)*n_size(3);%获取图像的全点坐标
[ x_temp , y_temp , z_temp ] = ind2sub(size(image),all_pos);%索引转下标
all_pos = [ x_temp , y_temp , z_temp ];
[traindatapos,label] = sample_pos(model, image ,80000);
featurs = cal_context_features( image , traindatapos ) ;
