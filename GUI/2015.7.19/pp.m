clear
x=[5 10 15 20];
fbp=ones(1,4)*19.873;
len=[11.286 8.4279 5.9729 5.4071];
tch=[9.0753 6.5466 3.6704 3.0925];
hold on 
plot(x,fbp,'-b*')
plot(x,len,'-ro')
plot(x,tch,'-bd')
hold off
legend('FBP','Legendre','Tchebichef')