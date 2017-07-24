clear;
clc;
path_population = 'F:\DHJ\课题二\population\' ;
path_out = 'F:\DHJ\课题二\Poulation_image\';
path_reg = 'F:\DHJ\课题二\registration2\' ;
num_image = 20;
name = dir(path_population);
name(1) = [];
name(1) = [];
len = length(name);
z = 1;
T =1300;
%%
%配准文件
for i = 1:len
    temp = name(i).name;
    for k = 1:2
       copyfile([path_population,temp,'\','img',int2str(k),'.mat'],[path_out,'\','img',int2str(z),'.mat'])
       copyfile([path_population,temp,'\','img',int2str(k),'_pro.mat'],[path_out,'\','img',int2str(z),'_pro.mat'])
       z = z+1;
    end   
end
%%
%配准程序
global registration;
for i = 1:num_image
   
    mkdir([path_reg,'\','registration_',num2str(i)])
    copyfile([path_out,'\','img',int2str(i),'.mat'],[path_reg,'\','registration_',num2str(i)]);
    copyfile([path_out,'\','img',int2str(i),'_pro.mat'],[path_reg,'\','registration_',num2str(i)]);
    for k = 1:num_image
%         fixed_image = load_image([path_out,'\','img',int2str(i),'_pro.mat']);
        fixed_image = load_image([path_out,'\','img',int2str(i),'.mat']);
        
        fixed_image(fixed_image<= T)=0;
        fixed_image(fixed_image> T)=255;
        
        registration.fixed = fixed_image;
        if k == i
            continue;
        end
%         moving_image = load_image([path_out,'\','img',int2str(k),'_pro.mat']);
        moving_image = load_image([path_out,'\','img',int2str(k),'.mat']);
        
        moving_image(moving_image< T)=0;
        moving_image(moving_image>= T)=255;
        
%         imshow(moving_image(:,:,12))
        
        registration.moving = moving_image;
        registration_example3d();
        transformation_matrix = registration.transformationMatrix;
%         temp_data=registration.deformed;

        temp_data = load_image([path_out,'\','img',int2str(k),'_pro.mat']);
        temp_data = affine_transformation(temp_data,transformation_matrix);
        
        temp = max(max(max(temp_data)))*0.7;
        temp_data(temp_data< temp)=0;
        temp_data(temp_data>= temp)=255;
        
        save([path_reg,'\','registration_',num2str(i),'\','img',num2str(k),'_pro.mat'],'temp_data');
        image = load_image([path_out,'\','img',int2str(k),'.mat']);
        temp_data = affine_transformation(image,transformation_matrix);
        save([path_reg,'\','registration_',num2str(i),'\','img',num2str(k),'.mat'],'temp_data');
    end
end
