function [a1,a2]=get_A(theta,order)
%%�����theta�������Ҫ��2�������ϵ�Ԫ�زſ��ñ��������
%%k>=2
k=size(theta,1);
% order=k-1;
a1=zeros(k,order+1);
for i=1:(order+1)
    a1(:,i)=u_nm(order,order-i+1,i-1,theta);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M=0:(order+1);
M=sum(M);
N=M-order-1;
a2=zeros(k,N);
index=1;
for i=0:(order-1)
    for j=0:i
        a2(:,index)=u_nm(order,i-j,j,theta);
        index=index+1;
    end
end
