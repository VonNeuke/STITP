function trainmain(extra_options_path)
%%
%----------------------------------------Init-------------------------------------------%
% global extra_options_path
n_sample =1000;%number of sample
extra_options.num_tree = 500;
n_iter = 3;
segsize=[64 64];

if isfield(extra_options_path,'path_image')
    path_image = extra_options_path.path_image;% 更改图像路径时记得注意29行，和33行是否和图像路径匹配
end
if isfield(extra_options_path,'path_context_features')
    path_context_features = extra_options_path.path_context_features;
end
if isfield(extra_options_path,'path_haar_features')
    path_haar_features = extra_options_path.path_haar_features;
end
if isfield(extra_options_path,'path_position')
    path_position = extra_options_path.path_position;
end
if isfield(extra_options_path,'path_label')
    path_label = extra_options_path.path_label;
end
if isfield(extra_options_path,'path_model')
    path_model = extra_options_path.path_model;
end
if isfield(extra_options_path,'path_result')
    path_result = extra_options_path.path_result;
end
if isfield(extra_options_path,'path_tempdata')
    extra_options.path_tempdata = extra_options_path.path_tempdata;
end
%parameters of randomfresot
n_traindays = 6;%number of treatment days
extra_options.max_tree_depth = 15;
extra_options.num_tresholds = 100;
extra_options.num_weaklearners = 1000;
extra_options.min_leafnum = 8;
extra_options.min_infogain = 0;


n_inti = 3;%number of image will be load before treament



%获取图像的全部坐标

disp('计算初始特征，开始...')
for i= 1:n_inti
    
    image = load_image([path_image,'img',num2str(i),'.mat']);
    label_image = load_image([path_image,'img',num2str(i),'_pro.mat']);
%     label_image.bla = load_image([path_image,'img',num2str(i),'_bla.mat']);
    
    
     image  = imresize(image , segsize);
	 label_image  = imresize(label_image , segsize);
%     label_image.pro = imresize(label_image.pro, [64 64]);
%     label_image.bla  = imresize(label_image.bla , [64 64]);
%     
    [all_pos,n_size_image] = get_allpos(image);
    
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
%         tic
    temp_context_feature = cal_context_features( image , all_pos );
%     toc
    save_data(path_context_features,temp_context_feature,i);
    end
    clear temp_context_feature  temp_label temp_pos
end

disp('计算初始特征，结束...')
for i = (n_inti+1):n_traindays+n_inti
     if i== n_traindays+n_inti
        break;
     end
    disp(['Day',num2str(i-n_inti),' training model,beginning...'])

    if~exist([path_model,'model_Day',num2str(i-n_inti),'.mat'],'file')
        model = class_auto_context(path_haar_features,path_context_features,path_label,path_position,n_iter,n_size_image,extra_options);
        save([path_model,'model_Day',num2str(i-n_inti),'.mat'],'model');
    else
        load([path_model,'model_Day',num2str(i-n_inti),'.mat'],'model');
    end
    disp(['Day',num2str(i-n_inti),' training model,over...'])
    clear image label_image temp_feature temp_label
    
    
    disp('beginning treament...');
    disp(['Day',num2str(i-n_inti),' prostate segmentation ,beginning...'])
      image = load_image([path_image,'img',num2str(i),'.mat']);%load image
      image  = imresize(image , segsize);
       
    if~exist([path_result,'result_Day',num2str(i-n_inti),'_pro.mat'],'file')&&~exist([path_result,'result_Day',num2str(i-n_inti),'_bla.mat'],'file')
        %prepare for segmentation
       
        %segmentation and predict 
        disp('beginning...')
        
            
            [result, temp_haar_feature, temp_context_feature] = predict_auto_context(image,model);
            save_data(path_haar_features,temp_haar_feature,i);
            save_data(path_context_features,temp_context_feature,i);
            clear temp_haar_feature temp_context_feature 
            
%             temp_result = result.bla;
%             save([path_result,'result_Day',num2str(i-n_inti),'_bla.mat'],'temp_result');
%             temp_result = level_set_3D(temp_result,100);
%             save([path_result,'result_Day_levset_',num2str(i-n_inti),'_bla.mat'],'temp_result');
            
            temp_result = result;
            save([path_result,'result_Day',num2str(i-n_inti),'_pro.mat'],'temp_result');
            %save result of segmentation
            temp_result = level_set_3D(temp_result,100);
            save([path_result,'result_Day_levset_',num2str(i-n_inti),'_pro.mat'],'temp_result');

            
        clear model temp_result result
    end
    
    disp('update result of segmentation...')
    label_image = load_image([path_image,'img',num2str(i),'_pro','.mat']);%load model 
	label_image  = imresize(label_image , segsize);
%     label_image.bla = load_image([path_image,'img',num2str(i),'_bla','.mat']);
    
%     label_image.pro  = imresize(label_image.pro , [64 64]);
%     label_image.bla  = imresize(label_image.bla , [64 64]);
    %提取采样点和标签
    [temp_pos,temp_label] = sample_pos(label_image,image,n_sample,'index');
 
    %save features and labels
    save_data(path_position,temp_pos,i);
    save_data(path_label,temp_label,i);
    %update features and labels
    clear label_image temp_pos temp_label
end
end