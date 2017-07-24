clear
clc
p=5;
q=5;
n=p+q-1;
L=L_pqr(p,q);
[P,~]=legend(n);

temp=0;
for i=0:n-1
    for j=0:i
        k=P(j+1,:);
        temp=temp+L(i-j+1,j+1)...
            *P(i-j+1,:)*reshape(k,200,1);
        f(x,y)=temp;
    end
end

image(f);
colormap([0,0,0;1,1,1])
