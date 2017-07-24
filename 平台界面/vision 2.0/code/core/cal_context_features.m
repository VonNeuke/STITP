function [ contextfeasture ] = cal_context_features( image , sample_pos ,options )
%cal_context_feature用于计算context feastures特征
%image输入图像，3D
%sample_pos采样的的位置,当options 是index 时候，可以输入索引，不是时，只可以输入坐标
%contextfeasture计算出来的特征值
%已经改进，算法速度提高，从偏移量来计算，减少了循环次数
%%
%初始化参数
R = [4 , 5 , 6 , 8 , 10 , 12 , 14 , 16 , 20 , 25 , 30 , 40 , 50 ];%半径s
W = 0:7;

%获取采样模板偏移角度
alph = floor(cos(pi*0.25*W)'*R + 0.5) ;
beta = floor(sin(pi*0.25*W)'*R + 0.5) ;
alph = alph(:);
beta = beta(:);
pos  = [[0 0];alph,beta];%获取contxt features 在X，Y 平面的坐标 

%获取图像大小
n_size   = size(image);
%pos = random_sample( n_size ,sample_pos, R)
%获取共有多少个采样点个数
n_sample = size(sample_pos,1);

%边界填充
fill_x = zeros(max(R),n_size(2),n_size(3));
fill_y = zeros((max(R)*2 + n_size(1)),max(R),n_size(3));
%fill_z = zeros(n_size(1)+max(R)*2,n_size(2)+max(R)*2,max(R));
%获取XY平面,并且扩展XY平面
temp_image = [ fill_x ; image ; fill_x];
temp_image = [ fill_y , temp_image , fill_y];
% temp_image = cat(3,temp_image,fill_z);
% temp_image = cat(3,fill_z,temp_image);

%获取均值图像 
% temp_image_mean = temp_image;
% temp_image_mean = reshape(temp_image_mean,size(temp_image,1)*size(temp_image,2),size(temp_image,3));
% temp_image_mean = colfilt(temp_image_mean,[3 3],'sliding',@mean);
% temp_image_mean = reshape(temp_image_mean,size(temp_image,1),size(temp_image,2),size(temp_image,3));%把2D转换成3D
%存放坐标
temp_sample_pos = sample_pos;
    
%索引转下标
if exist('options','var')
    if ~isfield(options,'index')
    [ x_temp , y_temp , z_temp ] = ind2sub(size(image),sample_pos);%索引转下标
    temp_sample_pos = [ x_temp , y_temp , z_temp ];
    clear x_temp  y_temp  z_temp 
    [ x , y ] = size(temp_sample_pos);
        if x ~= n_sample || y ~= 3
        error('tmep_sample_pos尺寸有问题');
        end
    end
end

%给contextfeasture 初始化0，提高效率
%context_haar = [];
% context_int = zeros(size(temp_sample_pos,1),size(pos,1));
% context_mean = zeros(size(temp_sample_pos,1),size(pos,1));
 %%
%计算context features
for i = 1:size(pos,1)
    %获取偏移量
    x = pos(i,1);
    y = pos(i,2);
    %z = tmep_sample_pos(i,3);
    %获取context features 模板坐标
    temp_pos(:,1) = x + temp_sample_pos(:,1) + max(R);
    temp_pos(:,2) = y + temp_sample_pos(:,2) + max(R);
    temp_pos(:,3) = temp_sample_pos(:,3);
    %获取context feasture
    index = sub2ind(size(temp_image),temp_pos(:,1),temp_pos(:,2),temp_pos(:,3));
%     temp  = temp_image(index);
%     v_max = max(max(temp));
%     v_min = min(min(temp));
    contextfeasture(:,i) = temp_image(index);
    %获取均值
%     temp  = temp_image_mean(index);
%     v_max = max(max(temp));
%     v_min = min(min(temp));
%     context_mean(:,i) = (temp -v_min)/(v_max - v_min);
    %获取haar feature
    %temp_context_haar = cal_haar_features_3D(image, temp_pos);
    %context_haar =[context_haar,temp_context_haar];
end

%归一化
%context_int = context_int;
%temp = context_int(:,1);
%context_diff    = abs( bsxfun(@minus,context_int(:,2:size(context_int,2)),context_int(:,1)));
%%context_diff = [context_int(:,1),context_diff];
%contextfeasture = [context_int,context_diff,context_mean,context_haar];
%contextfeasture = [context_int,context_diff,context_mean];
end
