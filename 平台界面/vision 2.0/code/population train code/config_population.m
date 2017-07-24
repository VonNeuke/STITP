clear;
clc;
path_population = 'F:\DHJ\�����\population\' ;
path_context_features = 'F:\data\trandata\savedata\context\';
path_haar_features = 'F:\data\trandata\savedata\haar\';
path_position = 'F:\data\trandata\savedata\position\';
path_label = 'F:\data\trandata\savedata\label\';
n_population = 10 ;
train_pat = 'pat22';
name = dir(path_population);
name(1) = [];
name(1) = [];
for k = 1 : length(name)
    if strcmp(name(k).name,train_pat)
       name(k) = [];
       break;
    end
    %if k == length(name)
       %error('û�����ɾ���Ķ���')
   % end
end
if n_population > length(name)
    error('���õ�population images ����ʵ��')
end
k = 1;
for i = 1 : n_population 
    temp_path = [path_population,name(i).name,'\'];
    for j = 1 : 2
        
        temp = [temp_path,'context',num2str(j),'.mat'];
%         copyfile(temp,[path_context_features,num2str(k),'.mat'])
        disp([temp,'����ֵΪ',path_context_features,num2str(k),'.mat'])
        
        temp = [temp_path,'haar',num2str(j),'.mat'];
%         copyfile(temp,[path_haar_features,num2str(k),'.mat'])
        disp([temp,'����ֵΪ',path_haar_features,num2str(k),'.mat'])
        
        temp = [temp_path,'label',num2str(j),'.mat'];
%         copyfile(temp,[path_label,num2str(k),'.mat'])
        disp([temp,'����ֵΪ',path_label,num2str(k),'.mat'])
        
        temp = [temp_path,'pos',num2str(j),'.mat'];
%         copyfile(temp,[path_position,num2str(k),'.mat'])
        disp([temp,'����ֵΪ',path_position,num2str(k),'.mat'])
        k = k + 1;
    end
end