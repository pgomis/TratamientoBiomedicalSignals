% Ejemplo señal sinusoidal de 40 Hz de 2 ciclos y 3 segundos
Fo = 40;
To = 1/Fo;
fs = 1000;
Ts = 1/fs;
%señal de 2 periodos de duracion
t = 0:Ts:2*To;
x = 2*sin(2*pi*Fo*t);
%% Figura 10 del manual
figure(1)
plot(t,x), grid
xlabel('t (s)')
ylabel('Amplitud')
title('2·sin(2\pi 40t)')
Ener = trapz(t,x.^2);
Pm = trapz(t,x.^2)/(2*To);
Pm=1/length(x)*sum(x.^2);
%% Ejemplo: Potencia y energía de señales digitales en el dominio del tiempo
% Página. 23 del manual
%señal de 1 periodo de duracion
t = 0:Ts:To;
x = 2*sin(2*pi*Fo*t);
Ener = trapz(t,x.^2);  % Ener = 0.005
Ener = Ts*sum(x.^2);   % Ener = 0.005
Pm = trapz(t,x.^2)/3600;
N = length(x);
Pm=1/N*sum(x.^2);
% señal de 1 hora de duración:
t = 0:Ts:3600;
x = 2*sin(2*pi*Fo*t);
Ener = trapz(t,x.^2);  % Ener = 0.005
Ener = Ts*sum(x.^2);   % Ener = 0.005
Pm = trapz(t,x.^2)/3600;
N = length(x);
Pm=1/N*sum(x.^2);