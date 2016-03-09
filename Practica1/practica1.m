clear all
close all


										% % % % Tarea 1 % % % % 

% Hacer la demostraci�n de la diapositiva 24 del tema 2




										% % % % Tarea 2 % % % % 
N=1000;
media = 0;
varianza = 1;
x = media + varianza*rand(1,N);


	
										% % % %  Tarea 3 % % % % 

%%% M�todo con la primera funci�n
suma = 0;
autocorr = zeros(1,N-1);

for k = 0:N-1
    suma = 0;
    for n = abs(k):N-1
       suma = suma + x(n+1)*x(n-k+1);        
    end
    autocorr(k+1) = suma/N; 
end

r=[autocorr(N:-1:2) autocorr];  %% Hago la simetr�a para obtener la correlaci�n completa

	%%%% M�todo dos con las funciones de convoluci�n

r2=(conv(x,x(N:-1:1)))/N;

	%%%% m�todo con la funci�n de matlab xcorr  

r3 = xcorr(x,'biased')

	%%%% Delta de dirac

delta=zeros(1,2*N-1);
delta(N)=1;



subplot(2,2,1)
plot (r),title('primera aproximaci�n del gui�n')

subplot(2,2,2)
plot(r2),title('hecho con el m�todo de la convoluci�n');

subplot(2,2,3)
plot (r3,title('M�todo xcorr MATLAB con sesgo')

subplot(2,2,4)
plot(delta),title('delta de dirac')




										% % % % Tarea 4 % % % % 

figure 
r4 = xcorr(x,'biased')
plot (r4),title('M�todo xcorr MATLAB sin sesgo y sin sesgo')
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










