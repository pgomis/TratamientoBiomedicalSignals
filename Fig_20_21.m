load x2
fs=1000;
N=length(x2);
Nfft = 256;
t=(1:N)'/fs; 
figure(1)
plot(t, x2)  % x2: QRS de un latido ECG
grid, xlabel('tiempo (s)'), ylabel('Amplitud (mV)')
title('QRS de un latido ECG')
% X2 = fft(x2);
% f=(0:N-1)'*fs/N;
% select = 1:(N+1)/2;
[Px,f]=periodogram(x2,[],Nfft,fs);
[Px2,f2]=periodogram(x2,hamming(N),Nfft,fs);
[Px3,f3]= pwelch(x2,hamming(64),[],Nfft,fs);
figure(2) % Figura 21
plot(f,10*log10(Px),f2,10*log10(Px2),f3,10*log10(Px3)), grid
xlabel('frecuencia (Hz)')
ylabel('PSD (dB/Hz)')
legend('Periodograma estándar','Periodograma ventana Hamming','Periodograma metodo Welch')
%% Potencia media en bandas de frecuencia
Pm=fs/Nfft*sum(Px);	% Pm =  0.4671  mV2 es la potencia media (average) total
Pm2= trapz(f, Px);
ind0_20=find(f>=0 & f<20);
ind20_40 =find(f>=20 & f<40);
ind40_80=find(f>=40 & f<80);
ind80_150=find(f>=80 & f<150);
ind150_250=find(f>=150 & f<=250);
Pm0_20e = fs/Nfft*sum(Px(ind0_20));
Pm0_20m = fs/Nfft*sum(Px2(ind0_20));
Pm0_20w = fs/Nfft*sum(Px3(ind0_20));
Pm20_40e = fs/Nfft*sum(Px(ind20_40));
Pm20_40m = fs/Nfft*sum(Px2(ind20_40));
Pm20_40w = fs/Nfft*sum(Px3(ind20_40));
Pm40_80e = fs/Nfft*sum(Px(ind40_80));
Pm40_80m = fs/Nfft*sum(Px2(ind40_80));
Pm40_80w = fs/Nfft*sum(Px3(ind40_80));
Pm80_150e = fs/Nfft*sum(Px(ind80_150));
Pm80_150m = fs/Nfft*sum(Px2(ind80_150));
Pm80_150w = fs/Nfft*sum(Px3(ind80_150));
Pm150_250e = fs/Nfft*sum(Px(ind150_250));
Pm150_250m = fs/Nfft*sum(Px2(ind150_250));
Pm150_250w = fs/Nfft*sum(Px3(ind150_250));

