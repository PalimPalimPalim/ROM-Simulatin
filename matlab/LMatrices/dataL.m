function [ l ] = dataL( y )
%{
returns a data-specific L Matrix as described in Ledermann et al (2011)
    Steps:
        1. de-mean
        2. orthogonalize with GS

Example
==========
l = dataL(y)

Parameters
==========
y : numeric (tow dimensional array)
    original sample

Output
==========
l : numeric (two dimensional array)
    data-specific L Matrix
%}
% Assertion
assert(size(y,1)>size(y,2), 'sample has more risk factors than observations')
assert(isa(y, 'numeric'), sprintf('y must be of type double not %s', class(y)))

%% de - mean
v = y - ones(size(y,1),1)* mean(y);
%% orthogonalize
l = gs(v);

end

v 