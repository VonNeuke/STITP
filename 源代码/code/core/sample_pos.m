function [ traningdata_pos , label ] = sample_pos( label_image , image , n_sample,options)
% sample_pos用于计算标记图像点的位置，进行随机采样
% label_image是标记好的图像
% n_sample需要采样的点的个数
%image是原本图像
% traningdata_pos是采样点位置
% label是标签
%已经改进，traningdata_pos可以输出索引
%%
%-----------------------------------------------------------------------初始化------------------------------------------------------------------------------------------------------------------%
n_ledge_pos = n_sample*0.5*0.7;%前列腺边界采样个数
n_in_pos = n_sample*0.5*0.3;%前列腺内部采样个数

n_air_pos = n_sample*0.5*0.25;%气体的位置
n_bone_pos = n_sample*0.5*0.25;%骨头的位置
n_other_pos = n_sample*0.5*0.5;%除气体外，其他反例个数

if isfield(label_image,'bla')
   img_pro = label_image.pro;
else
    disp('')
end


image_size = size(label_image);%计算图像的大小
if n_sample > (image_size(1)*image_size(2)*image_size(3))
   error('采样点过多');
end

%image_temp=label_image;%存储label_image的缓存,用于获得边界图
image_temp = reshape(label_image,image_size(1)*image_size(2),image_size(3));%把3d图像平铺成2d图像，方便后面进行边缘检测


%%
%-----------------二值分割方法，标记出前列腺边界，标记为1 -------------------------------%
[B,L,N] = bwboundaries(logical(image_temp),8,'noholes');%获得坐标B
B = cell2mat(B);%把cell 转换成 mat
B = sub2ind(size(image_temp),B(:,1),B(:,2));%把坐标转换索引
image_temp(B) = 1;%令边界的值为1
image_temp = reshape(image_temp,image_size(1),image_size(2),image_size(3));%把2D转换成3D

%------------------标记出气体点，标记为-1，标记骨头点，标记为-2-----------------------------------------------%
label_image(image <= 200) = -1;
label_image(image >=1500) = -2;

%%
%----------------------------------------------------------------------获取采样点坐标---------------------------------------------------------------------------------------------------------------%
%%
%抽取骨头点
if n_bone_pos ~= 0
temp_index = find(label_image == -2);
    if size(temp_index,1) < n_bone_pos
    disp('无法获取足够数量的骨头反例点,把采样指标给非气体反例采样点');
    n_bone_pos = size(temp_index,1);
    n_other_pos = n_sample*0.5 - n_air_pos - n_bone_pos;
    end
temp_sample = randsample(size(temp_index,1),n_bone_pos);
temp_index = temp_index(temp_sample);
[ x , y ] = size(temp_index);
    if n_bone_pos ~= x || y ~= 1
        error('骨头位置矩阵大小出错');
    end
negative_pos = temp_index;
end
%%
%抽取气体点
if n_air_pos ~= 0
temp_index = find(label_image == -1);
    if size(temp_index,1) < n_air_pos
    disp('无法获取足够数量的气体反例点,把采样指标给非气体反例采样点');
    n_air_pos = size(temp_index,1);
    n_other_pos = n_sample*0.5 - n_air_pos - n_bone_pos;
    end
temp_sample = randsample(size(temp_index,1),n_air_pos);
temp_index = temp_index(temp_sample);
[ x , y ] = size(temp_index);
    if n_air_pos ~= x || y ~= 1
        error('气体位置矩阵大小出错');
    end
negative_pos = [ negative_pos ; temp_index ];
end

%%
%抽取除气体外的其他反例点
if n_other_pos ~=0
temp_index = find(label_image == 0);%获取反例全部点
if size(temp_index,1)<n_other_pos
   error('无法获取足够数量的非气体反例点');
end
%temp_sample=randperm(size(temp_index,1),n_neg);%获取随机采样点 R2012
temp_sample = randsample(size(temp_index,1),n_other_pos);%获取随机采样点 R2008
temp_index = temp_index(temp_sample);
% [x_temp,y_temp,z_temp]=ind2sub(size(label_image),temp_index);%索引转下标
%negative_pos=[x_temp,y_temp,z_temp];
end

%%
%合成全部的反例点
negative_pos = [ negative_pos ; temp_index ];
[ x , y ] = size(negative_pos);
    if n_other_pos ~= x && y ~= 1
        error('negative位置矩阵大小出错');
    end
label = ones(x,1)*(-1);%反例例标签


%%
%抽取边界正例
if n_ledge_pos ~=0
temp_index = find(image_temp == 1);%获取边界全部点
    if size(temp_index,1) < n_ledge_pos
        disp('无法获取足够数量的前列腺正例边界点');
        n_ledge_pos = size(temp_index,1);
        n_in_pos = n_sample*0.5 - n_ledge_pos;
    end
%temp_sample=randperm(size(temp_index,1),n_ledge_pos);%获取随机采样点R2012
temp_sample = randsample(size(temp_index,1),n_ledge_pos);%获取随机采样点R2008

temp_index = temp_index(temp_sample);
%[x_temp,y_temp,z_temp]=ind2sub(size(label_image),temp_index);%索引转下标
%temp_edge_pos=[x_temp,y_temp,z_temp];
temp_edge_pos = temp_index;
[ x , y ] = size(temp_edge_pos);
    if n_ledge_pos ~= x || y ~= 1
        error('edge位置矩阵大小出错');
    end
end

%%
%抽取非边界正例
if n_in_pos ~= 0
%image_temp=label_image-image_temp;%获取前列腺非边界部分
temp_index = find(image_temp == 255);%获取前列腺非边界部分索引
    if size(temp_index,1) < n_in_pos
         error('无法获取足够数量的前列腺非边界部分点');
    end
%temp_sample=randperm(size(temp_index,1),n_ledge_pos);%获取随机采样点R2012
temp_sample = randsample(size(temp_index,1),n_in_pos);%获取随机采样点R2008
temp_index = temp_index(temp_sample);
%[x_temp,y_temp,z_temp]=ind2sub(size(label_image),temp_index);%索引转下标
%temp_in_pos=[x_temp,y_temp,z_temp];
temp_in_pos = temp_index;
[ x , y ] = size(temp_in_pos);
    if n_in_pos ~=x || y ~= 1
        error('edge位置矩阵大小出错');
    end
end
%%
%合并正例坐标
positive_pos = [ temp_edge_pos ; temp_in_pos ];%合并正例
[ x , y ] = size(positive_pos);
if x ~= n_sample*0.5 && y ~= 1
    error('正例构造有问题');
end
temp_label = ones(x,1);%正例标签

%%
%合并全部坐标
label = [ temp_label ; label ];%正反例标签合成

if exist('options','var')
    if ~isfield(options,'index') 
    %正反例索引合成
    traningdata_pos = [ positive_pos ; negative_pos ];
    end
else
     %正反例索引合成
     traningdata_pos = [ positive_pos ; negative_pos ];
     [ x_temp , y_temp , z_temp ] = ind2sub(size(label_image),traningdata_pos);%索引转下标
     traningdata_pos = [ x_temp , y_temp , z_temp ];
     [ x , y ] = size(traningdata_pos);
     if x ~= n_sample || y ~= 3
     error('traningdata_pos尺寸有问题');
     end
end
end