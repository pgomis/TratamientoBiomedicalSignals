%% Script shows cross correlation between a Twave template and ECG
% P. Gomis
% Usa señal ECG de prueba de la bade de datos Fantasia (W. Disney) de 
% Physionet: https://physionet.org/content/fantasia/1.0.0/exit
load('senecg_fantasia.mat')
fs=250; % Hz
T=ecg1(1361:1437);
[m,pt]=max(T);       % pt es la posición del Maximo
ecg_s=ecg1(500:1995); 
nt=length(T);
tt=(1:length(T))/250';
ne=length(ecg_s);
vm=zeros(size(1:ne-nt+1));
vp=zeros(size(1:ne-nt+1));
t=(1:length(ecg_s))/fs';
%% Visualizar proceso de cálculo XCORR de T vs segmento ECG
figure(2)   
% M=zeros(size(1:ne-nt+1));
for i=1:ne-nt+1
    [c,lags]=xcorr(ecg_s(i:i+nt-1),T,30,'coeff');
    subplot(211)                  %%
    plot(t,ecg_s,tt+(i-1)/250,T)  %%
    xlabel('t (s)'), ylabel('mV')
    title(' ECG - T-wave detection, cross correlation')
    subplot(212)                  %%
    plot(lags,c)                  %%
    axis([-30 30 -1 1])           %%
    xlabel('lags'), ylabel('coef corr')
    if max(c)>0.98 && i>fs*4 && i <5*fs
        pause(0.01)
    end
    pause(1/1000)                   %%
    ind=find(lags==0);
    vm(i)=c(ind);               % Guarda Valor de coefcorr max, lag == 0
    vp(i)=pt+i;     % Guarda posición del pico de la onda T respecto inicio
    M(i)= getframe(gcf);
 %   P(i)=frame2im(M(i));
end
vm=vm';
t=(1:length(ecg_s))/fs';
mar=detecrc_T(vm);
%mar(2)=[];
mar=mar+pt;
subplot(211)
hold on
qe=axis;
yye=[qe(3).*ones(size(mar));qe(4).*ones(size(mar))]; %
xxe=[mar./250;mar./250]; % marcas (en sec)
plot(xxe,yye,'r--');
hold off
