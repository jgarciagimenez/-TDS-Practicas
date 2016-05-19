function [  c ] = cepstrumlpc( x,p )


a_lpc = lpc(x,12);
C2 = zeros(1,12);
C2(1) = - a_lpc(2);

for n = 2:p
   suma = 0;
   for k = 1:n 
       suma = suma + (k/n)*C2(k)*a_lpc(n-k+1);
   end
   C2(n) =  -a_lpc(n) - suma;
end

c = C2;
end


