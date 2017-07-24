function [ contextfeasture ] = cal_context_features( image , sample_pos ,options )
%cal_context_feature���ڼ���context feastures����
%image����ͼ��3D
%sample_pos�����ĵ�λ��,��options ��index ʱ�򣬿�����������������ʱ��ֻ������������
%contextfeasture�������������ֵ
%�Ѿ��Ľ����㷨�ٶ���ߣ���ƫ���������㣬������ѭ������
%%
%��ʼ������
R = [4 , 5 , 6 , 8 , 10 , 12 , 14 , 16 , 20 , 25 , 30 , 40 , 50 ];%�뾶s
W = 0:7;

%��ȡ����ģ��ƫ�ƽǶ�
alph = floor(cos(pi*0.25*W)'*R + 0.5) ;
beta = floor(sin(pi*0.25*W)'*R + 0.5) ;
alph = alph(:);
beta = beta(:);
pos  = [[0 0];alph,beta];%��ȡcontxt features ��X��Y ƽ������� 

%��ȡͼ���С
n_size   = size(image);
%pos = random_sample( n_size ,sample_pos, R)
%��ȡ���ж��ٸ����������
n_sample = size(sample_pos,1);

%�߽����
fill_x = zeros(max(R),n_size(2),n_size(3));
fill_y = zeros((max(R)*2 + n_size(1)),max(R),n_size(3));
%fill_z = zeros(n_size(1)+max(R)*2,n_size(2)+max(R)*2,max(R));
%��ȡXYƽ��,������չXYƽ��
temp_image = [ fill_x ; image ; fill_x];
temp_image = [ fill_y , temp_image , fill_y];
% temp_image = cat(3,temp_image,fill_z);
% temp_image = cat(3,fill_z,temp_image);

%��ȡ��ֵͼ�� 
% temp_image_mean = temp_image;
% temp_image_mean = reshape(temp_image_mean,size(temp_image,1)*size(temp_image,2),size(temp_image,3));
% temp_image_mean = colfilt(temp_image_mean,[3 3],'sliding',@mean);
% temp_image_mean = reshape(temp_image_mean,size(temp_image,1),size(temp_image,2),size(temp_image,3));%��2Dת����3D
%�������
temp_sample_pos = sample_pos;
    
%����ת�±�
if exist('options','var')
    if ~isfield(options,'index')
    [ x_temp , y_temp , z_temp ] = ind2sub(size(image),sample_pos);%����ת�±�
    temp_sample_pos = [ x_temp , y_temp , z_temp ];
    clear x_temp  y_temp  z_temp 
    [ x , y ] = size(temp_sample_pos);
        if x ~= n_sample || y ~= 3
        error('tmep_sample_pos�ߴ�������');
        end
    end
end

%��contextfeasture ��ʼ��0�����Ч��
%context_haar = [];
% context_int = zeros(size(temp_sample_pos,1),size(pos,1));
% context_mean = zeros(size(temp_sample_pos,1),size(pos,1));
 %%
%����context features
for i = 1:size(pos,1)
    %��ȡƫ����
    x = pos(i,1);
    y = pos(i,2);
    %z = tmep_sample_pos(i,3);
    %��ȡcontext features ģ������
    temp_pos(:,1) = x + temp_sample_pos(:,1) + max(R);
    temp_pos(:,2) = y + temp_sample_pos(:,2) + max(R);
    temp_pos(:,3) = temp_sample_pos(:,3);
    %��ȡcontext feasture
    index = sub2ind(size(temp_image),temp_pos(:,1),temp_pos(:,2),temp_pos(:,3));
%     temp  = temp_image(index);
%     v_max = max(max(temp));
%     v_min = min(min(temp));
    contextfeasture(:,i) = temp_image(index);
    %��ȡ��ֵ
%     temp  = temp_image_mean(index);
%     v_max = max(max(temp));
%     v_min = min(min(temp));
%     context_mean(:,i) = (temp -v_min)/(v_max - v_min);
    %��ȡhaar feature
    %temp_context_haar = cal_haar_features_3D(image, temp_pos);
    %context_haar =[context_haar,temp_context_haar];
end

%��һ��
%context_int = context_int;
%temp = context_int(:,1);
%context_diff    = abs( bsxfun(@minus,context_int(:,2:size(context_int,2)),context_int(:,1)));
%%context_diff = [context_int(:,1),context_diff];
%contextfeasture = [context_int,context_diff,context_mean,context_haar];
%contextfeasture = [context_int,context_diff,context_mean];
end
