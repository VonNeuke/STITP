clear
clc
n=10;
n0=n-1;
N=100;
p=zeros([n,N]);
p(1,:)=N;
for m=2:n
    n0=m-1;
    p(m,:)=p(m-1,:)*(1-n0^2/N^2)*(2*n0-1)/(2*n0+1);
end