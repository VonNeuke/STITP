function result=Gau_noise(sino,snr)
na=size(sino,2);
result=zeros(size(sino));
for i=1:na
    result(:,i)=awgn(sino(:,i),snr);
end

    
