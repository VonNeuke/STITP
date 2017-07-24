clc;
%clear;
path_population = 'F:\DHJ\课题二\seg_data\' ;
path_result = 'F:\DHJ\课题二\result_population\';
path_model = 'F:\DHJ\课题二\model\model_important（sample=8000 pat=8）.mat';
name = dir(path_population);
name(1) = [];
name(1) = [];
num_seg = 9 ;
len = length(name);

%load(path_model)
for i = 1:len
    temp = name(i).name;
    mkdir([path_result,'result_',temp]);
    
    for k = 1:num_seg
    %disp([path_population,temp,'\','img',int2str(k),'.mat'])
    image = load_image([path_population,temp,'\','img',int2str(k),'.mat']);
    disp('segment beginning...')
    disp(['分割',path_population,temp,'\','img',int2str(k),'.mat','中......'])
    if ~exist([path_result,'result_',temp,'\','result_Day',num2str(k),'.mat'],'file')
        [temp_result, a, b] = predict_auto_context(image,model);
        clear a b
        save([path_result,'result_',temp,'\','result_Day',num2str(k),'.mat'],'temp_result');
        clear temp_result
    end
    %temp_result = level_set_3D(temp_result,100);
    
    disp('segment over...')
    %disp([path_result,'result_',temp,'\','result_Img',num2str(k),'.mat'])
    
    
    clear temp_result
    end
end