clear
clc
%%
%----------------------------------------Init-------------------------------------------%
n_sample =8000;%number of sample
n_traindays = 8;%number of treatment days
path_image = 'D:\data\patdata\pat22\';
path_context_features = 'D:\data\trandata\savedata\context\';
path_haar_features = 'D:\data\trandata\savedata\haar\';
path_position = 'D:\data\trandata\savedata\position\';
path_label = 'D:\data\trandata\savedata\label\';
path_result = 'D:\data\trandata\savedata\result\';
path_model = 'D:\data\trandata\savedata\model\';

n_polution_data = length(dir(fullfile(path_haar_features,'*.mat')));
%parameters of randomfresot
extra_options.num_tree =5;
extra_options.max_tree_depth = 15;
extra_options.num_tresholds = 100;
extra_options.num_weaklearners = 1000;
extra_options.min_leafnum = 8;
extra_options.min_infogain = 0;

%set range of ROI parameters
radius_ROI_x = 80;
radius_ROI_y = 80;
radius_ROI_z = 25;

n_inti = 3;%number of image will be load before treament
n_iter = 3;
image = load_image([path_image,'img1.mat']);
n_size_image = size(image);
clear image
%%
%删除段

% %load image 
% image = load_image('D:\data\trandata\changpat\img1.mat');
% %load model
% label_image = load_image('D:\data\trandata\changpat\img1_pro.mat');
% 
% 
% %获取图像的全部坐标
% all_pos = get_allpos(image);
% 
% %compute random of sample point
% if ~exist([path_position,'1.mat'],'file')&&~exist([path_label,'1.mat'],'file')
% [temp_pos,temp_label] = sample_pos(label_image,image,n_sample,'index');
% 
% %存储文件，节省内存
% save_data(path_position,temp_pos,1);
% save_data(path_label,temp_label,1);
% clear temp_pos temp_label
% end 
% %compute haar features
% disp('计算初始特征，开始...')
% if ~exist([path_context_features,'1.mat'],'file')
% temp_context_feature = cal_context_features( image , all_pos );
% save_data(path_context_features,temp_context_feature,1);
% clear temp_context_feature
% end
% 
% if ~exist([path_haar_features,'1.mat'],'file')
% temp_haar_feature = cal_haar_features_3D( image , all_pos );
% save_data(path_haar_features,temp_haar_feature,1);
% clear temp_haar_feature
% end
% 
% clear image label_image 
% 
% for i=2:n_inti
%     
%     image = load_image([path_image,'img',num2str(i),'.mat']);
%     label_image = load_image([path_image,'img',num2str(i),'_pro.mat']);
%    
%     %计算随机采样点和标签
%     if ~exist([path_label,num2str(i),'.mat'],'file')%&&~exit(path_position,'file')
%     [ temp_pos , temp_label] = sample_pos(label_image,image,n_sample,'index');
%     save_data(path_label,temp_label,i);
%     save_data(path_position,temp_pos,i);
%     end
%     
%     %计算haar feature 
%     if ~exist([path_haar_features,num2str(i),'.mat'],'file')
%     temp_haar_feature = cal_haar_features_3D( image , all_pos );
%     save_data(path_haar_features,temp_haar_feature,i);
%     end
%     clear temp_haar_feature
%     %计算context_feature
%     if ~exist([path_context_features,num2str(i),'.mat'],'file')
%     temp_context_feature = cal_context_features( image , all_pos );
%     save_data(path_context_features,temp_context_feature,i);
%     end
%     clear temp_context_feature  temp_label temp_pos
% end
% disp('计算初始特征，结束...')
% disp('开始训练模型...')
% model = class_auto_context(path_haar_features,path_context_features,path_label,path_position,n_iter,n_size_image,extra_options);
% disp('模型训练结束...')
% clear image label_image temp_feature temp_label

%%
%--------------------------------Training  Process------------------------------------------------%
for i = 1:n_traindays
    if i ==1
        disp(['开始训练第',num2str(i),'天模型...'])
        if~exist([path_model,'model_Day',num2str(i),'.mat'],'file')
           model = class_auto_context(path_haar_features,path_context_features,path_label,path_position,n_iter,n_size_image,extra_options);
           save([path_model,'model_Day',num2str(i),'.mat'],'model');
        else
            load([path_model,'model_Day',num2str(i),'.mat'],'model')
        end
        disp(['第',int2str(i),'天模型训练结束...'])
    end
disp('beginning treament...');
disp(['Day',num2str(i),' prostate segmentation ,beginning...'])
    if~exist([path_result,'result_Day',num2str(i),'.mat'],'file')
        %prepare for segmentation
        image = load_image([path_image,'img',num2str(i),'.mat']);%load image
        %segmentation and predict 
        disp('beginning...')
        [temp_result, temp_haar_feature, temp_context_feature] = predict_auto_context(image,model);
        save_data(path_haar_features,temp_haar_feature,i+n_polution_data);
        save_data(path_context_features,temp_context_feature,i+n_polution_data);
        clear temp_haar_feature temp_context_feature image
        %save result of segmentation
        temp_result = level_set_3D(temp_result,100);
        save([path_result,'result_Day',num2str(i),'.mat'],'temp_result');
        clear model
    end
    disp('end of predict...')
    disp(['Day',num2str(i),' end of treament...']);
    if i== n_traindays
        break;
    end
disp('update result of segmentation...')
temp_path = strcat(path_image,'img',num2str(i),'_pro','.mat');
label_image = load_image(temp_path);%load model 
%提取采样点和标签
[temp_pos,temp_label] = sample_pos(label_image,image,n_sample,'index');
%save features and labels
save_data(path_position,temp_pos,i+n_polution_data);
save_data(path_label,temp_label,i+n_polution_data);
%update features and labels
clear label_image temp_pos temp_label
%training model 
disp(['Day',num2str(i+1),' training model,beginning...'])

if~exist([path_result,'model_Day',num2str(i+1),'.mat'],'file')
    model = class_auto_context(path_haar_features,path_context_features,path_label,path_position,n_iter,n_size_image,extra_options);
    disp(['Day',num2str(i+1),' training model,over...'])
    save([path_model,'model_Day',num2str(i+1),'.mat'],'model');
else
    load([path_model,'model_Day',num2str(i+1),'.mat'],'model')
end
end