clear all
close all

%%%%%%   PRACTICA 3: DISEÑO DE FILTROS MEDIANTE MODELADO DETERMINISTA

%%%  En esta práctica vamos a diseñar un filtro 
%%%  pasabaja de fase lineal por los métodos de Padé y de Prony.
%%%  La respuesta impulsiva del filtro es la siguiente:
%%%
%%%  x(n) = (sin((n-nd)*(pi/2)))/((n-nd)*pi);

%%% Tarea 1 %%%
%%% Padé 11 muestras nd=5, p=0, q=10

N=11;
x = zeros (1,N);
p_fir=0;
q_fir=10;
nd=5;
w=0:pi/1023:pi;

for n=0:N-1
    x(n+1) = (sin((n-nd)*(pi/2)))/((n-nd)*pi);
end
x(6) = 0.5;  %%% el resultado de la indeterminación cuando hay 0 en el denominador

%%% La ecuación matricial que obtenemos a partir de Padé es :
%%% b=Xo * ap , como no hay polos, b = x(n)

b_fir = x;
a_fir=1;

%%% Padé 11 muestras nd=5, p=5, q=5

%%% La ecuación matricial que obtenemos a partir de Padé es :
%%% Xq * a = -Xq1 
%%% b=Xo * ap

p_irr = 5;
q_irr = 5;

X = toeplitz(x,[x(1) zeros(1,p_irr)]);
Xq=X(p_irr+2:end,2:end);
Xq1 = x(p_irr+2:end);
a_iir = [1;inv(Xq)*-Xq1'];

Xo = X(1:p_irr+1,1:end);
b_iir= Xo * a_iir;

[h_fir,w_fir] = freqz(b_fir,a_fir,1024);
h_fir=10*log(abs(h_fir));
 
[h_iir,w_iir] = freqz(b_iir,a_iir,1024);
h_iir=10*log(abs(h_iir));

plot(w,h_iir,'g')
hold on
plot(w,h_fir);
legend('IIR','FIR');
title('Respuesta en frecuencia filtor IIR y FIR por padé');
hold off

%%% TAREA 2 %%%
%%% Método de Pronny covarianza
%%% Ecuaciones normales Rx*a = -rx

% Para calcular la matriz de autocorrelacion Rx
% Utilizamos la ecuación Rx = Xs'*Xs
% rx = Xs' * xs1       xs1 = primera columna X0 menos primer elemento
% y añadiendo x(N-1)


N=1000;
for n=0:N-1
    x2(n+1) = (sin((n-nd)*(pi/2)))/((n-nd)*pi);
end
x2(6) = 0.5;  %%% el resultado de la indeterminación cuando hay 0 en el denominador


s = 5;
Xs = zeros (N-s-1,6);

% for i = 1:N-s-1
%     for j = 1:6
%         Xs(i,j)=x2(s-j+i+1);
%     end
% end
Xs = toeplitz(x2(6:N-1),x2(6:-1:2));

xs1 = x2(7:end);
Rx = Xs' * Xs;
rx = Xs' * xs1';
a_prony_iir = inv(Rx)*(-rx);
a_prony_iir = [1 ; a_prony_iir];
    
%%% Prony utiliza padé para los coeficientes b
X2 = toeplitz(x2,[x2(1) zeros(1,p_irr)]);
Xo2 = X2(1:p_irr+1,1:end);
b_prony_iir= Xo2 * a_prony_iir;

%%% Ahora repetimos el proceso anterior con el método de shanks
%%% Los coeficientes a son iguales, cambia los b
%%% Rg * b = rxg
%%% Rg = G0' * G0       rgx = [x(2:end) zeros(1,p_irr+1)]

a_shanks_iir = a_prony_iir;

delta = [1 zeros(1,999)];
g = filter(1,a_shanks_iir,delta);

G0 = zeros(N,q_irr+1);

for i=1:6
    G0(:,i) = [zeros(1,i-1) g(1:N-i+1)]'; 
end

Rg = G0' * G0;
x_0 = x2';
rgx = G0' * x_0;

b_shanks_iir = inv(Rg)*(rgx);

%%% Calculamos el espectro de potencia de las dos opciones para comparar

[h_pronny_iir,w_iir] = freqz(b_prony_iir,a_prony_iir,1024);
h_pronny_iir=10*log(abs(h_pronny_iir));

[h_shanks_iir,w_iir] = freqz(b_shanks_iir,a_shanks_iir,1024);
h_shanks_iir=10*log(abs(h_shanks_iir));

%%% Lo representamos
figure

plot(w,h_pronny_iir,'g')
hold on
plot(w,h_shanks_iir);
legend('Pronny','Shanks');
title('Respuesta en frecuencia filtro IIR por shanks y pronny');
hold off

%%% Filtro elíptico

N2 = 5;
Rp = 0.1;
Rs = 40;
Wp = 0.5;
[B,A] = ellip(N2,Rp,Rs,Wp);

[h_ellip,w_iir] = freqz(B,A,1024);
h_ellip=10*log(abs(h_ellip));

figure 
plot(w,h_ellip)

figure 

plot(w,h_iir,'g')
hold on

plot(w,h_pronny_iir,'r')
plot(w,h_shanks_iir,'k');
plot(w,h_ellip)

legend('Pade','Pronny','Shanks','ellip');
title('Respuesta en frecuencia filtro IIR por shanks, pronny, pade y ellip');

hold off


%%% Calculo de los errores
% Calculamos los errores como la muestra original menos
% la respuesta al impulso de los distintos filtros calculados.

delta = [1 zeros(1,999)];
delta2 = [1 zeros(1,10)];

g_iir_pade = filter(b_iir,a_iir,delta);
g_iir_prony = filter(b_prony_iir, a_prony_iir,delta);
g_iir_shanks = filter(b_shanks_iir, a_shanks_iir,delta);
g_iir_ellip = filter(B,A,delta);

err_iir_pade = sum((x2 - g_iir_pade).^2);
err_iir_prony = sum((x2 - g_iir_prony).^2);
err_iir_shanks = sum((x2 - g_iir_shanks).^2);
err_iir_ellip = sum((x2 - g_iir_ellip).^2);

err_directo = [err_iir_pade err_iir_prony err_iir_shanks err_iir_ellip];

 
 
 










