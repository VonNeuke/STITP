function [prob]=classRF_prob(X,model)
%classRF_prob���ڲ���ÿ�����������ĸ���
%XΪԤ��ֵ
%modelΪѵ����ģ��
%probΪԤ��ÿ��ĸ���ֵ
%extra_options.predict_all = 1;%getting prediction per tree, votes etc for test set
if model.ntree ~= 0
   n_ntree = model.ntree;
end

[a, votes, b] = classRF_predict( X , model );
clear a b

if size(votes,1) > size(votes,2)
prob = votes(:,2)/n_ntree;%����ÿ�����������ĸ���ֵ
else
    error('votes �ߴ��С��������')    
end
end