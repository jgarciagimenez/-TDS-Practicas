clear all
close all


										% % % % Tarea 1 % % % % 

% Hacer la demostración de la diapositiva 24 del tema 2




										% % % % Tarea 2 % % % % 
N=1000;
media = 0;
varianza = 1;
x = media + varianza*rand(1,N);


	
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

r3 = xcorr(x,'biased')

	%%%% Delta de dirac

delta=zeros(1,2*N-1);
delta(N)=1;



subplot(2,2,1)
plot (r),title('primera aproximación del guión')

subplot(2,2,2)
plot(r2),title('hecho con el método de la convolución');

subplot(2,2,3)
plot (r3,title('Método xcorr MATLAB con sesgo')

subplot(2,2,4)
plot(delta),title('delta de dirac')




										% % % % Tarea 4 % % % % 

figure 
r4 = xcorr(x,'biased')
plot (r4),title('Método xcorr MATLAB sin sesgo y sin sesgo')
hold on
plot (r3,'g')
legend('Sin sesgo','Con sesgo')


										% % % % Tarea 5 % % % % 

N=1000;
media = 1;
varianza = 1;
x = media + varianza*rand(1,N);

figure
plot(xcorr(x,'unbiased')),'r',title('media 1 con sesgo y sin sesgo')
hold on
plot(xcorr(x,'biased'),'g')



										% % % % Tarea 6 % % % 
rMeanBiased = zeros (1,2*N-1);
rMeanUnbiased = zeros (1,2*N-1)

for i =0:100
	x2 = media + varianza*rand(1,N);
	
	rMeanBiased += xcorr(x2,'biased');
	rMeanUnbiased += xcorr(x2,'unbiased');
end

rMeanBiased = rMeanBiased./100;
rMeanUnbiased = rMeanUnbiased./100;

figure
subplot(1,2,1)
plot(rMeanBiased)
title ('Biased')
subplot(1,2,2)
plot(rMeanUnBiased)
title ('Unbiased')










