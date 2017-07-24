function result=u_nm(p,n,m,theta)
temp1=p-n-m;
k=size(theta,1);
result=zeros(k,1);
if (rem(temp1,2)~=0)
    return
else
    temp1=(p-n-m)/2;
    temp2=(p+n+m)/2;
    temp3=2*temp2;
    v00=sqrt(2*(2*p+1))*((-1)^temp1)*factorial(n)*factorial(m)*factorial(temp3);
    v00=v00/factorial(2*n);
    v00=v00/factorial(2*m);
    v00=v00/factorial(temp1);
    v00=v00/factorial(temp2);
    v00=v00/sqrt((2*n+1)*(2*m+1));
    v00=v00/(2^(2*temp1));
    N=2*temp1;
    temp4=v00;
    for r=0:N
        %r
        if(rem(r,2)~=0)
           
            continue
        else
            if(r==0)
                
                result=temp4*((cos(theta)).^n).*((sin(theta)).^m);
                temp4=v_r2_0(0,p,n,m,temp4);
                continue
            else
                
                v_r0=temp4;
                temp=v_r_s2(r,p,n,m,v_r0,theta);
                result=result+temp;
                temp4=v_r2_0(r,p,n,m,temp4);
            end
        end
    end
end


    