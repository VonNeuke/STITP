function [X,Y,Z] = cal_center( Image , model)
%ImageΪ����ͼ��
%modelΪ������ʵֵ
%X,Y,ZΪ��������
n_size = size(Image);
Index = find(model == 255);
mass = sum(sum(sum(Image.*model/255)));

[x , y ,z] = ind2sub(n_size,Index);
value = Image(Index);
value = value(:);

mass_x = value'*x;
mass_y = value'*y;
mass_z = value'*z;

X = round(mass_x/mass);
Y = round(mass_y/mass);
Z = round(mass_z/mass);
end