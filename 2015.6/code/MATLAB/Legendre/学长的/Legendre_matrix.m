clc;
clear;
%��ȡͼ�����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_img = imread('E:\stitp\����\pictures\fu.bmp');
%f_img = rgb2gray(f_img);

%��ͼ������һ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_img = size(f_img,1);%n_imgΪͼ����������
f_img = double(f_img);%��f_img����תΪdouble�ͣ�����������
fmax=max(max(f_img));%fmax�Ǿ���f_img�е����ֵ
f_img=f_img/fmax;%��ͼ������һ��

N = input('Legend�ؽ����� ');
L_pq = ones(N+1,N+1);%����L_pqΪһ��N+1�׾���
f_pq = ones(n_img,n_img);%f_pq�Ľ���Ϊͼ����������
p = 0:1:N;

%��legendre��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F_p = Legend_n_disperse( n_img,N);%F_pΪN��legendre����ʽ��ɵľ���

L_pq = ((2*p'+1)*(2*p+1)).*(F_p*f_img*F_p')/(n_img-1)^2;%��N+1��n����n��%%n������%%����n��N+1��

%legendre����任
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L_pq = fliplr(triu(fliplr(L_pq),0));
f_pq = F_p'*L_pq*F_p;
% 
% K = mean(f_pq(:)/);
% f_pq(f_pq<K) = 0;
% f_pq(f_pq>K) = 255;

imshow(f_pq);

