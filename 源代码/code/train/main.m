clear;
clc;
path='E:\STITP\Դ����\';
path_image = [path,'seg_data\'];
path_result = [path,'result\'];
path_model = [path,'model\'];
% global extra_options_path
% ����ṹ��extra_options_path�������·��
extra_options_path.path_context_features = [path,'tempdata\context\'];%����������·��
extra_options_path.path_haar_features = [path,'tempdata\haar\'];%ϣ������·��
extra_options_path.path_position = [path,'tempdata\position\'];%position·��
extra_options_path.path_label = [path,'tempdata\label\'];%label·��
extra_options_path.path_tempdata = [path,'tempdata\tempdata\'];%tempdata·��
%�����ļ���
mkdir(path_result)%�����ļ���result
mkdir(path_model)%�����ļ���model
mkdir(extra_options_path.path_context_features)%�����ṹ���ŵ�·����Ӧ���ļ���
mkdir(extra_options_path.path_haar_features)
mkdir(extra_options_path.path_position)
mkdir(extra_options_path.path_label)
mkdir(extra_options_path.path_tempdata)
% �����������ļ����µ���Ŀ¼���ֱ���5�����ߵ����ݣ����ڽṹ��name��
name = dir(path_image);
name(1) = [];
name(1) = [];
len = length(name);%len��ʾ���ߵ�����
for i =1:len
    temp = name(i).name;
    extra_options_path.path_image = [path_image,temp,'\'];%����ÿ������ͼ���·�� 
    
    mkdir([path_result,'result_',temp,'\'])%Ϊÿ�����ߴ��������Ľ���ļ���
    extra_options_path.path_result =[path_result,'result_',temp,'\'];%����·�������ڽṹ����
    
    mkdir([path_model,'model_',temp,'\'])%����ÿ�����ߵ�ģ���ļ���
    extra_options_path.path_model = [path_model,'model_',temp,'\'];%����ģ��·��
    disp(['��ʼѵ��',temp,'......'])
    trainmain(extra_options_path);
    disp(['����ѵ��',temp,'......'])
    
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