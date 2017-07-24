clc
clear all
%syms M N i j Xi Yj k p q;
filename='E:\stitp\数据\pictures\fu.bmp';
f=imread(filename);
%f=rgb2gray(f);
%f=~f;
f=double(f);
fmax=max(max(f));
f=f/fmax;
N=size(f,1);
M=input('请输入legendre多项式的最大阶数：');
% i=1:1:N;
% j=1:1:N;
Xi=linspace(-1,1,N);
%Xi=2*i/N-1;
%Yj=2*j/N-1;
Pp=zeros(M+1,N);
Pp(1,:)=1;
Pp(2,:)=Xi;
for k=3:M+1
    Pp(k,:)=((2*(k-1)-1)*Xi.*Pp(k-1,:)-(k-2)*Pp(k-2,:))/(k-1);
    %plot(Xi,Pp(k,:));
    %hold on;
end
% Pq=zeros(M+1,N);
% Pq=Pp;
L=zeros(M+1,M+1);
%f=double(f);
L=Pp*f*Pp';

p=0:1:M;

L=((2*p'+1)*(2*p+1).*L)/(N-1)^2;

Lz=L;
Lz=fliplr(triu(fliplr(Lz),0));
fni=Pp'*Lz*Pp;
imshow(fni);