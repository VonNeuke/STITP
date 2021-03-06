function [model] = class_auto_context(path_haar_featrues,path_context_features,path_label,path_pos,n_iter,n_size_image,extra_options)
%class_auto_context利用auto context方法进行模型训练
%path_haar_featrues,path_context_features,path_label,path_pos，分别是数据保存路径
%n_iter为迭代的次数
%n_size_image为图像尺寸
%%
%初始化参数
%parameters of randomfresot
num_tree = extra_options.num_tree;
max_tree_depth = extra_options.max_tree_depth;
num_tresholds = extra_options.num_tresholds;
num_weaklearners = extra_options.num_weaklearners;
min_leafnum = extra_options.min_leafnum;
min_infogain = extra_options.min_infogain;
path_second_context=extra_options.path_tempdata;
n_data_haar = length(dir(fullfile(path_haar_featrues,'*.mat')));
n_data_context = length(dir(fullfile(path_context_features,'*.mat')));
n_data_label = length(dir(fullfile(path_label,'*.mat')));
n_data_pos = length(dir(fullfile(path_pos,'*.mat')));

if n_data_context ~= n_data_haar || n_data_haar ~= n_data_label || n_data_label ~= n_data_pos
    error('文件夹内文件个数由问题')
else
    num_data = n_data_pos;
end

% path_second_context = 'D:\data\trandata\tempdata\';%数据临时存储文件夹
model = [];%初始化模型

%获取全部坐标
all_pos = 1:n_size_image(1)*n_size_image(2)*n_size_image(3);
all_pos = all_pos(:);
%获取特征
NumRow = 121;

%获取标签
temp_label = extract_label(path_label,num_data);

%%
%训练
for i = 1: n_iter
    %step1：训练模型
    %获取采样点对应位置的特征
    
    temp_haar = extract_feature(path_haar_featrues,path_pos,num_data);
    temp_first_context = extract_feature(path_context_features,path_pos,num_data);
 
    %检测错误
    if size(temp_label,1) ~= size(temp_first_context,1)&&size(temp_first_context,1) ~= size(temp_haar,1)
        error('抽取文件夹的特征和标签维数有问题')
    end
    %获取second part of context
    if i ==1
    Dim=[size(temp_first_context,1),NumRow];
    second_context_part = ones(Dim)*0.5;
    end
    disp('训练模型')
    temp_model = classRF_train([ second_context_part , temp_first_context,temp_haar ],temp_label,num_tree);
    clear second_context_part temp_first_context temp_haar
    disp('训练模型结束')
    %step2：获取全部haar 和 first part of context feasture 特征
   
    model = [model,temp_model];%更新模型
    clear temp_model
    %迭代到第n_iter次时没有意义
    if i == n_iter
        break;
    end
    second_context_part = [];
    %step3：进行概率图计算
    
    for j = 1:num_data
    temp_first_context = load_data(path_context_features,j);%载入first part of context features
    temp_haar = load_data(path_haar_featrues,j);%载入 haar features
    
        if i ==1
            dim=[size(temp_first_context,1),NumRow];
            temp_second_context = ones(dim)*0.5;
        else
            temp_second_context = load_data(path_second_context,j);
            temp_second_context = cal_context_features( temp_second_context , all_pos ,'index' );
        end
    
    map_prob = classRF_prob([ temp_second_context,temp_first_context,temp_haar],model(i));
    clear  temp_second_context temp_first_context temp_haar
    %step4 更新second context
    map_prob = reshape(map_prob,n_size_image);
    save_data(path_second_context,map_prob,j);
    %temp_second_context_part = context_from_map(map_prob,n_size_image,1,path_pos);
    temp_pos = load_data(path_pos,j);
    temp_second_context = cal_context_features( map_prob , temp_pos ,'index' );
    second_context_part = [second_context_part; temp_second_context];
    clear temp_second_context_part map_prob temp_pos
    %temp_second_contxt = context_from_map(map_prob,n_size_image,n_image,pos);
    end
    
end
end


