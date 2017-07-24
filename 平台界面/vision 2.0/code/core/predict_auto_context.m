function [result,haar_feature,context_feature]=predict_auto_context(image,model)
%����Ԥ��ָ�ͼ
%image�Ǵ��ָ�ͼ��
%model��ģ��

%%
%��ʼ��

n_iter = size(model,2);%ģ�͵ĸ���
n_size = size(image);%��ȡͼ��ĳߴ�
%��ȡͼ���ȫ������
all_pos = 1: n_size(1)*n_size(2)*n_size(3);
all_pos = all_pos(:);
[ x_temp , y_temp , z_temp ] = ind2sub(size(image),all_pos);%����ת�±�
all_pos = [ x_temp , y_temp , z_temp ];

%����haar ����
haar_feature = cal_haar_features_3D( image , all_pos  );
%����first part of context
context_feature = cal_context_features( image, all_pos );
%��ʼ��second part of context
temp_context = ones(size(context_feature))*0.5;

%%
% path_model = 'D:\data\trandata\savedata\model\model_important.mat';
% clear model
%%
%ѵ����ʼ
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