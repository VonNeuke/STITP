clear
clc
n0=input('多项式最高阶：');
n=n0+1;
N=200;
x=0:N-1;
t=zeros([n,N]);
t(1,:)=ones([1,N]);
t(2,:)=(2*x+1-N)/N;
for m=3:n
    t(m,:)=((2*m-3)*t(2,:).*t(m-1,:)-(m-2)*t(m-2,:)*(1-(m-2)^2/(N^2)))/(m-1);
end
plot(x,t);