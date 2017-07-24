function [p,m]=legend(n)
x=linspace(-1,1,200);
m=size(x);
p=zeros([n,m(2)]);                   %�½�һ������Ϊn������x��ͬ��ȫ0����p
p(1,:)=ones(size(x));
p(2,:)=x;                            %��p�ĵ�1��2�зֱ�ֵΪ0��1��Legendre����ʽ
%forѭ����2��n-1��Legendre����ʽ��p(n,:)��ʾn-1��Legendre����ʽ
for a=3:n
    p(a,:)=((2*a-1).*x.*p(a-1,:)-(a-1)*p(a-2,:))/a;
                                     %Legendre����ʽ�ĵݹ���ʽ
end