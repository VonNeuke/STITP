function [result,haar_feature,context_feature]=predict_auto_context(image,model)
%用于预测分割图
%image是待分割图像
%model是模型

%%
%初始化

n_iter = size(model,2);%模型的个数
n_size = size(image);%获取图像的尺寸
%获取图像的全点坐标
all_pos = 1: n_size(1)*n_size(2)*n_size(3);
all_pos = all_pos(:);
[ x_temp , y_temp , z_temp ] = ind2sub(size(image),all_pos);%索引转下标
all_pos = [ x_temp , y_temp , z_temp ];

%计算haar 特征
haar_feature = cal_haar_features_3D( image , all_pos  );
%计算first part of context
context_feature = cal_context_features( image, all_pos );
%初始化second part of context
temp_context = ones(size(context_feature))*0.5;

%%
% path_model = 'D:\data\trandata\savedata\model\model_important.mat';
% clear model
%%
%训练开始
for i = 1 : n_iter
%     load(path_model)
     temp_model = model(i);
%     clear model
    result = classRF_prob([temp_context,context_feature,haar_feature],temp_model);
%     result = classRF_prob([temp_context(1:round(n_size(1)*n_size(2)*n_size(3)/3),:),context_feature(1:round(n_size(1)*n_size(2)*n_size(3)/3),:),haar_feature(1:round(n_size(1)*n_size(2)*n_size(3)/3),:)],temp_model);
%     temp_result = classRF_prob([temp_context(round(n_size(1)*n_size(2)*n_size(3)/3)+1:round(n_size(1)*n_size(2)*n_size(3)*2/3),:),...
%                                 context_feature(round(n_size(1)*n_size(2)*n_size(3)/3)+1:round(n_size(1)*n_size(2)*n_size(3)*2/3),:),...
%                                 haar_feature(round(n_size(1)*n_size(2)*n_size(3)/3)+1:round(n_size(1)*n_size(2)*n_size(3)*2/3),:)],temp_model);
%     result = [result; temp_result];
%     clear  temp_result
%     
%     temp_result = classRF_prob([temp_context(round(n_size(1)*n_size(2)*n_size(3)*2/3)+1:end,:),...
%                                 context_feature(round(n_size(1)*n_size(2)*n_size(3)*2/3)+1:end,:),...
%                                 haar_feature(round(n_size(1)*n_size(2)*n_size(3)*2/3)+1:end,:)],temp_model);
%     result = [result; temp_result];
    clear  temp_result
        
    if i ~= n_iter
    temp_context = context_from_map(result,n_size,1,'0','all');
    clear result
    end
end
result = reshape(result,n_size);
end