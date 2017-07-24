clc;
clear;
path_result = 'L:\课题二\result_population\';
path_levset_save = 'L:\课题二\levset_population\';

name = dir(path_result);
name(1) = [];
name(1) = [];
num_seg = 3;
len = length(name);

for i = 1:len
    temp = name(i).name;
    mkdir([path_levset_save,'lesvset_',temp]);
    for k = 1:num_seg
    %disp([path_population,temp,'\','img',int2str(k),'.mat'])
    load([path_result,temp,'\','result_Day',int2str(k),'.mat']);
    disp('levset beginning...')
    disp(['image分割',path_result,temp,'\','result_Day',int2str(k),'.mat','中......'])
        if ~exist([path_levset_save,'lesvset_',temp,'\','result_Day',num2str(k),'.mat'],'file')
            temp_result = level_set_3D(temp_result,100);
            save([path_levset_save,'lesvset_',temp,'\','result_Day',num2str(k),'.mat'],'temp_result');
            clear temp_result
        end
    disp('levset over...')
    end
end