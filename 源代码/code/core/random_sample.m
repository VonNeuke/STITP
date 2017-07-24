function position=random_sample(SizeImage,n_sample,pos,radius)
%SizeImage����3Dͼ��Ĵ�С������x��y��z��
%n_sampleÿ���뾶��Ҫ�����ĵ���
%pos���ĵ�
%radius�뾶�����������һ����������ʾ��ͬ�İ뾶
%position��һ����ά���󣬵�����������������뾶���������Ӧ


[X,Y,Z]=sphere(n_sample);%���ɣ�n_sample+1��*��n_sample+1������������

%ɾ��x��y��z�п����ظ�������
X(n_sample+1,:)=[];
X(1,:)=[];

Y(n_sample+1,:)=[];
Y(1,:)=[];

Z(n_sample+1,:)=[];
Z(1,:)=[];


num=n_sample*(n_sample-2);%�����ܹ��е��������
random_pos= randperm(num,n_sample);%���������

%��������
X=X(random_pos);
Y=Y(random_pos);
Z=Z(random_pos);

n_R=size(radius,2);%����뾶������
for i=1:n_R
    sample_x=round(X*radius(i)+pos(1));%����x�ڰ뾶ΪR�Ĳ�������,round��������ȼ����������Է�ֹ�������ظ��ĳ����ظ�
    sample_x=min(SizeImage(1),max(1,sample_x));%��ֹ���곬����Χ
    
    sample_y=round(Y*radius(i)+pos(1));%����y�ڰ뾶ΪR�Ĳ�������
    sample_y=min(SizeImage(1),max(1,sample_y));%��ֹ���곬����Χ
    
    sample_z=round(Z*radius(i)+pos(1));%����z�ڰ뾶ΪR�Ĳ�������
    sample_z=min(SizeImage(1),max(1,sample_z));%��ֹ���곬����Χ
    
    position(:,1,i)=sample_x;
    position(:,2,i)=sample_y;
    position(:,3,i)=sample_z;
end


end