clear all
close all
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                        Pr�ctica 5                            %%%
%%%               Procesamiento digital de voz                   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Cargamos todas las se�ales de los archivos.

load a.asc
load e.asc
load i.asc
load o.asc
load u.asc
load x.asc

N = length (e);
fs = 8000;
k=0:255;
p=12;
wk = 2*pi.*k./N;

%%% Representamos la se�al e para ver el pitch
plot(e);

% El pitch sale de ~50 muestras dividiendo entre la frecuencia de muestreo
% --> 160 Hz

PX = ((abs(fft(e))).^2)./N;
plot(wk,(10*log10(PX)));


%%%% Espectro LPC

fs = 8000;
p = 12;
rs = xcorr(e,'biased');


%plot(rx);
RX=fft(rs,1024);
PER=10*log10(abs(RX));

%Calculo coeficientes predicci�n lineal autocorrelaci�n%


R = rs(length(e):length(e)+p-1);
r = rs(length(e)+1:length(e)+p);
RT = toeplitz(R);
a = inv(RT)*(-r);

X2 = toeplitz(e,[e(1) zeros(1,p)]);
Xo2 = X2(1:p+1,1:end);
b= Xo2 * [1 ; a];

a_lpc = lpc(e,12);


% Calculo de coeficiontes con m�todo covarianza

RT_cov = zeros(p);

Xs = toeplitz(e(11:N-1),e(11:-1:2));

xs1 = e(12:end);
Rx = Xs' * Xs;
rx = Xs' * xs1;
a_cov = inv(Rx)*(-rx);
a_cov = [1 ; a_cov];


%Espectro LPC %

[h,w] = freqz(b,[1 a'],fs);
[h2,w2] = freqz (b,a_lpc',fs);
[h3,w3] = freqz (b,a_cov',fs); 
figure
plot (fs*w/2/pi,20*log(abs(h))),title('Espectro LPC autocorrelaci�n');
figure 
plot (fs*w2/2/pi,20*log(abs(h2))),title('Espectro LPC funcion lpc');
hold on 
plot (fs*w3/2/pi,20*log(abs(h3)),'r'),title('Espectro LPC funcion covarianza');
hold off

%%% Cepstrum fft

fftx = fft(e);
S = fftx.*conj(fftx);
C = ifft(10*log10(S));

figure
plot(C), title('Cepstrum')

%%% Cepstrum lpc

c_a = zeros(1,12);
c_a = cepstrumlpc(a,p);

% > 1,25 88 0,44 - 0,21














