% function get_result_segment(path_result,path_save,name)

path_result = 'F:\DHJ\课题二\back_space_result\';
path_save = 'F:\DHJ\课题二\back_space_total_result\';
name = [7,9,13,15,20,21,22,23];

num = 20 ;    
for i = 1:length(name)
     
     for k = 1:3
         
        path_seg = [path_result,'seg_data_',num2str(1),'\','pat',num2str(name(i)),'\','result_Day',num2str(k),'.mat'];
        disp(path_seg)
        load(path_seg)
        total = zeros(size(temp_result));
        
        for j = 2:num
            path_seg = [path_result,'seg_data_',num2str(j),'\','pat',num2str(name(i)),'\','result_Day',num2str(k),'.mat']; 
            load(path_seg)
            disp(path_seg);
            total = total + temp_result;
            clear temp_result
        end
        
        total = total/num;
       disp(['create save dir:',path_save,'\','result_pat',num2str(name(i))])
        mkdir([path_save,'result_pat',num2str(name(i))])
%         total =1;
        save([path_save,'result_pat',num2str(name(i)),'\','result_Day',num2str(k),'.mat'],'total');
        disp([path_save,'result_pat',num2str(name(i)),'\','result_Day',num2str(k),'.mat']);
        temp_result = level_set_3D(total,100);
%         temp_result = 1;
        save([path_save,'result_pat',num2str(name(i)),'\','result_Day_leve_set',num2str(k),'.mat'],'temp_result');
        
     end
end
% end
