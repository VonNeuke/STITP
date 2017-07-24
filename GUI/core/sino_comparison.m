index=180;
sino=rot90(sino,2);
L_es_sino=rot90(L_es_sino,2);
T_es_sino=rot90(T_es_sino,2);
hold on
plot(sino(:,index))
plot(L_es_sino(:,index),'k.')
plot(T_es_sino(:,index),'r+')
hold off
legend('real','Legendre','Tchebichef')
title('\theta=180')
xlabel('s')
ylabel('g(s)')