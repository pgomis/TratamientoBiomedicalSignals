%% Filtro IIR
fs = 500;  % frecuencia de muestreo
fN = fs/2;  % frecuencia de Nyquist
[B, A] = butter(3, 80/fN);
figure('Color','w')
freqz(B,A,4096,fs)
xlabel('Frecuencia')
%% Filtro FIR
fs = 500;  % frecuencia de muestreo
fN = fs/2;  % frecuencia de Nyquist 
B = fir1(24, 80/fN); % orden 24
figure('Color','w')
freqz(B, 1, 4096, fs)
%% Filtro muesca (notch)
fs = 500;  % frecuencia de muestreo
fo = 50;   % frecuencia a sintonizar para eliminar
Q = 30;    % factor de calidad
fN = fs/2;  % frecuencia de Nyquist
bw = (fo/fN)/Q; % ancho de banda -3 dB del notch
[B, A] = iirnotch(fo/fN, bw);  % función de DSP System toolbox
figure('Color','w')
freqz(B,A,4096,fs)
% alternativamente con un filtro pasa-banda IIR Butterworth
[bfn,afn]=butter(2,[49 51]./fN,'stop');
figure('Color','w')
freqz(bfn,afn,4096,fs)
% alternativa con designNotchPeakIIR de DSP System toolbox
[Bn, An] = designNotchPeakIIR(Response = "notch", ...
    CenterFrequency = fo/fN, QualityFactor = Q,FilterOrder = 2);
figure('Color','w')
freqz(Bn,An,4096,fs)
%% Filtro peine (comb)
fs = 500;  % frecuencia de muestreo
fo = 50;   % frecuencia a sintonizar para eliminar
Q = 30;    % factor de calidad
bw = (fo/(fs/2))/Q; % ancho de banda -3 dB por notch
N = fs/fo;          % período del peine
[B,A] = iircomb(N,bw,'notch'); % función de DSP System toolbox
figure('Color','w')
freqz(B,A,4096,fs)
title('Filtro peine (comb) IIR para eliminar 50 Hz y sus armónicas')
