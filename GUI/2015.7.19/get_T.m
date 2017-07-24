function result=get_T(theta,order)
%该函数产生角度THETA所对应的系数矩阵，order为阶数
temp=u_nm(0,0,0,theta);
na=size(theta,1);
M=0:(order+1);
M=sum(M);
result=zeros(na*(order+1),M);
result(1:na,1)=temp;
for i=1:order
    N=0:(i+1);
    N=sum(N);
    index1=i*na+1;
    index2=(i+1)*na;
    [a1,a2]=get_A(theta,i);
    result(index1:index2,1:N)=[a2,a1];
end
