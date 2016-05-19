function [  maximo,pos_max ] = cepstrum( x )

fftx = fft(x);
S = fftx.*conj(fftx);
C = ifft(10*log10(S));

C=C(1:round(length(x)/2));
figure
plot(C), title('Cepstrum')


[maximo ,pos_max] = busca_maximo(C);

end

