path_result = 'F:\DHJ\课题二\result\';
path_model = 'F:\DHJ\课题二\model\';
path_img = 'F:\DHJ\课题二\seg_data\';
name = dir(path_img);
name(1) = [];
name(1) = [];

num_model = 5;
num_seg = 3 ;

for i = 1:num_model
    if ~exist([path_result,'seg_data_',num2str(i)],'dir')
       mkdir([path_result,'seg_data_',num2str(i)]);
    end
    %load([path_model,'pouplation_model_',num2str(i),'.mat'])
    
    for j =1 :length(name)
        temp = name(j).name;
        if ~exist([path_result,'seg_data_',num2str(i),'\','result_',temp],'dir')
          mkdir([path_result,'seg_data_',num2str(i),'\','result_',temp]);
        end
        
        for k = 1:num_seg
            image = load_image([path_img,temp,'\','img',int2str(k),'.mat']);
            disp('segment beginning...')
            disp(['分割',path_img,temp,'\','img',int2str(k),'.mat','中......'])
            
            if ~exist([path_result,'seg_data_',num2str(i),'\','result_',temp,'\','result_Day',num2str(k),'.mat'],'file')
                %[temp_result, ~, ~] = predict_auto_context(image,model);
%               temp_result= 1;
%                save([path_result,'seg_data_',num2str(i),'\','result_',temp,'\','result_Day',num2str(k),'.mat'],'temp_result');
                disp([path_result,'seg_data_',num2str(i),'\','result_',temp,'\','result_Day',num2str(k),'.mat'])
                clear temp_result
            end
        end
    end
    clear model
end