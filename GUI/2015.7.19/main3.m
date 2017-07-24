clear
clc
%Reconstruction from limited projections via legendre moments
%�÷���δ֪�Ƕȵķ�Χ����̫��ֻ��ռ��Խ�С�ķ�Χ�������ؽ�Ч���ź�
% load test_phantom_zhou;%%�����ܽ���phantom
I=imread('F:\DHJ\2015.7.19\4.bmp');
I=double(I);
% imag_size=127;
imag_size=size(I,1);
% % % % % % % I=shepplogan(imag_size, imag_size,1);
% % % % nb=imag_size;%ȷ��ͶӰ���ݵ�ά��
na=180;
% nb=127;
% p=imresize(I,[imag_size,imag_size]);
% a=getG(imag_size,imag_size,nb,na);%�������ʾ���a
% sino=a*p(:);%����ͶӰ����
% sino=reshape(sino,nb,na);
theta1=0:180/na:(180-180/na);%%�����Ƕ�
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
index1=25;%%��֪�Ƕȵķ�Χ��25��155     %�ɸ���
index2=180-index1;%�ɸ���
theta2=index1:index2;
sinoo(:,index1:index2)=sino(:,index1:index2);%�ضϵ�ͶӰ����  sinoo
cutoff=0.7;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% reconstruction using fbp method &&
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fbp_imag=iradon(sinoo,theta1,'linear','Hamming',cutoff,imag_size);%�ض�ͶӰ���ݻָ���ͼ��  fbp_imag
% figure(1)
% iptsetpref('ImshowBorder','tight')
% imshow(fbp_imag,[ ])

%----------------------------------------�ָ���----------------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Image moments estimated from limited projection moments %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


order=20;%�ɸ���
Known_theta=theta(index1:index2);
new_na=size(Known_theta,1);
Known_sino=sino(:,index1:index2);
pro_moments=pro_mom(Known_sino,order);%������֪�Ƕȵ�ͶӰ��

%�����Ǽ���ϵ������T
M=0:(order+1);
M=sum(M);

T_matrix=zeros(new_na*(order+1),M);
T_matrix=get_T(Known_theta,order);%����ϵ������
fi_matrix=reshape(pro_moments(1:(order+1),:)',new_na*(order+1),1);%��ͶӰ����ֱ
%�Է��Ͼ���������Ҫ
imag_moments=T_matrix\fi_matrix;%�����ͼ���


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% get unkown sinogram  from estimated image moments above %%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Unknown_theta1=theta(1:index1-1);
Unknown_theta2=theta(index2+1:na);
nna1=size(Unknown_theta1,1);
nna2=size(Unknown_theta2,1);

%����δ֪�Ƕȶ�Ӧ��ϵ������T1,T2

T_matrix1=get_T(Unknown_theta1,order);
T_matrix2=get_T(Unknown_theta2,order);

%����δ֪�Ƕȵ�ͶӰ��
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
%����δ֪�Ƕȶ�Ӧ��ͶӰ����
es_sino1=P'*es_promom1;
es_sino2=P'*es_promom2;
es_sino=zeros(nb,na);
%��δ֪ͶӰ���ݺ���֪ͶӰ���ݺϲ���һ��������
es_sino(:,1:index1-1)=es_sino1;
es_sino(:,index2+1:na)=es_sino2;
es_sino(:,index1:index2)=Known_sino;%���Ƴ�����ͶӰ���� es_sino

%��FBP�������ؽ�
recon=iradon(es_sino, theta1,'linear','Hamming',cutoff,imag_size);
recon=max(recon,0.0);%�������ݻָ���ͼ��recon
figure(2)
iptsetpref('ImshowBorder','tight')
imshow(recon,[ ])

