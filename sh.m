function sh(temp_result)
%SH �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% Min = min(min(min(temp_result)));
Max = max(max(max(temp_result)));
image = temp_result/Max;
% image = (temp_result-Min)/(Max-Min);
% image = image/0.5;
% image = floor(image);
for i = 1:23
imshow(rot90(image(:,:,i)))
figure
end
end

