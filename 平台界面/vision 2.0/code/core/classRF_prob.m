function [prob]=classRF_prob(X,model)
%classRF_prob用于测试每个点是正例的概率
%X为预测值
%model为训练的模型
%prob为预测每点的概率值
%extra_options.predict_all = 1;%getting prediction per tree, votes etc for test set
if model.ntree ~= 0
   n_ntree = model.ntree;
end

[a, votes, b] = classRF_predict( X , model );
clear a b

if size(votes,1) > size(votes,2)
prob = votes(:,2)/n_ntree;%计算每个点是正例的概率值
else
    error('votes 尺寸大小出现问题')    
end
end