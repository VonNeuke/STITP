function [all_pos,n_size_image ] = get_allpos(image )
%返回为全坐标
n_size_image = size(image);
all_pos = 1:n_size_image(1)*n_size_image(2)*n_size_image(3);
all_pos = all_pos(:);
[x,y,z] = ind2sub(size(image),all_pos);
all_pos = [x,y,z];
end