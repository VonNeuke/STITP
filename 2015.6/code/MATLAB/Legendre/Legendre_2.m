clear
clc

n=6;
x=-1:0.02:1;
b=size(x);
p=zeros([n,b(2)]);                   %新建一个行数为n列数与x相同的全0矩阵p
p(1,:)=ones(size(x));
p(2,:)=x;                            %将p的第1、2行分别赋值为0、1阶Legendre多项式
%for循环求2至n-1阶Legendre多项式，p(n,:)表示n-1阶Legendre多项式
for m=3:n
    p(m,:)=((2*m-1).*x.*p(m-1,:)-(m-1)*p(m-2,:))/m;
                                     %Legendre多项式的递归形式
end
plot(x,p);
%hold on;
%legend('p0','p1','p2','p3','p4','p5')
%xlabel('X');ylabel('P(i)');
%hold off