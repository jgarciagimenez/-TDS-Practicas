
%%% Practica 4 CANCELADOR DE ECO ACÚSTICO

clear all
close all

load local.asc
load remota.asc
load signal.asc



SNR = 10*log10( sum(local.^2)/sum((local-signal).^2) );

%%% Implementamos el cancelador con el algoritmo NLMS

a = 1;
U(a) = 0.0001;

while U(a) < 0.0512
    a = a+1;
    U(a) = U(a-1)*2;
end


errorLocal = zeros(1,length(signal));
errorLocalDTD = zeros(1,length(signal));
err = 0;

SNR = zeros(length(U),10);
SNRDTD = zeros(length(U),10);


for i = 1 : length (U)
    
    for p = 1:10   
        wk = zeros(1,p);
        x = zeros(1,p);

        errorLocal = NLMS(remota,signal,U(i),p);   
        errorLocalDTD = DTD(remota,signal,U(i),p);
        
        SNR(i,p) = 10*log10( sum(local.^2)/sum((local-errorLocal').^2) );        
        SNRDTD(i,p) = 10*log10( sum(local.^2)/sum((local-errorLocalDTD').^2) );
    end
end
[x,y] = meshgrid(U,[1:10]);
surf(x,y,SNR);

figure

surf(x,y,SNRDTD);











