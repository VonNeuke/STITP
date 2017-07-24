function result=mse(image,recon)
temp=image-recon;
temp=temp.^2;
temp=sum(sum(temp));
temp1=image.^2;
temp1=sum(sum(temp1));
result=temp/temp1;