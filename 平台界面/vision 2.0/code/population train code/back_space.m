%把图形配准回原来的空间
clear 
clc
path_matrix = 'F:\DHJ\课题二\transfmatrix\' ;
path_image = 'L:\课题二(population image)\mutil-task-reuslt\result\';
path_out_image = 'F:\DHJ\课题二\back_space_result\';
num = 20;
name = [1,6,7,9,13,15,20,21,22,23];
% for i = 1: num
%     path_dir = [path_out_image,'\','seg_data_',num2str(i)];
%     mkdir([path_out_image,'\','seg_data_',num2str(i)])
%     disp(['make dir:',path_dir])
%     path_dir = [path_matrix,'\','registration_',num2str(i)];
% %     disp(['get matrix dir:',path_dir])
%     for k = 1:10
%     disp('..............................................................................')
%         for j = 1:3
%             path_matrixdata = [path_dir,'\','pat',num2str(name(k)),'\','matrix',num2str(j),'.mat'];
%             disp(['load matrix :',path_matrixdata])
%             load(path_matrixdata);
%             matrix = temp_data;
%             clear temp_data
%             
%             
%             path_imgdata = [path_image,'\','seg_data_',num2str(i),'\',...
%                 'pat',num2str(name(k)),'\','result_Day',num2str(j),'.mat'];
%             disp(['load Img :',path_imgdata])
%             load(path_imgdata)
%             Img = temp_result;
%             clear temp_result
%             
%             temp_result = affine_transformation(Img,matrix);
%             path_resultdata = [path_out_image,'\','seg_data_',num2str(i),'\',...
%                 'pat',num2str(name(k)),'\'];
%             if ~exist(path_resultdata,'dir')
%                 mkdir(path_resultdata);
%             end
%             path_resultdata = [path_resultdata,'result_Day',num2str(j),'.mat'];
%             disp(['save Img :',path_resultdata])
%             save(path_resultdata,'temp_result')
%              disp('..............................................................................')
%         end
%     end
% end
path_save='F:\DHJ\课题二\back_space_total_result\';
get_result_segment(path_out_image,path_save,name)