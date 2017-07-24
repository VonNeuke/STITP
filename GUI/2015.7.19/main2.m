clear
%Reconstruction from complete projections via legendre moments
load test_phantom_zhou;
% load projmom;
% load moments;
imag_size=127;
% I=shepplogan(imag_size, imag_size,1);
% I=imread('11.7-1.bmp');
I=double(I);
na=180;%确定投影数据的维数
nb=imag_size;
p=imresize(I,[imag_size imag_size]);
% p=shepplogan(imag_size,imag_size,1);
% %p=I;
% im(p)
a=getG(imag_size,imag_size,nb,na);%产生概率矩阵a
a=a./128;
b=a*p(:);%产生投影数据
sino=reshape(b,nb,na);
%    sino=get_sino(nb,na);
% load 'ct-sino-s509-P2.mat'
theta1=0:180/na:(180-180/na);
theta=theta1*pi/na;
theta=theta';
% sino=radon(p,theta1);
% nb=size(sino,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% reconstruction using fbp method &&
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   fbp_imag=my_fbp(sino,nb,na,imag_size,imag_size);
%  fbp_imag=iradon(sino, theta1,'linear', 'Hamming',0.5,imag_size);
% fbp_imag=max(fbp_imag,0.0);
% figure(2)
% im(fbp_imag')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Image moments from projection moments %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% index=20;
order=20;
cutoff=0.7;
% theta1=theta(index);
% na=size(theta1,1);
pro_moments=pro_mom(sino,order);%get projection moments 
% pro_moments=pro_moments(:,index);
% pro_moments=pro_moments*128/2;
M=0:(order+1);
M=sum(M);
T_matrix=zeros(na*(order+1),M);%get coefficient matrix
T_matrix=get_T(theta,order);
fi_matrix=reshape(pro_moments(1:(order+1),:)',na*(order+1),1);
imag_moments=T_matrix\fi_matrix;%get image moments from projection moments
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Get projections from estimated image moments %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

es_promom=T_matrix*imag_moments;
es_promom=reshape(es_promom,na,order+1);
es_promom=es_promom';
s=-1+1/nb:2/nb:1-1/nb;
P=zeros(order+1,nb);
for i=0:order
    temp=legendre(i,s);
    P(i+1,:)=sqrt((2*i+1)/2)*temp(1,:);
end
es_sino=P'*es_promom;

% index=1;
% hold on
% plot(sino(:,index))
% % plot(L_es_sino(:,index),'k.')
% plot(es_sino(:,index),'r+')
% hold off
% legend('real','Legendre','Tchebichef')
% title('\theta=0')
% xlabel('s')
% ylabel('g(s)')
% recon=iradon(es_sino, theta1,'linear','Hamming',cutoff,imag_size);
% iptsetpref('ImshowBorder','tight')
% imshow(recon,[ ])
% error3=mse(p,recon)

