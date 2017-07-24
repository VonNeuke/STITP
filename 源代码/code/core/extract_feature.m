%%
%��ȡ�ļ����ڶ�Ӧ�����������
function [ temp ] = extract_feature(path_feature,path_pos,num,options)
if num == 0
    error('�޷����ļ�������ȡ����')
end

for i = 1:num
    temp_feature = load_data(path_feature,i);
    if  exist('options','var')
        if ~isfield(options,'all')
            if  i ==1
                temp = temp_feature;
            else
                temp = [temp;temp_feature];
            end
        end
    else
        temp_pos = load_data(path_pos,i);
        if  i ==1
            temp = temp_feature(temp_pos,:);
        else
            temp = [temp;temp_feature(temp_pos,:)];
        end
    end   
end
end