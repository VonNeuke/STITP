function [es_sino,recon] = recon_kmoment(sinoo,order,index1,imag_size)
%sinoo �ضϵ�ͶӰ����
%es_sino ���Ƴ�����ͶӰ����
%recon �������ݻָ���ͼ��
% Image moments estimated from limited projection moments
na=180;
cutoff=0.7;
theta1=0:180/na:(180-180/na);%%�����Ƕ�
theta=theta1*pi/na;
theta=theta';
nb=size(sinoo,1);
index2=180-index1;

process_bar = waitbar(0,'����K�ع���ͶӰ','name','����K�ع���ͶӰ','WindowStyle','modal'); 
waitbar(0,process_bar,'����δ֪�Ƕȶ�Ӧ��ϵ������......')%['�Ѿ����',num2str(round(100*5/order+5)),'%'])
Known_theta=theta(index1:index2);
new_na=size(Known_theta,1);
Known_sino=sinoo(:,index1:index2);
pro_moments=pro_mom(Known_sino,order);%������֪�Ƕȵ�ͶӰ��
waitbar(0.1,process_bar,'����δ֪�Ƕȶ�Ӧ��ϵ������......')%['�Ѿ����',num2str(round(100*5/order+5)),'%'])

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
waitbar(0.2,process_bar,'����δ֪�Ƕȶ�Ӧ��ϵ������......')%['�Ѿ����',num2str(round(100*5/order+5)),'%'])
T_matrix1=get_T(Unknown_theta1,order);
T_matrix2=get_T(Unknown_theta2,order);
waitbar(0.3,process_bar,'����δ֪�Ƕȶ�Ӧ��ϵ���������......')%['�Ѿ����',num2str(round(100*5/order+5)),'%'])
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
    waitbar(0.3+0.7*i/order,process_bar,['�Ѿ����',num2str(round(100*(0.3+0.7*i/order))),'%'])
    pause(1);
end
close(process_bar);
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
end