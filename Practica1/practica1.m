clear all
close all

										% % % % Tarea 1 % % % % 

										% % % % Tarea 2 % % % % 
N=1000;
media = 0;
varianza = 1;
x = media + varianza*randn(1,N);
l=-999:1:999;
	
										% % % %  Tarea 3 % % % % 

%%% Método con la primera función
suma = 0;
autocorr = zeros(1,N-1);

for k = 0:N-1
    suma = 0;
    for n = abs(k):N-1
       suma = suma + x(n+1)*x(n-k+1);        
    end
    autocorr(k+1) = suma/N; 
end

r=[autocorr(N:-1:2) autocorr];  %% Hago la simetría para obtener la correlación completa

	%%%% Método dos con las funciones de convolución

r2=(conv(x,x(N:-1:1)))/N;

	%%%% método con la función de matlab xcorr  

r3 = xcorr(x,'biased');

	%%%% Delta de dirac

delta=zeros(1,2*N-1);
delta(N)=1;


subplot(2,2,1)
plot (l,r),title('primera aproximación del guión');

subplot(2,2,2)
plot(l,r2),title('hecho con el método de la convolución');

subplot(2,2,3)
plot (l,r3),title('Método xcorr MATLAB con sesgo');

subplot(2,2,4)
plot(l,delta),title('delta de dirac');


										% % % % Tarea 4 % % % % 

figure 
r4 = xcorr(x,'unbiased');
plot (l,r4),title('Método xcorr MATLAB sin sesgo y sin sesgo')
hold on
plot (l,r3,'g')
legend('Sin sesgo','Con sesgo');
hold off


										% % % % Tarea 5 % % % % 

N=1000;
media2 = 1;
varianza2 = 1;
x2 = media2 + varianza2*randn(1,N);

figure
plot(l,xcorr(x2,'unbiased')),'r',title('media 1 con sesgo y sin sesgo')
hold on
plot(l,xcorr(x2,'biased'),'g')


										% % % % Tarea 6 % % % 
rMeanBiased = zeros (1,2*N-1);
rMeanUnbiased = zeros (1,2*N-1);

for i =0:100
	x3 = media2 + varianza2*randn(1,N);	
	rMeanBiased = rMeanBiased + xcorr(x3,'biased');
	rMeanUnbiased = rMeanUnbiased + xcorr(x3,'unbiased');
end

rMeanBiased = rMeanBiased./100;
rMeanUnbiased = rMeanUnbiased./100;

figure
subplot(1,2,1)
plot(l,rMeanBiased)
title ('Biased')
subplot(1,2,2)
plot(l,rMeanUnbiased)
title ('Unbiased')










