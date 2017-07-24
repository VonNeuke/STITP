function [haar_features] = random_harr(image, points)
num_pattern = 18;
n_size = size(points,1);
step1 = 1;
step2 = round(n_size/num_pattern);
random_index = randperm(num_pattern);
n_size = size(points,1);
random_point = randperm(n_size);
temp_points = points(random_point,:);
haar_features = [];

for num = 1:num_pattern
    temp = temp_points(step1:step2,:);
    temp_harr = cal_haar_features_3D(image, temp,random_index(num));
    haar_features = [haar_features;temp_harr];
    if num == num_pattern
       break;
    end
    step1 = step2 + 1;
    step2 = round(n_size/num_pattern*(num+1));
end
if size(haar_features,1) ~= n_size
   error('random_harr¼ÆËãÓĞ´í')
end
haar_features(:,(size(haar_features,2)+1)) =  random_point;
haar_features = sortrows(haar_features,size(haar_features,2));
haar_features(:,size(haar_features,2)) = [];
end