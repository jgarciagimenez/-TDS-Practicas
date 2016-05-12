function [ errorLocal ] = NLMS( remota, signal, U , p )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    E = 10e-5;
    wk = zeros(1,p);
    x = zeros(1,p);

    for j = 1: length(signal)

        x = [remota(j) x(1:p-1)];
        yk = wk * x';
        err = signal(j)-yk;
        wk = wk + 2*U*err*x(1:p)./( E+(x(1:p)*x(1:p)'));            
        errorLocal(j) = err; 


    end
end

