clear
clc
p=5;
q=5;
n=p+q-1;
L=L_pq(p,q);
[P,~]=legend(n);

temp=0;
for x=1:200
    for y=1:200
        for i=0:n-1
            for j=0:i
                temp=temp+L(i-j+1,j+1)...
                    *P(i-j+1,x)*P(j+1,y);
            end
        end
        f(x,y)=temp;
    end
end
image(f)
colormap([0,0,0;1,1,1])
