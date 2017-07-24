clc;
clear;
path_population_image = 'F:\DHJ\课题二\registration\';
path_context_features = 'D:\data\trandata\savedata\context\';
path_haar_features = 'D:\data\trandata\savedata\haar\';
path_position = 'D:\data\trandata\savedata\position\';
path_label = 'D:\data\trandata\savedata\label\';
path_model = 'D:\data\trandata\savedata\model\';

n_sample =8000;
extra_options.num_tree =500;
extra_options.max_tree_depth = 15;
extra_options.num_tresholds = 100;
extra_options.num_weaklearners = 1000;
extra_options.min_leafnum = 8;
extra_options.min_infogain = 0;

name = dir(path_population_image);
name(1) = [];
name(1) = [];
len = length(name);
for k =1:len
    temp = name(i).name;
    path_image = [path_population_image,temp,'\'];
 for i= 1 : len
    
    image = load_image([path_image,'img',num2str(i),'.mat']);
    label_image = load_image([path_image,'img',num2str(i),'_pro.mat']);
   
    %计算随机采样点和标签
    if ~exist([path_label,num2str(i),'.mat'],'file')%&&~exit(path_position,'file')
    [ temp_pos , temp_label] = sample_pos(label_image,image,n_sample,'index');
    save_data(path_label,temp_label,i);
    save_data(path_position,temp_pos,i);
    end
    
    %计算haar feature 
    if ~exist([path_haar_features,num2str(i),'.mat'],'file')
    temp_haar_feature = cal_haar_features_3D( image , all_pos );
    save_data(path_haar_features,temp_haar_feature,i);
    end
    clear temp_haar_feature
    %计算context_feature
    if ~exist([path_context_features,num2str(i),'.mat'],'file')
    temp_context_feature = cal_context_features( image , all_pos );
    save_data(path_context_features,temp_context_feature,i);
    end
    clear temp_context_feature  temp_label temp_pos
end
disp(['训练模型-',num2str(k)])
model = class_auto_context(path_haar_features,path_context_features,path_label,path_position,n_iter,n_size_image,extra_options);
save([path_model,'pouplation_model_',num2str(k),'.mat'],'model');
disp(['模型训练结束-',num2str(k)])
end