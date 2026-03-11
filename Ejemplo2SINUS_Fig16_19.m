%Señal: 1,5 sen(2w 80 t) + sen(2w 100 t) + ruido. En MATLAB:
fs=700 ;
t = (0 :1/fs :2)' ;  
x1 = 1.5*sin(2*pi*80*t) + sin(2*pi*100*t) ;
ruido= 0.1*randn(size(t)) ;
x1n = x1 + ruido ;
N=length(x1n);   % N =  1401
Ener=trapz(t,x1n.^2)  % Area: Integral sobre el segmento de señal
Ener2=sum(x1n.^2)/fs  % Como señal discreta
Pm=1/N*sum(x1n.^2)  % Potencia media (dominio del tiempo)
figure(1)
plot(t, x1n)
xlabel('tiempo (s)')
ylabel('Amplitud (V)')
title('1.5sin(2\pi 80t) + sin(2\pi 100t) + ruido')
%% con N = puntos de la señal
% X1n=fft(x1n);
% Ener3 =1/(fs*N)*sum(abs(X1n).^2) % En el dominio de Fourier
% f=(0:N-1)' *fs/N;
%% Con Nfft = 4096
Nfft = 4096;
% Nfft = N;
X1n = fft(x1n, Nfft);
Ener3 = 1/(fs*Nfft)*sum(abs(X1n).^2) % En el dominio de Fourier
f=(0:Nfft-1)' *fs/Nfft;
%% Figura 16
figure(2) % panel (A)
plot(t(1:280), x1n(1:280))
xlabel('tiempo (s)')
ylabel('Amplitud (V)')
figure(3)  % Panel (B)
plot(f,abs(X1n)/fs) %Amplitud escalada equivalente al espectro de la señal analógica
grid
xlabel('Frecuencia (Hz)')
ylabel('|X1n(f)|')
% Ambas plots en una figura con 2 subplots
figure(4)
subplot(1,2,1)
plot(t(1:280), x1n(1:280))
xlabel('tiempo (s)')
ylabel('Amplitud (V)')
subplot(1,2,2)
plot(f,abs(X1n)/fs) %Amplitud escalada equivalente al espectro de la señal analógica
grid
xlabel('Frecuencia (Hz)')
ylabel('|X1n(f)|')
%% Ejemplo Figura 17
Pxx = (abs(X1n).^2)/(Nfft*fs);
if rem(Nfft, 2) % se evalua la paridad de N
     select = 1:(Nfft+1)/2; % si N es impar 
else
     select = 1:Nfft/2+1; % si N es par
end
Pxx_unlado = Pxx(select); % se toman solo la mitad de las frecuencias, hasta fs/2
Pxx_u = [Pxx_unlado(1); 2*Pxx_unlado(2:end-1); Pxx_unlado(end)];
figure(5)  % Panel (A) escala lineal
plot(f(select), Pxx_u), grid
xlabel('Frecuencia (Hz)')
ylabel('PSD (Watt/Hz)')
title('PSD de x1n (escala lineal)')
figure(6)  % Panel (A) escala dB
plot(f(select),10*log10(Pxx_u)), grid  % PSD en db/Hz
xlabel('Frecuencia (Hz)')
ylabel('PSD (dB/Hz)')
title('PSD de x1n (escala log en dB)')
ylim([-70 10])
Pm=fs*sum(Pxx_u)/N % Potencia media total (dominio de la frecuencia)
ind75_85=find(f >= 75 & f <= 85);
Ener75_85=N/Nfft*sum(Pxx_u(ind75_85));    % Ener75_85 = 2.2520  [W-s] [V2•s]
Pmed75_85 = fs/Nfft*sum(Pxx_u(ind75_85))
%% Enventanado Figura 18
w = hamming(length(x1n));  
figure(7)
plot(t,x1n, t, w)
xw = x1n.*w;
plot(t, xw)
xlabel('tiempo (s)')
ylabel('Amplitud (V)')
title('1.5sin(2\pi 80t) + sin(2\pi 100t) + ruido con ventana de Hamming')
Xw = fft(xw, Nfft);
U = sum(w.^2)/N;
Pxxw = (abs(Xw).^2)/(N*fs*U);
Pxx_unlado = Pxxw(select); 
Pxxw_u = [Pxx_unlado(1); 2*Pxx_unlado(2:end-1); Pxx_unlado(end)];
% La energía en la banda de frecuencia de 75 a 85 Hz se halla como:
ind75_85=find(f >= 75 & f <= 85);
Ener75_85=N/Nfft*sum(Pxxw_u(ind75_85));    % Ener75_85 = 2.2520  [W-s] [V2•s]
Pmed75_85 = fs/Nfft*sum(Pxxw_u(ind75_85));
figure(8)
plot(f(select),10*log10(Pxxw_u)), grid
xlabel('Frecuencia (Hz)')
ylabel('PSD (dB/Hz)')
title('Periodograma modificado (ventana de Hamming) de x1n')
% equivalente con la fución periodogram
figure(9)
periodogram(x1n, hamming(N), Nfft, fs);
%% Figura 19
figure(10)
pwelch(x1n,[],[],Nfft,fs); 
xlabel('Frecuencia (Hz)')
ylabel('PSD (dB/Hz)')
