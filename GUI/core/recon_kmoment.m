function [es_sino,recon] = recon_kmoment(sinoo,order,index1,imag_size)
%sinoo 截断的投影数据
%es_sino 估计出来的投影数据
%recon 估计数据恢复的图像
% Image moments estimated from limited projection moments
na=180;
cutoff=0.7;
theta1=0:180/na:(180-180/na);%%产生角度
theta=theta1*pi/na;
theta=theta';
nb=size(sinoo,1);
index2=180-index1;

process_bar = waitbar(0,'计算K矩估计投影','name','计算K矩估计投影','WindowStyle','modal'); 
waitbar(0,process_bar,'计算未知角度对应的系数矩阵......')%['已经完成',num2str(round(100*5/order+5)),'%'])
Known_theta=theta(index1:index2);
new_na=size(Known_theta,1);
Known_sino=sinoo(:,index1:index2);
pro_moments=pro_mom(Known_sino,order);%计算所知角度的投影矩
waitbar(0.1,process_bar,'计算未知角度对应的系数矩阵......')%['已经完成',num2str(round(100*5/order+5)),'%'])

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
waitbar(0.2,process_bar,'计算未知角度对应的系数矩阵......')%['已经完成',num2str(round(100*5/order+5)),'%'])
T_matrix1=get_T(Unknown_theta1,order);
T_matrix2=get_T(Unknown_theta2,order);
waitbar(0.3,process_bar,'计算未知角度对应的系数矩阵完成......')%['已经完成',num2str(round(100*5/order+5)),'%'])
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
    waitbar(0.3+0.7*i/order,process_bar,['已经完成',num2str(round(100*(0.3+0.7*i/order))),'%'])
    pause(1);
end
close(process_bar);
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
end