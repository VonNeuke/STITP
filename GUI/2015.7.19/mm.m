clear
%Reconstruction from limited projections via legendre moments
%�÷���δ֪�Ƕȵķ�Χ����̫��ֻ��ռ��Խ�С�ķ�Χ�������ؽ�Ч���ź�
load test_phantom_zhou;%%�����ܽ���phantom
% load 'Continue-sino-127-180.mat'
% I=imread('4.bmp');
I=double(I);
imag_size=127;
% % % % % % % % I=shepplogan(imag_size, imag_size,1);
% % % % % % nb=imag_size;%ȷ��ͶӰ���ݵ�ά��
na=180;
p=imresize(I,[imag_size,imag_size]);
% p=p./max(max(p));
% % % % % % imshow(p,[])
% % % % % % pp=p./255;
% % % % % % % % im(p)
% % % % % % a=getG(imag_size,imag_size,nb,na);%�������ʾ���a
% % % % % b=a*pp(:);%����ͶӰ����
% % % % % sino=reshape(b,nb,na);
% % % % % load sino127-180;
% % % % load 'ct-sino-127-180-gaussian'
index1=25;%%��֪�Ƕȵķ�Χ��25��155
index2=180-index1;
theta1=0:180/na:(180-180/na);%%�����Ƕ�
theta=theta1*pi/na;
theta=theta';
theta2=index1:index2;
sino=radon(p,theta1);
nb=size(sino,1);
% [sino,c1]=psnoise(sino,4*10e5);
sinoo=zeros(nb,na);
sinoo(:,index1:index2)=sino(:,index1:index2);
cutoff=0.5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% reconstruction using fbp method &&
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fbp_imag=iradon(sinoo,theta1,'linear','Ram-Lak',0.5,imag_size);
fbp_imag=iradon(sinoo,theta1,'linear','Hamming',cutoff,imag_size);
iptsetpref('ImshowBorder','tight')
imshow(fbp_imag,[0 max(max(fbp_imag))])
% fbp_imag=fbp_imag./max(max(fbp_imag));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Image moments estimated from limited projection moments %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

order=15;
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

% Unknown_theta1=theta(1:index1-1);
% Unknown_theta2=theta(index2+1:na);
% nna1=size(Unknown_theta1,1);
% nna2=size(Unknown_theta2,1);
% %����δ֪�Ƕȶ�Ӧ��ϵ������T1,T2
% T_matrix1=get_T(Unknown_theta1,order);
% T_matrix2=get_T(Unknown_theta2,order);
% % %����δ֪�Ƕȵ�ͶӰ��
% es_promom1=T_matrix1*imag_moments;
% es_promom2=T_matrix2*imag_moments;
% es_promom1=reshape(es_promom1,nna1,order+1);
% es_promom2=reshape(es_promom2,nna2,order+1);
% es_promom1=es_promom1';
% es_promom2=es_promom2';
TT_matrix=get_T(theta,order);
es_promom=TT_matrix*imag_moments;
es_promom=reshape(es_promom,na,order+1);
es_promom=es_promom';
s=-1+1/nb:2/nb:1-1/nb;
P=zeros(order+1,nb);
for i=0:order
    temp=legendre(i,s);
    P(i+1,:)=sqrt((2*i+1)/2)*temp(1,:);
end
%����δ֪�Ƕȶ�Ӧ��ͶӰ����
es_sino1=P'*es_promom(:,1:index1-1);
es_sino2=P'*es_promom(:,index2+1:na);
es_sino=zeros(nb,na);
%��δ֪ͶӰ���ݺ���֪ͶӰ���ݺϲ���һ��������
es_sino(:,1:index1-1)=es_sino1;
es_sino(:,index2+1:na)=es_sino2;
es_sino(:,index1:index2)=Known_sino;

%��FBP�������ؽ�
% recon=iradon(es_sino, theta1,'linear','Ram-Lak',0.5,imag_size);
recon=iradon(es_sino, theta1,'linear','Hamming',cutoff,imag_size);
% recon2=iradon(es_sino, theta1,'linear', 'Shepp-Logan',0.5,imag_size);
% recon=max(recon,0.0);
figure(2)
iptsetpref('ImshowBorder','tight')
imshow(recon,[])
% p=p./max(max(p));
error1=mse(p,fbp_imag)
% re=recon./max(max(recon));
error3=mse(p,recon)
% figure(4)
% imshow(recon2,[])
% error4=mse(p,recon2)