%获取population images集合，内有context features 、haar features、pos和label
path_population = 'D:\data\patdata\' ;
path_out = 'D:\data\population\';
n_sample = 8000;
name = dir(path_population);
name(1) = [];
name(1) = [];
len = length(name);
for i = 1:len
    temp = name(i).name;
    mkdir([path_out,temp]);
    disp(['抽取',temp,'中......'])
    for k = 1:2
        image = load_image([path_population,temp,'\','img',int2str(k),'.mat']);
        label_image = load_image([path_population,temp,'\','img',int2str(k),'_pro.mat']);
        all_pos = get_allpos(image);
        %if ~exist([path_out,temp,'\','pos',int2str(k),'.mat'],'file')&&~exist([path_out,temp,'\','label',int2str(k),'.mat'],'file')
            [temp_pos,temp_label] = sample_pos(label_image,image,n_sample,'index');
            temp_data = temp_pos;
            save([path_out,temp,'\','pos',int2str(k),'.mat'],'temp_data');
            clear temp_pos temp_data
            temp_data = temp_label;
            save([path_out,temp,'\','label',int2str(k),'.mat'],'temp_data');
            clear temp_label temp_data
        %end
        
        if ~exist([path_out,temp,'\','context',int2str(k),'.mat'],'file')
            temp_context_feature = cal_context_features( image , all_pos );
            temp_data = temp_context_feature;
            save([path_out,temp,'\','context',int2str(k),'.mat'],'temp_data');
            clear temp_context_feature temp_data
        end

        if ~exist([path_out,temp,'\','haar',int2str(k),'.mat'],'file')
                temp_haar_feature = cal_haar_features_3D( image , all_pos );
                temp_data = temp_haar_feature;
                save([path_out,temp,'\','haar',int2str(k),'.mat'],'temp_data');
                clear temp_haar_feature temp_data
        end
    end
end