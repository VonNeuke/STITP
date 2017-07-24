%测试图像采样点，看看每个图像可承受的最大采样点
clear
path = 'I:\changedata\pat15\';
sample = 8000;
num = 10;
for i = 1:num
    i
    image = load_image([path,'img',num2str(i),'.mat']);
    model = load_image([path,'img',num2str(i),'_pro.mat']);
    sample_pos(model,image,sample); 
end
