clear
clc

n=6;
x=-1:0.02:1;
b=size(x);
p=zeros([n,b(2)]);                   %�½�һ������Ϊn������x��ͬ��ȫ0����p
p(1,:)=ones(size(x));
p(2,:)=x;                            %��p�ĵ�1��2�зֱ�ֵΪ0��1��Legendre����ʽ
%forѭ����2��n-1��Legendre����ʽ��p(n,:)��ʾn-1��Legendre����ʽ
for m=3:n
    p(m,:)=((2*m-1).*x.*p(m-1,:)-(m-1)*p(m-2,:))/m;
                                     %Legendre����ʽ�ĵݹ���ʽ
end
plot(x,p);
%hold on;
%legend('p0','p1','p2','p3','p4','p5')
%xlabel('X');ylabel('P(i)');
%hold off