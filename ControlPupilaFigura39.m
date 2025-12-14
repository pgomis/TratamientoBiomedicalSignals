%% Figura 39
%% Ljung Glad, p 200 control de la pupila
s = tf('s'); 
sys = exp(-0.28*s)*0.19/(1+0.09*s)^3;
% aproximación de Padé de 3er orden
G1 = pade(sys,3); 
% usando un retardo puro de la forma (G2 equivale a sys):
G2 = tf(0.19, [7.29e-4 0.0243 0.27 1], 'InputDelay', 0.28);
% Sistema SIN retardo
G = 0.19/(1+0.09*s)^3;
opts = bodeoptions('cstprefs');
opts.FreqUnits = 'Hz';
opts.PhaseWrapping = 'on';
figure('Color','w')
step(G2, G1, G);  % G tf without delay
title('Respuesta al escalón')
ylabel('Amplitud')
xlabel('Tiempo')
grid
legend('Retardo de entrada','Aproximación de Pade', 'Sin retardo')
figure('Color','w')
bode(G1, opts), grid
legend('Aproximación de Pade')
title('Diagrama de Bode')
xlabel('Frequencia')
% grid
% set(gcf, 'Position', [100 100 1000 400]);  % ancho x alto
