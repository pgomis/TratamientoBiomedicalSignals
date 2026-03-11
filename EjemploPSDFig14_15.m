% Ejemplo señal sinusoidal de 40 Hz de 2 ciclos y 3 segundos
Fo = 40;
To = 1/Fo;
fs = 1000;
Ts = 1/fs;
% señal de 3 segundos
t=0:Ts:3;
x = 2*sin(2*pi*Fo*t);
figure(1)
plot(t,x), grid
xlabel('t (s)')
ylabel('Amplitud')
title('2·sin(2\pi 40t)')
N=length(x); % Número de muestras de la señal (N=3001)
Ener = trapz(t,x.^2);
Pm=1/length(x)*sum(x.^2);  % Potencia media
X=fft(x); % equivalente a X=fft(x,N);
f = (0:N-1)*fs/N;
figure(2)
% Figura 14
% Valor absoluto de la transformada de Fourier  de ambos lados del 
% espectro (A) de una sinusoide de 40 Hz. Espectro de un solo lado (B).
subplot(211) % Panel (A)
plot(f, abs(X))
xlabel('Frecuencia (Hz)')
ylabel('Amplitud')
if rem(N,2)              % se evalua la paridad de N
     select = 1:(N+1)/2; % si N es impar 
else
     select = 1:N/2+1;   % si N es par
end
% select en este caso es de 1501 elementos
subplot(212) % Panel (B)
plot(f(select), 2*abs(X(select))), grid
xlabel('Frecuencia (Hz)')
ylabel('Amplitud')
% Figura 15 PSD 
% Densidad de potencia espectral de un solo lado de una sinusoide de 40 Hz. 
% Escalas lineal (A) y logarítmica en dB (B)
figure(3)
subplot(211) % (A)
Pxx = (abs(X).^2)/(N*fs);
Pxx = Pxx'; % vector columna
Pxx_unlado = Pxx(select); % se toman solo la mitad de las frecuencias, hasta fs/2
Pxx_u = [Pxx_unlado(1); 2*Pxx_unlado(2:end-1); Pxx_unlado(end)];
f_u =  f(select);
plot(f_u, Pxx_u), grid % panel (A)
xlabel('Frecuencia (Hz)')
ylabel('PSD (Watt/Hz)')
subplot(212) % panel (B)
plot(f_u,10*log10(Pxx_u)), grid  % panel (B)
axis([0 500 -80 20])
xlabel('Frecuencia (Hz)')
ylabel('PSD (dB/Hz)')