function [ traningdata_pos , label ] = sample_pos( label_image , image , n_sample,options)
% sample_pos���ڼ�����ͼ����λ�ã������������
% label_image�Ǳ�Ǻõ�ͼ��
% n_sample��Ҫ�����ĵ�ĸ���
%image��ԭ��ͼ��
% traningdata_pos�ǲ�����λ��
% label�Ǳ�ǩ
%�Ѿ��Ľ���traningdata_pos�����������
%%
%-----------------------------------------------------------------------��ʼ��------------------------------------------------------------------------------------------------------------------%
n_ledge_pos = n_sample*0.5*0.7;%ǰ���ٱ߽��������
n_in_pos = n_sample*0.5*0.3;%ǰ�����ڲ���������

n_air_pos = n_sample*0.5*0.25;%�����λ��
n_bone_pos = n_sample*0.5*0.25;%��ͷ��λ��
n_other_pos = n_sample*0.5*0.5;%�������⣬������������

if isfield(label_image,'bla')
   img_pro = label_image.pro;
else
    disp('')
end


image_size = size(label_image);%����ͼ��Ĵ�С
if n_sample > (image_size(1)*image_size(2)*image_size(3))
   error('���������');
end

%image_temp=label_image;%�洢label_image�Ļ���,���ڻ�ñ߽�ͼ
image_temp = reshape(label_image,image_size(1)*image_size(2),image_size(3));%��3dͼ��ƽ�̳�2dͼ�񣬷��������б�Ե���


%%
%-----------------��ֵ�ָ������ǳ�ǰ���ٱ߽磬���Ϊ1 -------------------------------%
[B,L,N] = bwboundaries(logical(image_temp),8,'noholes');%�������B
B = cell2mat(B);%��cell ת���� mat
B = sub2ind(size(image_temp),B(:,1),B(:,2));%������ת������
image_temp(B) = 1;%��߽��ֵΪ1
image_temp = reshape(image_temp,image_size(1),image_size(2),image_size(3));%��2Dת����3D

%------------------��ǳ�����㣬���Ϊ-1����ǹ�ͷ�㣬���Ϊ-2-----------------------------------------------%
label_image(image <= 200) = -1;
label_image(image >=1500) = -2;

%%
%----------------------------------------------------------------------��ȡ����������---------------------------------------------------------------------------------------------------------------%
%%
%��ȡ��ͷ��
if n_bone_pos ~= 0
temp_index = find(label_image == -2);
    if size(temp_index,1) < n_bone_pos
    disp('�޷���ȡ�㹻�����Ĺ�ͷ������,�Ѳ���ָ��������巴��������');
    n_bone_pos = size(temp_index,1);
    n_other_pos = n_sample*0.5 - n_air_pos - n_bone_pos;
    end
temp_sample = randsample(size(temp_index,1),n_bone_pos);
temp_index = temp_index(temp_sample);
[ x , y ] = size(temp_index);
    if n_bone_pos ~= x || y ~= 1
        error('��ͷλ�þ����С����');
    end
negative_pos = temp_index;
end
%%
%��ȡ�����
if n_air_pos ~= 0
temp_index = find(label_image == -1);
    if size(temp_index,1) < n_air_pos
    disp('�޷���ȡ�㹻���������巴����,�Ѳ���ָ��������巴��������');
    n_air_pos = size(temp_index,1);
    n_other_pos = n_sample*0.5 - n_air_pos - n_bone_pos;
    end
temp_sample = randsample(size(temp_index,1),n_air_pos);
temp_index = temp_index(temp_sample);
[ x , y ] = size(temp_index);
    if n_air_pos ~= x || y ~= 1
        error('����λ�þ����С����');
    end
negative_pos = [ negative_pos ; temp_index ];
end

%%
%��ȡ�������������������
if n_other_pos ~=0
temp_index = find(label_image == 0);%��ȡ����ȫ����
if size(temp_index,1)<n_other_pos
   error('�޷���ȡ�㹻�����ķ����巴����');
end
%temp_sample=randperm(size(temp_index,1),n_neg);%��ȡ��������� R2012
temp_sample = randsample(size(temp_index,1),n_other_pos);%��ȡ��������� R2008
temp_index = temp_index(temp_sample);
% [x_temp,y_temp,z_temp]=ind2sub(size(label_image),temp_index);%����ת�±�
%negative_pos=[x_temp,y_temp,z_temp];
end

%%
%�ϳ�ȫ���ķ�����
negative_pos = [ negative_pos ; temp_index ];
[ x , y ] = size(negative_pos);
    if n_other_pos ~= x && y ~= 1
        error('negativeλ�þ����С����');
    end
label = ones(x,1)*(-1);%��������ǩ


%%
%��ȡ�߽�����
if n_ledge_pos ~=0
temp_index = find(image_temp == 1);%��ȡ�߽�ȫ����
    if size(temp_index,1) < n_ledge_pos
        disp('�޷���ȡ�㹻������ǰ���������߽��');
        n_ledge_pos = size(temp_index,1);
        n_in_pos = n_sample*0.5 - n_ledge_pos;
    end
%temp_sample=randperm(size(temp_index,1),n_ledge_pos);%��ȡ���������R2012
temp_sample = randsample(size(temp_index,1),n_ledge_pos);%��ȡ���������R2008

temp_index = temp_index(temp_sample);
%[x_temp,y_temp,z_temp]=ind2sub(size(label_image),temp_index);%����ת�±�
%temp_edge_pos=[x_temp,y_temp,z_temp];
temp_edge_pos = temp_index;
[ x , y ] = size(temp_edge_pos);
    if n_ledge_pos ~= x || y ~= 1
        error('edgeλ�þ����С����');
    end
end

%%
%��ȡ�Ǳ߽�����
if n_in_pos ~= 0
%image_temp=label_image-image_temp;%��ȡǰ���ٷǱ߽粿��
temp_index = find(image_temp == 255);%��ȡǰ���ٷǱ߽粿������
    if size(temp_index,1) < n_in_pos
         error('�޷���ȡ�㹻������ǰ���ٷǱ߽粿�ֵ�');
    end
%temp_sample=randperm(size(temp_index,1),n_ledge_pos);%��ȡ���������R2012
temp_sample = randsample(size(temp_index,1),n_in_pos);%��ȡ���������R2008
temp_index = temp_index(temp_sample);
%[x_temp,y_temp,z_temp]=ind2sub(size(label_image),temp_index);%����ת�±�
%temp_in_pos=[x_temp,y_temp,z_temp];
temp_in_pos = temp_index;
[ x , y ] = size(temp_in_pos);
    if n_in_pos ~=x || y ~= 1
        error('edgeλ�þ����С����');
    end
end
%%
%�ϲ���������
positive_pos = [ temp_edge_pos ; temp_in_pos ];%�ϲ�����
[ x , y ] = size(positive_pos);
if x ~= n_sample*0.5 && y ~= 1
    error('��������������');
end
temp_label = ones(x,1);%������ǩ

%%
%�ϲ�ȫ������
label = [ temp_label ; label ];%��������ǩ�ϳ�

if exist('options','var')
    if ~isfield(options,'index') 
    %�����������ϳ�
    traningdata_pos = [ positive_pos ; negative_pos ];
    end
else
     %�����������ϳ�
     traningdata_pos = [ positive_pos ; negative_pos ];
     [ x_temp , y_temp , z_temp ] = ind2sub(size(label_image),traningdata_pos);%����ת�±�
     traningdata_pos = [ x_temp , y_temp , z_temp ];
     [ x , y ] = size(traningdata_pos);
     if x ~= n_sample || y ~= 3
     error('traningdata_pos�ߴ�������');
     end
end
end