function show_2( handles,i )
%SHOW_2 此处显示有关此函数的摘要
%   此处显示详细说明
imshow(rot90(handles.temp_result(:,:,i)),'Parent',handles.show2);
end

