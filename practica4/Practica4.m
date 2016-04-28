
%%% Practica 4 CANCELADOR DE ECO ACÚSTICO

clear all
close all

load local.asc
load remota.asc
load signal.asc

E = 10e-5;

SNR = 10*log10( sum(local.^2)/sum((local-signal).^2) );

%%% Implementamos el cancelador con el algoritmo NLMS

a = 1;
U(a) = 0.0001;

while U(a) < 0.0512
    a = a+1;
    U(a) = U(a-1)*2;
end


error = zeros(length(U),10);
for i = 1 : length (U)
    
    for p = 1:10   
        wk = zeros(1,p);
        x = zeros(1:p);
        
        for j = 1: length(signal)
            
            yk = wk * x';
            error = sum(signal(1:p)-yk);
            wk = wk + 2*U(i)*error*x(1:p)./( E+(x(1:p)*x(1:p)')); 
            x = [remota(j) x(1:p)];
        end 
        error(i,p)=error;
    end
end




