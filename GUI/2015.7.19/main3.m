clear
clc
%Reconstruction from limited projections via legendre moments
%该方法未知角度的范围不能太大，只能占相对较小的范围，这样重建效果才好
% load test_phantom_zhou;%%导入周建的phantom
I=imread('F:\DHJ\2015.7.19\4.bmp');
I=double(I);
% imag_size=127;
imag_size=size(I,1);
% % % % % % % I=shepplogan(imag_size, imag_size,1);
% % % % nb=imag_size;%确定投影数据的维数
na=180;
% nb=127;
% p=imresize(I,[imag_size,imag_size]);
% a=getG(imag_size,imag_size,nb,na);%产生概率矩阵a
% sino=a*p(:);%产生投影数据
% sino=reshape(sino,nb,na);
theta1=0:180/na:(180-180/na);%%产生角度
theta=theta1*pi/na;
theta=theta';
sino=radon(I,theta1);
nb=size(sino,1);
fbp_imag=iradon(sino,theta1,'linear','Hamming',0.7,imag_size);%
% figure(3)
% iptsetpref('ImshowBorder','tight')
% imshow(fbp_imag,[ ])


% [sino,c1]=psnoise(sino,5*10e6);
sinoo=zeros(nb,na);
index1=25;%%所知角度的范围：25～155     %可改项
index2=180-index1;%可改项
theta2=index1:index2;
sinoo(:,index1:index2)=sino(:,index1:index2);%截断的投影数据  sinoo
cutoff=0.7;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% reconstruction using fbp method &&
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fbp_imag=iradon(sinoo,theta1,'linear','Hamming',cutoff,imag_size);%截断投影数据恢复的图像  fbp_imag
% figure(1)
% iptsetpref('ImshowBorder','tight')
% imshow(fbp_imag,[ ])

%----------------------------------------分割线----------------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Image moments estimated from limited projection moments %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


order=20;%可改项
Known_theta=theta(index1:index2);
new_na=size(Known_theta,1);
Known_sino=sino(:,index1:index2);
pro_moments=pro_mom(Known_sino,order);%计算所知角度的投影矩

%下面是计算系数矩阵T
M=0:(order+1);
M=sum(M);

T_matrix=zeros(new_na*(order+1),M);
T_matrix=get_T(Known_theta,order);%计算系数矩阵
fi_matrix=reshape(pro_moments(1:(order+1),:)',new_na*(order+1),1);%将投影矩拉直
%以符合矩阵计算的需要
imag_moments=T_matrix\fi_matrix;%计算出图像矩


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% get unkown sinogram  from estimated image moments above %%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Unknown_theta1=theta(1:index1-1);
Unknown_theta2=theta(index2+1:na);
nna1=size(Unknown_theta1,1);
nna2=size(Unknown_theta2,1);

%计算未知角度对应的系数矩阵T1,T2

T_matrix1=get_T(Unknown_theta1,order);
T_matrix2=get_T(Unknown_theta2,order);

%计算未知角度的投影矩
es_promom1=T_matrix1*imag_moments;
es_promom2=T_matrix2*imag_moments;
es_promom1=reshape(es_promom1,nna1,order+1);
es_promom2=reshape(es_promom2,nna2,order+1);
es_promom1=es_promom1';
es_promom2=es_promom2';

s=-1+1/nb:2/nb:1-1/nb;
P=zeros(order+1,nb);
for i=0:order
    temp=legendre(i,s);
    P(i+1,:)=sqrt((2*i+1)/2)*temp(1,:);
end
%计算未知角度对应的投影数据
es_sino1=P'*es_promom1;
es_sino2=P'*es_promom2;
es_sino=zeros(nb,na);
%将未知投影数据和已知投影数据合并到一个矩阵中
es_sino(:,1:index1-1)=es_sino1;
es_sino(:,index2+1:na)=es_sino2;
es_sino(:,index1:index2)=Known_sino;%估计出来的投影数据 es_sino

%用FBP方法反重建
recon=iradon(es_sino, theta1,'linear','Hamming',cutoff,imag_size);
recon=max(recon,0.0);%估计数据恢复的图像recon
figure(2)
iptsetpref('ImshowBorder','tight')
imshow(recon,[ ])


