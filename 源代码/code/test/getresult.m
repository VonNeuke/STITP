%������traningʱ��û��ʹ��3Dlevel����������׶�ʹ��
clear
clc
num = 5 ;
path = 'F:\DHJ\������\result\pat1\';
path_result = 'F:\DHJ\������\leveset\pat1\';
for i = 1 : num
disp('��ʼ�ָ�')
temp_path = strcat(path,'result_Day',num2str(i),'.mat');
load(temp_path)
temp_path = strcat(path_result,'result_Day',num2str(i),'.mat');

if exist(temp_path,'file')
continue;
end

temp_result = level_set_3D(temp_result,100);
save(temp_path,'temp_result');
disp('�ָ����')

end