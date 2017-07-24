function haar_features=cal_haar_features_3D(image, points,num)
%points可是设置多个点数
%方法为【1 3 4； 123 32 53】这个就设置了两个点
%num为范围为1-18
haar_pattern=cell(0);
if exist('num','var')
    scale_haar=[8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8];
else
    scale_haar=[8 8 8 8 8 8 8 10 10 9 4 4 5 3 5 3 3 3];
end
%---------------
for k=1:scale_haar(1)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-1 -(k+1) -1;0 0 1;-1 0 -1;0 (k+1) 1];%% [1 1]means 1 positive pattern and 1 negative pattern
end
for k=1:scale_haar(2)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-(k+1) -1 -1;0 0 1;0 -1 -1;(k+1) 0 1];
end
for k=1:scale_haar(3)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-(k+1) -1 -1;(k+1) 0 1;-1 -(k+1) -1;0 (k+1) 1];
end
for k=1:scale_haar(4)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-1 -1 -1;0 0 1;-(k+1) -1 -1;-k 0 1];
end
for k=1:scale_haar(5)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-1 -1 -1;0 0 1;k -1 -1;(k+1) 0 1];
end
for k=1:scale_haar(6)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-1 -1 -1;0 0 1;-1 -(k+1) -1;0 -k 1];
end
for k=1:scale_haar(7)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-1 -1 -1;0 0 1;-1 k -1;0 k+1 1];
end


%---------------
for k=1:scale_haar(8)
    haar_pattern{length(haar_pattern)+1}=[1 0 0;-k -k -1;k k 1];%% [1 0]means 1 positive pattern and 0 negative pattern
    
    %hold on;
    
    %plot_rectangle_lw(haar_pattern{k}(2,:)+11,haar_pattern{k}(3,:)+11,'r-');%for test
end
%hold off;
%clf(h);
%pattern for diagonal
%subplot(2,6,2);
%h=figure;
%imshow(im_test,[]);%for test
for k=1:scale_haar(9)
    haar_pattern{length(haar_pattern)+1}=[2 2 0;-k -k -1;0 0 1;0 0 -1;k k 1;0 -k -1;k 0 1;-k 0 -1;0 k 1];%% [2 2]means 2 positive pattern and 2 negative pattern
    %[2 2] indicates first 2 retangles are positive and last 2 retangles
    %are negative.
    %{
    hold on;
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(2,:)+11,haar_pattern{length(haar_pattern)}(3,:)+11,'r-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(4,:)+11,haar_pattern{length(haar_pattern)}(5,:)+11,'r-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(6,:)+11,haar_pattern{length(haar_pattern)}(7,:)+11,'g-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(8,:)+11,haar_pattern{length(haar_pattern)}(9,:)+11,'g-');%for test
    %}
end
%hold off;
%clf(h);
%pattern for
%subplot(2,6,3);
%h=figure;
%imshow(im_test,[]);%for test
for k=1:scale_haar(10)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-k -k -1;k k 1;-10 -10 -1;10 10 1];
    %{
    hold on;
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(2,:)+11,haar_pattern{length(haar_pattern)}(3,:)+11,'r-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(4,:)+11,haar_pattern{length(haar_pattern)}(5,:)+11,'g-');%for test
    %}
end
%hold off;
%clf(h);
%pattern for
%subplot(2,6,4);
%h=figure;
%imshow(im_test,[]);%for test
for k=1:scale_haar(11)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-2*k -k -1;2*k k 1;-10 -5 -1;10 5 1];
    %{
    hold on;
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(2,:)+11,haar_pattern{length(haar_pattern)}(3,:)+11,'r-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(4,:)+11,haar_pattern{length(haar_pattern)}(5,:)+11,'g-');%for test
    %}
end
%hold off;
%clf(h);
%pattern for
%subplot(2,6,5);
%h=figure;
%imshow(im_test,[]);%for test
for k=1:scale_haar(12)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-k -2*k -1;k 2*k 1;-5 -10 -1;5 10 1];
    %{
    hold on;
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(2,:)+11,haar_pattern{length(haar_pattern)}(3,:)+11,'r-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(4,:)+11,haar_pattern{length(haar_pattern)}(5,:)+11,'g-');%for test
    %}
end
%hold off;
%clf(h);
%pattern for
%subplot(2,6,6);
%h=figure;
%imshow(im_test,[]);%for test
for k=1:scale_haar(13)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-2*k -k -1;2*k 0 1;-2*k 0 -1;2*k k 1];
    %{
    hold on;
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(2,:)+11,haar_pattern{length(haar_pattern)}(3,:)+11,'r-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(4,:)+11,haar_pattern{length(haar_pattern)}(5,:)+11,'g-');%for test
    %}
end
%hold off;
%clf(h);
%pattern for
%subplot(2,6,7);
%h=figure;
%imshow(im_test,[]);%for test
for k=1:scale_haar(14)
    haar_pattern{length(haar_pattern)+1}=[1 2 0;-2*k -k -1;2*k k 1;-2*k -3*k -1;2*k -k 1;-2*k k -1;2*k 3*k 1];%% [1 2]means 1 positive pattern and 2 negative pattern
    %{
    hold on;
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(2,:)+11,haar_pattern{length(haar_pattern)}(3,:)+11,'r-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(4,:)+11,haar_pattern{length(haar_pattern)}(5,:)+11,'g-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(6,:)+11,haar_pattern{length(haar_pattern)}(7,:)+11,'g-');%for test
    %}
end
%hold off;
%clf(h);
%pattern for
%subplot(2,6,8);
%h=figure;
%imshow(im_test,[]);%for test
for k=1:scale_haar(15)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-k -2*k -1;0 2*k 1;0 -2*k -1;k 2*k 1];
    %{
    hold on;
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(2,:)+11,haar_pattern{length(haar_pattern)}(3,:)+11,'r-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(4,:)+11,haar_pattern{length(haar_pattern)}(5,:)+11,'g-');%for test
    %}
end
%hold off;
%clf(h);
%pattern for
%subplot(2,6,9);
%h=figure;
%imshow(im_test,[]);%for test
for k=1:scale_haar(16)
    haar_pattern{length(haar_pattern)+1}=[1 2 0;-k -2*k -1;k 2*k 1;-3*k -2*k -1;-k 2*k 1;k -2*k -1;3*k 2*k 1];
    %{
    hold on;
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(2,:)+11,haar_pattern{length(haar_pattern)}(3,:)+11,'r-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(4,:)+11,haar_pattern{length(haar_pattern)}(5,:)+11,'g-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(6,:)+11,haar_pattern{length(haar_pattern)}(7,:)+11,'g-');%for test
    %}
end
%hold off;
%clf(h);
%pattern for
%subplot(2,6,10);
%h=figure;
%imshow(im_test,[]);%for test
for k=1:scale_haar(17)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-2*k -2*k -1;-k 2*k 1;k -2*k -1;2*k 2*k 1];
    %{
    hold on;
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(2,:)+11,haar_pattern{length(haar_pattern)}(3,:)+11,'r-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(4,:)+11,haar_pattern{length(haar_pattern)}(5,:)+11,'g-');%for test
    %}
end
%hold off;
%clf(h);
%pattern for
%subplot(2,6,11);
%h=figure;
%imshow(im_test,[]);%for test
for k=1:scale_haar(18)
    haar_pattern{length(haar_pattern)+1}=[1 1 0;-2*k -2*k -1;2*k -k 1;-2*k k -1;2*k 2*k 1];
    %{
    hold on;
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(2,:)+11,haar_pattern{length(haar_pattern)}(3,:)+11,'r-');%for test
    plot_rectangle_lw(haar_pattern{length(haar_pattern)}(4,:)+11,haar_pattern{length(haar_pattern)}(5,:)+11,'g-');%for test
    %}
end

%%
%添加部分
if exist('num','var')
    temp= num*8;
    haar_pattern = {haar_pattern{temp-7:temp}};
end
%hold off;
%clf(h);
%close(handle_f);
patch_size = [21 21];
num_pix_patch = prod(patch_size);
num_haar_features = length(haar_pattern);
%num_haar_features = 18;
% haar=zeros(size(points,1),num_haar_features);
size_image = size(image);%计算图像尺寸

%the haar pattern construction is completed.
%the begining of calculate the haar features
ii_im = cumsum(cumsum(cumsum(image,3),2));%the integral volume计算积分图

num_points = size(points,1);
haar_positive = zeros(num_points,1);
haar_negative = zeros(num_points,1);

for k = 1:num_haar_features%生成白块
    for j = 1:haar_pattern{k}(1,1)
        left_top_high = [points(:,1)+haar_pattern{k}(j*2,1) points(:,2)+haar_pattern{k}(j*2+1,2) points(:,3)+haar_pattern{k}(j*2,3)];
        left_top_high(:,1) = max(1,left_top_high(:,1));left_top_high(:,1)=min(size_image(1),left_top_high(:,1));%防止超出图像的边界，把图像范围设置在【1-X】
        left_top_high(:,2) = max(1,left_top_high(:,2));left_top_high(:,2)=min(size_image(2),left_top_high(:,2));%把图像范围设置在【1-Y】
        left_top_high(:,3) = max(1,left_top_high(:,3));left_top_high(:,3)=min(size_image(3),left_top_high(:,3));%把图像范围设置在【1-Z】
        
        left_top_low = [points(:,1)+haar_pattern{k}(j*2,1) points(:,2)+haar_pattern{k}(j*2+1,2) points(:,3)+haar_pattern{k}(j*2+1,3)];
        left_top_low(:,1) = max(1,left_top_low(:,1));left_top_low(:,1)=min(size_image(1),left_top_low(:,1));
        left_top_low(:,2) = max(1,left_top_low(:,2));left_top_low(:,2)=min(size_image(2),left_top_low(:,2));
        left_top_low(:,3) = max(1,left_top_low(:,3));left_top_low(:,3)=min(size_image(3),left_top_low(:,3));
        
        right_bottom_high = [points(:,1)+haar_pattern{k}(j*2+1,1) points(:,2)+haar_pattern{k}(j*2,2) points(:,3)+haar_pattern{k}(j*2,3)];
        right_bottom_high(:,1) = max(1,right_bottom_high(:,1));right_bottom_high(:,1)=min(size_image(1),right_bottom_high(:,1));
        right_bottom_high(:,2) = max(1,right_bottom_high(:,2));right_bottom_high(:,2)=min(size_image(2),right_bottom_high(:,2));
        right_bottom_high(:,3) = max(1,right_bottom_high(:,3));right_bottom_high(:,3)=min(size_image(3),right_bottom_high(:,3));
        
        right_bottom_low = [points(:,1)+haar_pattern{k}(j*2+1,1) points(:,2)+haar_pattern{k}(j*2,2) points(:,3)+haar_pattern{k}(j*2+1,3)];
        right_bottom_low(:,1) = max(1,right_bottom_low(:,1));right_bottom_low(:,1)=min(size_image(1),right_bottom_low(:,1));
        right_bottom_low(:,2) = max(1,right_bottom_low(:,2));right_bottom_low(:,2)=min(size_image(2),right_bottom_low(:,2));
        right_bottom_low(:,3) = max(1,right_bottom_low(:,3));right_bottom_low(:,3)=min(size_image(3),right_bottom_low(:,3));
        
        left_bottom_high = [points(:,1)+haar_pattern{k}(j*2,1) points(:,2)+haar_pattern{k}(j*2,2) points(:,3)+haar_pattern{k}(j*2,3)];
        left_bottom_high(:,1) = max(1,left_bottom_high(:,1));left_bottom_high(:,1)=min(size_image(1),left_bottom_high(:,1));
        left_bottom_high(:,2) = max(1,left_bottom_high(:,2));left_bottom_high(:,2)=min(size_image(2),left_bottom_high(:,2));
        left_bottom_high(:,3) = max(1,left_bottom_high(:,3));left_bottom_high(:,3)=min(size_image(3),left_bottom_high(:,3));
        
        
        left_bottom_low = [points(:,1)+haar_pattern{k}(j*2,1) points(:,2)+haar_pattern{k}(j*2,2) points(:,3)+haar_pattern{k}(j*2+1,3)];
        left_bottom_low(:,1) = max(1,left_bottom_low(:,1));left_bottom_low(:,1)=min(size_image(1),left_bottom_low(:,1));
        left_bottom_low(:,2) = max(1,left_bottom_low(:,2));left_bottom_low(:,2)=min(size_image(2),left_bottom_low(:,2));
        left_bottom_low(:,3) = max(1,left_bottom_low(:,3));left_bottom_low(:,3)=min(size_image(3),left_bottom_low(:,3));
        
        right_top_high = [points(:,1)+haar_pattern{k}(j*2+1,1) points(:,2)+haar_pattern{k}(j*2+1,2) points(:,3)+haar_pattern{k}(j*2,3)];
        right_top_high(:,1) = max(1,right_top_high(:,1));right_top_high(:,1)=min(size_image(1),right_top_high(:,1));
        right_top_high(:,2) = max(1,right_top_high(:,2));right_top_high(:,2)=min(size_image(2),right_top_high(:,2));
        right_top_high(:,3) = max(1,right_top_high(:,3));right_top_high(:,3)=min(size_image(3),right_top_high(:,3));
        
        right_top_low = [points(:,1)+haar_pattern{k}(j*2+1,1) points(:,2)+haar_pattern{k}(j*2+1,2) points(:,3)+haar_pattern{k}(j*2+1,3)];
        right_top_low(:,1) = max(1,right_top_low(:,1));right_top_low(:,1)=min(size_image(1),right_top_low(:,1));
        right_top_low(:,2) = max(1,right_top_low(:,2));right_top_low(:,2)=min(size_image(2),right_top_low(:,2));
        right_top_low(:,3) = max(1,right_top_low(:,3));right_top_low(:,3)=min(size_image(3),right_top_low(:,3));
        
        haar_positive = haar_positive + ii_im(sub2ind(size_image,right_top_low(:,1),right_top_low(:,2),right_top_low(:,3)))...
                                      + ii_im(sub2ind(size_image,left_bottom_low(:,1),left_bottom_low(:,2),left_bottom_low(:,3)))...
                                      + ii_im(sub2ind(size_image,right_bottom_high(:,1),right_bottom_high(:,2),right_bottom_high(:,3)))...
                                      + ii_im(sub2ind(size_image,left_top_high(:,1),left_top_high(:,2),left_top_high(:,3)))...
                                      - ii_im(sub2ind(size_image,left_top_low(:,1),left_top_low(:,2),left_top_low(:,3)))...
                                      - ii_im(sub2ind(size_image,right_bottom_low(:,1),right_bottom_low(:,2),right_bottom_low(:,3)))...
                                      - ii_im(sub2ind(size_image,right_top_high(:,1),right_top_high(:,2),right_top_high(:,3)))...
                                      - ii_im(sub2ind(size_image,left_bottom_high(:,1),left_bottom_high(:,2),left_bottom_high(:,3)));
    end
    for i = 1:haar_pattern{k}(1,2)%生成黑块
        t = haar_pattern{k}(1,1)*2;
        left_top_high = [points(:,1)+haar_pattern{k}(i*2+t,1) points(:,2)+haar_pattern{k}(i*2+t+1,2) points(:,3)+haar_pattern{k}(i*2+t,3)];
        left_top_high(:,1) = max(1,left_top_high(:,1));left_top_high(:,1)=min(size_image(1),left_top_high(:,1));
        left_top_high(:,2) = max(1,left_top_high(:,2));left_top_high(:,2)=min(size_image(2),left_top_high(:,2));
        left_top_high(:,3) = max(1,left_top_high(:,3));left_top_high(:,3)=min(size_image(3),left_top_high(:,3));
        
        left_top_low = [points(:,1)+haar_pattern{k}(i*2+t,1) points(:,2)+haar_pattern{k}(i*2+t+1,2) points(:,3)+haar_pattern{k}(i*2+t+1,3)];
        left_top_low(:,1) = max(1,left_top_low(:,1));left_top_low(:,1)=min(size_image(1),left_top_low(:,1));
        left_top_low(:,2) = max(1,left_top_low(:,2));left_top_low(:,2)=min(size_image(2),left_top_low(:,2));
        left_top_low(:,3) = max(1,left_top_low(:,3));left_top_low(:,3)=min(size_image(3),left_top_low(:,3));
        
        right_bottom_high = [points(:,1)+haar_pattern{k}(i*2+t+1,1) points(:,2)+haar_pattern{k}(i*2+t,2) points(:,3)+haar_pattern{k}(i*2+t,3)];
        right_bottom_high(:,1) = max(1,right_bottom_high(:,1));right_bottom_high(:,1)=min(size_image(1),right_bottom_high(:,1));
        right_bottom_high(:,2) = max(1,right_bottom_high(:,2));right_bottom_high(:,2)=min(size_image(2),right_bottom_high(:,2));
        right_bottom_high(:,3) = max(1,right_bottom_high(:,3));right_bottom_high(:,3)=min(size_image(3),right_bottom_high(:,3));
        
        right_bottom_low = [points(:,1)+haar_pattern{k}(i*2+t+1,1) points(:,2)+haar_pattern{k}(i*2+t,2) points(:,3)+haar_pattern{k}(i*2+t+1,3)];
        right_bottom_low(:,1) = max(1,right_bottom_low(:,1));right_bottom_low(:,1)=min(size_image(1),right_bottom_low(:,1));
        right_bottom_low(:,2) = max(1,right_bottom_low(:,2));right_bottom_low(:,2)=min(size_image(2),right_bottom_low(:,2));
        right_bottom_low(:,3) = max(1,right_bottom_low(:,3));right_bottom_low(:,3)=min(size_image(3),right_bottom_low(:,3));
        
        left_bottom_high = [points(:,1)+haar_pattern{k}(i*2+t,1) points(:,2)+haar_pattern{k}(i*2+t,2) points(:,3)+haar_pattern{k}(i*2+t,3)];
        left_bottom_high(:,1) = max(1,left_bottom_high(:,1));left_bottom_high(:,1)=min(size_image(1),left_bottom_high(:,1));
        left_bottom_high(:,2) = max(1,left_bottom_high(:,2));left_bottom_high(:,2)=min(size_image(2),left_bottom_high(:,2));
        left_bottom_high(:,3) = max(1,left_bottom_high(:,3));left_bottom_high(:,3)=min(size_image(3),left_bottom_high(:,3));
        
        left_bottom_low = [points(:,1)+haar_pattern{k}(i*2+t,1) points(:,2)+haar_pattern{k}(i*2+t,2) points(:,3)+haar_pattern{k}(i*2+t+1,3)];
        left_bottom_low(:,1) = max(1,left_bottom_low(:,1));left_bottom_low(:,1)=min(size_image(1),left_bottom_low(:,1));
        left_bottom_low(:,2) = max(1,left_bottom_low(:,2));left_bottom_low(:,2)=min(size_image(2),left_bottom_low(:,2));
        left_bottom_low(:,3) = max(1,left_bottom_low(:,3));left_bottom_low(:,3)=min(size_image(3),left_bottom_low(:,3));
        
        right_top_high = [points(:,1)+haar_pattern{k}(i*2+t+1,1) points(:,2)+haar_pattern{k}(i*2+t+1,2) points(:,3)+haar_pattern{k}(i*2+t,3)];
        right_top_high(:,1) = max(1,right_top_high(:,1));right_top_high(:,1)=min(size_image(1),right_top_high(:,1));
        right_top_high(:,2) = max(1,right_top_high(:,2));right_top_high(:,2)=min(size_image(2),right_top_high(:,2));
        right_top_high(:,3) = max(1,right_top_high(:,3));right_top_high(:,3)=min(size_image(3),right_top_high(:,3));
        
        right_top_low = [points(:,1)+haar_pattern{k}(i*2+t+1,1) points(:,2)+haar_pattern{k}(i*2+t+1,2) points(:,3)+haar_pattern{k}(i*2+t+1,3)];
        right_top_low(:,1) = max(1,right_top_low(:,1));right_top_low(:,1)=min(size_image(1),right_top_low(:,1));
        right_top_low(:,2) = max(1,right_top_low(:,2));right_top_low(:,2)=min(size_image(2),right_top_low(:,2));
        right_top_low(:,3) = max(1,right_top_low(:,3));right_top_low(:,3)=min(size_image(3),right_top_low(:,3));
        
        haar_negative = haar_negative + ii_im(sub2ind(size_image,right_top_low(:,1),right_top_low(:,2),right_top_low(:,3)))...
                                      + ii_im(sub2ind(size_image,left_bottom_low(:,1),left_bottom_low(:,2),left_bottom_low(:,3)))...
                                      + ii_im(sub2ind(size_image,right_bottom_high(:,1),right_bottom_high(:,2),right_bottom_high(:,3)))...
                                      + ii_im(sub2ind(size_image,left_top_high(:,1),left_top_high(:,2),left_top_high(:,3)))...
                                      - ii_im(sub2ind(size_image,left_top_low(:,1),left_top_low(:,2),left_top_low(:,3)))...
                                      - ii_im(sub2ind(size_image,right_bottom_low(:,1),right_bottom_low(:,2),right_bottom_low(:,3)))...
                                      - ii_im(sub2ind(size_image,right_top_high(:,1),right_top_high(:,2),right_top_high(:,3)))...
                                      - ii_im(sub2ind(size_image,left_bottom_high(:,1),left_bottom_high(:,2),left_bottom_high(:,3)));
    end
    haar_features(:,k) =(haar_positive-haar_negative)/num_pix_patch;
    haar_positive = zeros(num_points,1);
    haar_negative = zeros(num_points,1);
end
end

