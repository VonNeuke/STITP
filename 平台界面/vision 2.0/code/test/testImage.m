%查看图像，并将图像旋转正
path = 'D:\commontrandata\data1\change\';
num =3 ;
silce =10 ;
for i = 1:num
image = load_image([path,'img',num2str(i),'.mat']);
temp = rot90(image(:,:,silce)) ;
subplot(1,num,i),imshow(temp,[])
end