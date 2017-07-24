function [sinoo,fbp_imag]=recon_fbp(I,index1)
%I 输入图像
%index1为输入角度范围为25～155
%sinoo 截断的投影数据
%fbp_imag 截断投影数据恢复的图像
%%
process_bar = waitbar(0,'计算截断投影数据及其恢复图像','name','计算截断投影数据及其恢复图像','WindowStyle','modal'); 
I=double(I);
imag_size=size(I,1);
na=180;
theta1=0:180/na:(180-180/na);%%产生角度
% theta=theta1*pi/na;
% theta=theta';
waitbar(0.1,process_bar,'计算截断投影数据及其恢复图像......')
sino=radon(I,theta1);
waitbar(0.2,process_bar,'计算截断投影数据及其恢复图像......')
pause(1);
nb=size(sino,1);
sinoo=zeros(nb,na);
waitbar(0.3,process_bar,'计算截断投影数据及其恢复图像......')
pause(1);
%index1=25;%%所知角度的范围：25～155     %可改项
index2=180-index1;%可改项
%theta2=index1:index2;
sinoo(:,index1:index2)=sino(:,index1:index2);%截断的投影数据  sinoo
waitbar(0.4,process_bar,'计算截断投影数据及其恢复图像......')
pause(1);
cutoff=0.7;
waitbar(0.5,process_bar,'计算截断投影数据及其恢复图像......')
fbp_imag=iradon(sinoo,theta1,'linear','Hamming',cutoff,imag_size);%截断投影数据恢复的图像  fbp_imag
waitbar(1,process_bar,'计算截断投影数据及其恢复图像完成......')
pause(1);
close(process_bar)
end