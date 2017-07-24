function show_1( handles,i )
%SHOW_1 此处显示有关此函数的摘要
%   此处显示详细说明
% global Img_data
imshow(rot90(handles.image(:,:,i)),'Parent',handles.show1);

end

