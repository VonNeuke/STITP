clear
x=linspace(-1,1,128);
hold on
for i=0:4
    y=legendre(i,x);
    y=y(1,:);
    plot(x,y)
end
