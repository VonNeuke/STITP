function [p,m]=legend(n)
x=linspace(-1,1,200);
m=size(x);
p=zeros([n,m(2)]);                   %新建一个行数为n列数与x相同的全0矩阵p
p(1,:)=ones(size(x));
p(2,:)=x;                            %将p的第1、2行分别赋值为0、1阶Legendre多项式
%for循环求2至n-1阶Legendre多项式，p(n,:)表示n-1阶Legendre多项式
for a=3:n
    p(a,:)=((2*a-1).*x.*p(a-1,:)-(a-1)*p(a-2,:))/a;
                                     %Legendre多项式的递归形式
end