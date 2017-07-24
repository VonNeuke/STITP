%在运行traning时，没有使用3Dlevel，用于这个阶段使用
clear
clc
num = 5 ;
path = 'F:\DHJ\课题三\result\pat1\';
path_result = 'F:\DHJ\课题三\leveset\pat1\';
for i = 1 : num
disp('开始分割')
temp_path = strcat(path,'result_Day',num2str(i),'.mat');
load(temp_path)
temp_path = strcat(path_result,'result_Day',num2str(i),'.mat');

if exist(temp_path,'file')
continue;
end

temp_result = level_set_3D(temp_result,100);
save(temp_path,'temp_result');
disp('分割结束')

end