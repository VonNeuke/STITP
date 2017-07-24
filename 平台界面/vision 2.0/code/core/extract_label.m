%%
%取出文件夹标签
function [ label ] = extract_label(path_label,num)
if num == 0
    error('无法从文件夹内提取数据')
end
for i = 1:num
    temp = load_data(path_label,i);
    if  i ==1
        label =  temp;
    else
        label = [label;temp];
    end
end
end