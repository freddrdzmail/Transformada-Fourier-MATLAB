%% Actividad formativa 2 - Transformada de Fourier
% Simulacion de tres senales y comprobacion de propiedades DFT.
clear; close all; clc;

%% 1. Parametros de muestreo
Fs = 1000;              % muestras por segundo (Hz)
N = 2000;               % numero de muestras, 2 segundos
n = 0:N-1;
t = n/Fs;              % tiempo desde 0 hasta 1.999 s
f = (-N/2:N/2-1)*(Fs/N); % eje de frecuencias en Hz

%% 2. Senales elementales
pulso = double(t >= 0.5 & t < 0.8);
escalon = double(t >= 1.0);
seno = sin(2*pi*10*t);
senales = {pulso, escalon, seno};
nombres = {'Pulso rectangular','Escalon','Senoidal de 10 Hz'};

%% 3. Graficas del tiempo, magnitud y fase
figure('Name','Senales y espectros','Color','w');
for k = 1:3
    x = senales{k};
    X = fftshift(fft(x))/N; % DFT normalizada, ordenada alrededor de cero
    fase = angle(X);
    fase(abs(X) < 1e-3*max(abs(X))) = NaN; % fase irrelevante
    subplot(3,3,3*k-2);
    plot(t,x,'LineWidth',1.2); grid on;
    title([nombres{k} ' - Tiempo']); xlabel('Tiempo (s)'); ylabel('Amplitud');
    subplot(3,3,3*k-1);
    plot(f,abs(X),'LineWidth',1.2); grid on; xlim([-50 50]);
    title('Magnitud FFT'); xlabel('Frecuencia (Hz)'); ylabel('|X|/N');
    subplot(3,3,3*k);
    plot(f,fase,'LineWidth',1.2); grid on; xlim([-50 50]); ylim([-pi pi]);
    title('Fase FFT'); xlabel('Frecuencia (Hz)'); ylabel('Fase (rad)');
end
exportgraphics(gcf,'senales_espectros.png','Resolution',180);

%% 4. Propiedad de linealidad: FFT(a*x+b*y)=a*FFT(x)+b*FFT(y)
a = 2; b = 0.5;
izq = fft(a*pulso+b*seno);
der = a*fft(pulso)+b*fft(seno);
error_linealidad = max(abs(izq-der));
fprintf('Error maximo linealidad: %.3e\n',error_linealidad);

%% 5. Desplazamiento temporal circular
% Para DFT, desplazar con circshift equivale a fase lineal.
m = 100; % 100 muestras = 0.1 segundos
x = pulso;
x_movido = circshift(x,m);
X = fft(x);
X_pred = X .* exp(-1i*2*pi*(0:N-1)*m/N);
error_desplazamiento = max(abs(fft(x_movido)-X_pred));
fprintf('Error maximo desplazamiento: %.3e\n',error_desplazamiento);

%% 6. Escalamiento en frecuencia mediante cambio de frecuencia senoidal
seno20 = sin(2*pi*20*t);
S10 = abs(fftshift(fft(seno)))/N;
S20 = abs(fftshift(fft(seno20)))/N;
figure('Name','Propiedades de Fourier','Color','w');
subplot(2,2,1);
plot(t,pulso,t,x_movido,'LineWidth',1.2); grid on; xlim([0.3 1.1]);
title('Desplazamiento de 0.1 s'); xlabel('Tiempo (s)');
legend('Original','Desplazado');
subplot(2,2,2);
plot(f,abs(fftshift(X))/N,f,abs(fftshift(fft(x_movido)))/N,'--','LineWidth',1.2);
grid on; xlim([-30 30]); title('Magnitud sin cambio por desplazamiento');
xlabel('Frecuencia (Hz)'); legend('Original','Desplazado');
subplot(2,2,3);
plot(t,seno,t,seno20,'LineWidth',1.0); grid on; xlim([0 0.3]);
title('Senos de 10 y 20 Hz'); xlabel('Tiempo (s)');
legend('10 Hz','20 Hz');
subplot(2,2,4);
plot(f,S10,f,S20,'LineWidth',1.2); grid on; xlim([-30 30]);
title('Escalamiento de frecuencia'); xlabel('Frecuencia (Hz)');
legend('10 Hz','20 Hz');
exportgraphics(gcf,'propiedades_fourier.png','Resolution',180);

%% 7. Verificacion adicional de la linealidad
figure('Name','Linealidad','Color','w');
plot(f,abs(fftshift(izq))/N,'LineWidth',1.5); hold on;
plot(f,abs(fftshift(der))/N,'--','LineWidth',1.0);
grid on; xlim([-50 50]); xlabel('Frecuencia (Hz)'); ylabel('Magnitud');
title('Linealidad: ambos resultados coinciden');
legend('FFT de la combinacion','Combinacion de FFT');
exportgraphics(gcf,'linealidad.png','Resolution',180);
