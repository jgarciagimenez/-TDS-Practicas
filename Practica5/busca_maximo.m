function [ maximo,posicion_maximo ] = busca_maximo( x )

maximo = 0;
posicion_maximo = 0;
for i=10:length(x)-1
    if(x(i-1)<x(i) && x(i)>x(i+1))
        if(x(i)>maximo)
            maximo = x(i);
            posicion_maximo = i;
            
        end
    end
end

end

