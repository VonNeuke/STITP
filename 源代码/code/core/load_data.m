%%
%通过文件夹载入数据
function [ data ]=load_data(path,index)
         temp_path = strcat(path,num2str(index),'.mat');
         data = load(temp_path);
         data = data.temp_data;
end