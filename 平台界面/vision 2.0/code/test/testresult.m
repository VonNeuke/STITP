%�Ƚ���ʵֵ�ͷָ�ֵ���ó�diceֵ
clear ,clc ,clear all
path_model = 'L:\����һ(Online updata �Ѿ����)\matachdata2\pat20\'; %'L:\����һ(Online updata �Ѿ����)\level_result\pat20\';
path_result = 'L:\����һ(Online updata �Ѿ����)\level_result\pat20\';
num_result = length(dir(fullfile(path_result,'*.mat')));
value = ones(1,3);
scilce = [];
for i = 1 : num_result
    disp('-----------------------�ָ���---------------------------------')
    temp_path = strcat(path_model,'img',num2str(i+3),'_pro.mat');
    model = load_image(temp_path);
    %model = set_roi(model,80,80,25);
    
    
    for k = 1 : size(model,3)
        temp = model(:,:,k);
        if ~isempty(find(temp == 255))
            scilce = [scilce,k];
        end      
    end
    model = model(:,:,scilce);



    disp(temp_path)
    temp_path = strcat(path_result,'result_Day',num2str(i),'.mat');
    load(temp_path);
    
    temp_result=temp_result(:,:,scilce);

    disp(temp_path)
    T = max(max(max(temp_result)))*0.8
    scilce = [];
    value(i) = dice(temp_result,model,T);
   % clear temp_result
end
disp('�����')
value
mean(value)
% x = 1 : num_result;
% 
% plot(x,value,'-r','linewidth',3)
% xlim([0 10]);
% ylim([0 1]);
% hold on
% 
% xlabel('���Ƶ�����')
% ylabel('Diceֵ')
% 
% title('pat10 �ķָ�����sample = 1000 numtree = 500��')
% plot(x,value,'.b')
% hold off