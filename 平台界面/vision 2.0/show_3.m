function show_3( handles,i )
%SHOW_3 此处显示有关此函数的摘要
%   此处显示详细说明
% global Img_data_pro
imshow(rot90(handles.image_pro(:,:,i)),'Parent',handles.show3);

end

