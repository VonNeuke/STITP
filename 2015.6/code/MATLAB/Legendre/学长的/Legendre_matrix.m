clc;
clear;
%读取图像矩阵
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_img = imread('E:\stitp\数据\pictures\fu.bmp');
%f_img = rgb2gray(f_img);

%将图像矩阵归一化
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_img = size(f_img,1);%n_img为图像矩阵的行数
f_img = double(f_img);%将f_img矩阵转为double型，方便作除法
fmax=max(max(f_img));%fmax是矩阵f_img中的最大值
f_img=f_img/fmax;%将图像矩阵归一化

N = input('Legend矩阶数： ');
L_pq = ones(N+1,N+1);%定义L_pq为一个N+1阶矩阵
f_pq = ones(n_img,n_img);%f_pq的阶数为图像矩阵的行数
p = 0:1:N;

%求legendre矩
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F_p = Legend_n_disperse( n_img,N);%F_p为N阶legendre多项式组成的矩阵

L_pq = ((2*p'+1)*(2*p+1)).*(F_p*f_img*F_p')/(n_img-1)^2;%（N+1，n）（n，%%n？？？%%）（n，N+1）

%legendre矩逆变换
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L_pq = fliplr(triu(fliplr(L_pq),0));
f_pq = F_p'*L_pq*F_p;
% 
% K = mean(f_pq(:)/);
% f_pq(f_pq<K) = 0;
% f_pq(f_pq>K) = 255;

imshow(f_pq);

