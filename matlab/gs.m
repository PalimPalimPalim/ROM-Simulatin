function [ u ] = gs( v )
%{
Gram-Schmidt according to Ledermann et al (2011)
    Matlab's qr() will not give the same result, since decomposition is not
    unique

Parameters
==========
v: numeric
    G-S pre-image

Output
==========
u : numeric (two dimensional array)
    G-S image


%}

u(:,1) = v(:,1);
for n=2:size(v,2)
    projsum = zeros(size(v(:,n)));
    for i=1:(n-1)
        projsum = projsum + ( (u(:,i)'*v(:,n)) / (u(:,i)'*u(:,i)) ) * u(:,i);
    end
    u(:,n) = v(:,n) - projsum;
end

% normalisation
for n = 1: size(u,2)
    u(:,n) = ((u(:,n)'*u(:,n))^(-1/2))*u(:,n);
end

end

