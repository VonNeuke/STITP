function []=save_data(path,data,index)
     temp_path = strcat(path,num2str(index),'.mat');
     temp_data = data ;
     save(temp_path,'temp_data');
end