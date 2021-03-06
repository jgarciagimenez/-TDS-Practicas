clear all
close all

%%%%   Práctica 2 Procesos AR y densidad espectral de potencia

N = 24;
a1 = 0;
a2 = 0.81;
b0 = 1;
p=2;
a = [a1 a2];
media = 0;
varianza = 1;
n=-N:N;

% % % Tarea 1 y 2 % % %

autocorr = zeros(1,23);

autocorr(1) = 1 / (1-a(2)^2);
autocorr(2) = 0;

for i=3:25
   autocorr(i) = -a(2) * autocorr(i-2) ;
end

autocorr=[0 autocorr(N:-1:2) autocorr];
plot (n,autocorr)


% % % Tarea 3 % % %

x = media + varianza*randn(1,1024);

y = filter(1,[b0 a],x);
y = y(1000:1024);

r2 = xcorr(y,'biased');
r3 = xcorr(y,'unbiased');

figure

plot(n,r2,'g')
hold on 
plot(n,r3,'r')
plot(n,autocorr)
legend('con sesgo','sin sesgo','original')
hold off


% % % Tarea 4 % % %

PSD1 = 1./fft([1 a],1024).^2;
PSD2 = fft(r2,1024);
PSD3 = fft(r3,1024);

figure 
hold on 
plot(abs(PSD1));
plot(abs(PSD2),'g');
plot(abs(PSD3),'r');
legend('original','con sesgo','sin sesgo')
hold off

% % % Tarea 5 % % %

%%%% Ecuaciones yule walker matriciales proceso AR %%%%
%  Rx * a = -rx
%  a=inv(Rx)*-rx

Rx = [r2(25) r2(26) ; r2(26) r2(25)];
rx = [r2(26) ; r2(27)];
ax = inv(Rx)*-rx;
varianza2 =r2(25) + ax(1)*r2(26) + ax(2)*r2(27);

%%%% Tarea 6 %%%%

PSD4 = (b0*varianza2)./fft([1 ax'],1024).^2;

figure 
hold on 
plot(abs(PSD1));
plot(abs(PSD2),'g');
plot(abs(PSD4),'r');
legend('original','con sesgo','estimado parámetros con sesgo')











