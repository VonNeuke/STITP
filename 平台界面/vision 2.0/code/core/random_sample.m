function position=random_sample(SizeImage,n_sample,pos,radius)
%SizeImage输入3D图像的大小，即（x，y，z）
%n_sample每个半径需要采样的点数
%pos中心点
%radius半径，输入可以是一个向量，表示不同的半径
%position是一个三维矩阵，第三个点坐标与输入半径的数量向对应


[X,Y,Z]=sphere(n_sample);%生成（n_sample+1）*（n_sample+1）的球体坐标

%删除x，y，z中可能重复的坐标
X(n_sample+1,:)=[];
X(1,:)=[];

Y(n_sample+1,:)=[];
Y(1,:)=[];

Z(n_sample+1,:)=[];
Z(1,:)=[];


num=n_sample*(n_sample-2);%计算总共有的坐标点数
random_pos= randperm(num,n_sample);%生成随机点

%更新坐标
X=X(random_pos);
Y=Y(random_pos);
Z=Z(random_pos);

n_R=size(radius,2);%就算半径的数量
for i=1:n_R
    sample_x=round(X*radius(i)+pos(1));%计算x在半径为R的采样坐标,round加在这里比加下面语句可以防止采样点重复的出现重复
    sample_x=min(SizeImage(1),max(1,sample_x));%防止坐标超出范围
    
    sample_y=round(Y*radius(i)+pos(1));%计算y在半径为R的采样坐标
    sample_y=min(SizeImage(1),max(1,sample_y));%防止坐标超出范围
    
    sample_z=round(Z*radius(i)+pos(1));%计算z在半径为R的采样坐标
    sample_z=min(SizeImage(1),max(1,sample_z));%防止坐标超出范围
    
    position(:,1,i)=sample_x;
    position(:,2,i)=sample_y;
    position(:,3,i)=sample_z;
end


end