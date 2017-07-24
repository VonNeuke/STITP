path_result = 'F:\DHJ\课题二\back_space_result\';
path_model =  'F:\DHJ\课题二\seg_data\';


% path_resutl = 'F:\DHJ\课题二\seg_match_data\';
% path_model='F:\DHJ\课题二\population\';
name = 7;
num = 2;
day = 1;
slice = 5;
%%
%show  registration of seg data
for i = 1:20
   path_seg = [path_result,'seg_data_',num2str(i),'\','pat',num2str(name),'\','result_Day',num2str(day),'.mat'];
%    path_seg = [path_resutl,'registration_',num2str(i),'\','pat',num2str(name),'\','img',num2str(num),'_pro.mat'];
%     path_seg = [path_resutl,'registration_',num2str(i),'\','pat',num2str(name),'\','img',num2str(num),'.mat'];
    load(path_seg)
    subplot(4,5,i),imshow(temp_result(:,:,slice),[],'Border','tight');
%     subplot(4,5,i),imshow(temp_data(:,:,slice),[],'Border','tight');
end
% load([path_model,'pat',num2str(11),'\','img',num2str(day),'.mat']);
% figure,imshow(temp_data(:,:,slice),[],'Border','tight');

%%
%show  registration of train data
% path_resutl = 'F:\DHJ\课题二\registration2\';
% num = 4;
% slice = 15;
% for i = 1:15
% %    path_seg = [path_result,'seg_data_',num2str(i),'\','result_pat',num2str(name),'\','result_Day',num2str(day),'.mat'];
% %    path_seg = [path_resutl,'registration_',num2str(i),'\','img',num2str(num),'_pro.mat'];
%     path_seg = [path_resutl,'registration_',num2str(i),'\','img',num2str(num),'.mat'];
%     load(path_seg)
%     subplot(4,5,i),imshow(temp_data(:,:,slice),[],'Border','tight');
% end