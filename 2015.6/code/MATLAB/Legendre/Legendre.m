clear
clc

n=6;
x=linspace(-1,1,200);
b=size(x);
p=zeros(n,b(2));
for m=1:n
    temp=0;
    for k=0:m
        if rem((m-k),2)==0
            a=(((-1)^((m-k)/2))*(2^(-m))*(factorial(m+k))*(x.^k))/...
                ((factorial((m-k)/2)*factorial((m+k)/2))*factorial(k));
            temp=temp+a;
        end
    end
    p(m,:)=temp;
    plot(x,temp);
    hold on
end
hold off