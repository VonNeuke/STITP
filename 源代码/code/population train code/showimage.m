path_reg = 'F:\DHJ\�����\registration\registration_13\' ;
silce = 15;
for i = 1:20 
    load([path_reg,'img',num2str(i),'_pro.mat']);
    figure(i),imshow(temp_data(:,:,silce),[])
end