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

figure
plot (r),title('primera aproximaci�n del gui�n')

%%%% M�todo dos con las funciones de convoluci�n

r2=(conv(x,x(N:-1:1)))/N;

figure
plot(r2),title('hecho con el m�todo de la convoluci�n');

%%%% m�todo con la funci�n de matlab xcorr  
figure 
plot (xcorr(x,'biased')),title('M�todo xcorr MATLAB con sesgo')

%%%% Delta de dirac

delta=zeros(1,2*N-1);
delta(N)=1;

figure
plot(delta),title('delta de dirac')


% % % % Tarea 4 % % % % 

figure 
plot (xcorr(x,'unbiased')),title('M�todo xcorr MATLAB sin sesgo')

% % % % Tarea 5 % % % % 

N=1000;
media = 1;
varianza = 1;
x = media + varianza*rand(1,N);

figure
plot(xcorr(x,'unbiased')),'r',title('media 1 con sesgo y sin sesgo')
hold on
plot(xcorr(x,'biased'),'g')


% % % % Tarea 6 % % % % 











