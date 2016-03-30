clear all
close all

%%%%   Práctica 2 Procesos AR y densidad espectral de potencia

N = 24;
a1 = 0;
a2 = 0.81;
b0 = 1;
p=2;
a = [b0 a1 a2];
media = 0;
varianza = 1;
n=-N:N-1;

% % % Tarea 1 % % %

autocorr = zeros(1,23);

autocorr(1) = 1 / (1-a(3)^2);
autocorr(2) = 0;

for i=3:25
   autocorr(i) = -a(3) * autocorr(i-2) ;
end

autocorr=[autocorr(N:-1:2) autocorr];
plot (n,autocorr)


% % % Tarea 2 % % %

x = media + varianza*randn(1,1024);

y = filter(1,a,x);
y = y(999:1024);

r2 = xcorr(y,'biased');
%r2 = [r2(N:-1:2) r2];
figure

plot(n,r2)



