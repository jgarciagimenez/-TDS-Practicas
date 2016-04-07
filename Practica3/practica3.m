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
x = zeros (1,11);
p=0;
q=10;
nd=5;

for n=0:N-1
    x(n+1) = (sin((n-nd)*(pi/2)))/((n-nd)*pi);
end
x(6) = 0.5;  %%% el resultado de la indeterminación cuando hay 0 en el denominador

%%% La ecuación matricial que obtenemos a partir de Padé es :
%%% b=Xo * ap , como no hay polos, b = x(n)

b1 = x(n);
a1=1;

%%% Padé 11 muestras nd=5, p=5, q=5

%%% La ecuación matricial que obtenemos a partir de Padé es :
%%% Xq * a = -Xq1 
%%% b=Xo * ap

p = 5;
q = 5;

X = toeplitz(x,[x(1) zeros(1,p)]);
Xq=X(p+2:end,2:end);
Xq1 = x(p+2:end);
a2 = [1;inv(Xq)*-Xq1'];

Xo = X(1:p+1,1:end);
b2= Xo * a2;
 
 
 










