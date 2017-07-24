clear;
clc;
path_population = 'F:\DHJ\课题二\Poulation_image\' ;
path_seg = 'F:\DHJ\课题二\seg_data\';
path_reg = 'F:\DHJ\课题二\transfmatrix\' ;
num_image = 20;
name = dir(path_seg);
name(1) = [];
name(1) = [];
len = length(name);

global registration;

for i = 1:num_image
    
   
    disp(['registration：',path_population,'img',num2str(i),'.mat',' ing'])
    
    path_save = [path_reg,'registration_',num2str(i)];
    mkdir(path_save);
    
    for k = 1:len
        
        temp = name(k).name;
        path_save2 = [path_save,'\',temp];
        mkdir(path_save2)
        
        for j = 1:3
        disp('............................................................................')   
        
        registration_img = load_image([path_population,'img',num2str(i),'.mat']);
        disp(['load fixed img:',path_population,'img',num2str(i),'.mat',' ing'])
        registration.fixed = registration_img;    
        
        moving_image = load_image([path_seg,temp,'\','img',num2str(j),'.mat']);
        disp(['load moving image:',[path_seg,temp,'\','img',num2str(j),'.mat'],'  ing'])
        
        registration.moving = moving_image;
        registration_example3d();
%         transformation_matrix = registration.transformationMatrix;
        temp_data = registration.transformationMatrix;
        temp_data = inv(temp_data);
        save([path_save2,'\','matrix',num2str(j),'.mat'],'temp_data');
        disp(['save matrix imge:',path_save2,'\','matrix',num2str(j),'.mat'])
        
%         temp_data = registration.deformed;
        
%         save([path_save2,'\','img',num2str(j),'.mat'],'temp_data');
%         disp(['save model imge:',path_save2,'\','img',num2str(j),'.mat'])
%         model = load_image([path_seg,temp,'\','img',num2str(j),'_pro.mat']);
%         disp(['load groundtruth:',[path_seg,temp,'\','img',num2str(j),'_pro.mat'],'  ing'])
%         
%         temp_data = affine_transformation(model,transformation_matrix);
%         save([path_save2,'\','img',num2str(j),'_pro.mat'],'temp_data');
%            disp(['save model imge:',path_save2,'\','img',num2str(j),'_pro.mat'])
        disp('............................................................................')
        end
        
    end
end