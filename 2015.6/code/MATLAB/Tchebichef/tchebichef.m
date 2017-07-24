clear
clc
%��ȡͼ�񲢹�һ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_img = imread('E:\stitp\����\pictures\fu.bmp');
N = size(f_img,1);%ͼ������
f_img = double(f_img);
fmax = max(max(f_img));
f_img = f_img/fmax;

n = input('Tchebichef�ؽ���������ʽ����������');%Tchebichef�ؽ���

%����ʽ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=tchebichef_polynomials_func(N,n);

%�б�ѩ���
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

%�б�ѩ����任
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_xy=T'*T_pq*T;
imshow(f_xy)