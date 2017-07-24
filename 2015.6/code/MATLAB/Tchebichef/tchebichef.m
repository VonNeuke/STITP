clear
clc
%读取图像并归一化
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_img = imread('E:\stitp\数据\pictures\fu.bmp');
N = size(f_img,1);%图像像素
f_img = double(f_img);
fmax = max(max(f_img));
f_img = f_img/fmax;

n = input('Tchebichef矩阶数（多项式最大阶数）：');%Tchebichef矩阶数

%多项式矩阵
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=tchebichef_polynomials_func(N,n);

%切比雪夫矩
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p=zeros([n+1,N]);
p(1,:)=N;
for m=2:n+1
    n0=m-1;
    p(m,:)=p(m-1,:)*(1-n0^2/N^2)*(2*n0-1)/(2*n0+1);
end

% B=zeros([n+1,N]);
% for m=1:n+1
%     B(m,:)=N^(m-1);
% end
% 
% pp=p./(B.^2);
% 
M=T*f_img*T';

% T_pq=1./(pp*pp').*(T*f_img*T');
T_pq=inv(p*p').*(T*f_img*T');

%切比雪夫逆变换
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_xy=T'*T_pq*T;
imshow(f_xy)