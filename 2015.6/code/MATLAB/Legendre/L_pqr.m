function L=L_pq(p,q)
x=imread('E:\stitp\Êý¾Ý\pictures\yong.bmp');
N=size(x);
f=x;
n=p+q-1;
[P,~]=legend(n);
temp=0;
for p=1:n
    for q=1:n+1-p
        for i=1:N(1)
            for j=1:N(2)
                k=P(q,:);
                temp=temp+P(p,:)*reshape(k,200,1)*f(i,j);
            end
        end
        L(p,q)=(2*p+1)*(2*q+1)/((N(1)-1)*...
            (N(2)-1))*temp;
    end
end
