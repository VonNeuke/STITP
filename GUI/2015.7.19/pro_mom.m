function result=pro_mom(sino,order)
%result是一个阶数×角度的矩阵
[N,M]=size(sino);
% s=-1+1/N:2/N:1-1/N;
s=linspace(-1,1,N);
result=zeros(order+1,M);
P=zeros(order+1,N);
for i=0:order
     temp=legendre(i,s);
     P(i+1,:)=sqrt((2*i+1)/2)*temp(1,:);
end
ds=2/N;
result=P*sino*ds;