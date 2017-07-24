clear;
clc;
path='E:\STITP\源代码\';
path_image = [path,'seg_data\'];
path_result = [path,'result\'];
path_model = [path,'model\'];
% global extra_options_path
% 定义结构体extra_options_path用来存放路径
extra_options_path.path_context_features = [path,'tempdata\context\'];%上下文特征路径
extra_options_path.path_haar_features = [path,'tempdata\haar\'];%希尔特征路径
extra_options_path.path_position = [path,'tempdata\position\'];%position路径
extra_options_path.path_label = [path,'tempdata\label\'];%label路径
extra_options_path.path_tempdata = [path,'tempdata\tempdata\'];%tempdata路径
%创建文件夹
mkdir(path_result)%创建文件夹result
mkdir(path_model)%创建文件夹model
mkdir(extra_options_path.path_context_features)%创建结构体存放的路径对应的文件夹
mkdir(extra_options_path.path_haar_features)
mkdir(extra_options_path.path_position)
mkdir(extra_options_path.path_label)
mkdir(extra_options_path.path_tempdata)
% 将患者数据文件夹下的子目录（分别存放5个患者的数据）放在结构体name中
name = dir(path_image);
name(1) = [];
name(1) = [];
len = length(name);%len表示患者的数量
for i =1:len
    temp = name(i).name;
    extra_options_path.path_image = [path_image,temp,'\'];%保存每个患者图像的路径 
    
    mkdir([path_result,'result_',temp,'\'])%为每个患者创建单独的结果文件夹
    extra_options_path.path_result =[path_result,'result_',temp,'\'];%将该路径保存在结构体中
    
    mkdir([path_model,'model_',temp,'\'])%创建每个患者的模型文件夹
    extra_options_path.path_model = [path_model,'model_',temp,'\'];%保存模型路径
    disp(['开始训练',temp,'......'])
    trainmain(extra_options_path);
    disp(['结束训练',temp,'......'])
    
    rmdir(extra_options_path.path_context_features, 's')
    rmdir(extra_options_path.path_haar_features, 's')
    rmdir(extra_options_path.path_position, 's')
    rmdir(extra_options_path.path_label, 's')
    rmdir(extra_options_path.path_tempdata, 's')
    
    mkdir(extra_options_path.path_context_features)
    mkdir(extra_options_path.path_haar_features)
    mkdir(extra_options_path.path_position)
    mkdir(extra_options_path.path_label)
    mkdir(extra_options_path.path_tempdata)

 end