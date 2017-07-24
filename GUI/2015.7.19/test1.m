clear
% y=linspace(0,89,128);
% yy=y*pi/180;
% yyy=tan(yy);
yyy=0:63;
x=-5:5;
y1=zeros(1,11);
hold on
for s=1:64
    k=yyy(s);
    y1=k*x;
    plot(x,y1)
end
