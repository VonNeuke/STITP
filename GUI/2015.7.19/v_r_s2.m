function result=v_r_s2(r,p,n,m,v_r0,theta)
k=size(theta,1);
result=zeros(k,1);
re=zeros(1,r+1);
re(1)=v_r0;
for i=1:r
    if(rem(i,2)~=0)
        continue
    else
        s=i-2;
        re(i+1)=re(i-1)*(r-s)*(2*m+r-s+1)/((s+2)*(2*n+s+3));
    end
end
temp=cos(theta)*ones(1,r+1);
temp1=sin(theta)*ones(1,r+1);
ss1=0:r;
ss2=ss1+n;
ss3=m+r-ss1;
temp2=ones(k,1)*ss2;
temp3=ones(k,1)*ss3;
temp=temp.^temp2;
temp1=temp1.^temp3;
V=temp.*temp1;
result=V*re';
