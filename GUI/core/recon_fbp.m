function [sinoo,fbp_imag]=recon_fbp(I,index1)
%I ����ͼ��
%index1Ϊ����Ƕȷ�ΧΪ25��155
%sinoo �ضϵ�ͶӰ����
%fbp_imag �ض�ͶӰ���ݻָ���ͼ��
%%
process_bar = waitbar(0,'����ض�ͶӰ���ݼ���ָ�ͼ��','name','����ض�ͶӰ���ݼ���ָ�ͼ��','WindowStyle','modal'); 
I=double(I);
imag_size=size(I,1);
na=180;
theta1=0:180/na:(180-180/na);%%�����Ƕ�
% theta=theta1*pi/na;
% theta=theta';
waitbar(0.1,process_bar,'����ض�ͶӰ���ݼ���ָ�ͼ��......')
sino=radon(I,theta1);
waitbar(0.2,process_bar,'����ض�ͶӰ���ݼ���ָ�ͼ��......')
pause(1);
nb=size(sino,1);
sinoo=zeros(nb,na);
waitbar(0.3,process_bar,'����ض�ͶӰ���ݼ���ָ�ͼ��......')
pause(1);
%index1=25;%%��֪�Ƕȵķ�Χ��25��155     %�ɸ���
index2=180-index1;%�ɸ���
%theta2=index1:index2;
sinoo(:,index1:index2)=sino(:,index1:index2);%�ضϵ�ͶӰ����  sinoo
waitbar(0.4,process_bar,'����ض�ͶӰ���ݼ���ָ�ͼ��......')
pause(1);
cutoff=0.7;
waitbar(0.5,process_bar,'����ض�ͶӰ���ݼ���ָ�ͼ��......')
fbp_imag=iradon(sinoo,theta1,'linear','Hamming',cutoff,imag_size);%�ض�ͶӰ���ݻָ���ͼ��  fbp_imag
waitbar(1,process_bar,'����ض�ͶӰ���ݼ���ָ�ͼ�����......')
pause(1);
close(process_bar)
end