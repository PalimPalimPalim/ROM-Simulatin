function [ r ] = rotationM( typeR, n)
%{
returns a rotation matrix of Type as specified in typeR
    Steps:
        1. de-mean
        2. orthogonalize with GS

Example
==========
l = dataL(y)

Parameters
==========
n : numeric 
    dimension of rotation matrix, n x n

Output
==========
r : numeric (two dimensional array)
    rotation matrix
%}

%% Assertion
assert(nargin == 2, 'rotationM: not enough input arguments')
assert(floor(n) == n, sprintf('rotationM: %f is not an integer', n))

r = ones(n);

%% Upper Hessenberg
if any(strcmp({'Upper Hessenberg', 'Hessenberg', 'H', 'UH'}, typeR))
    

%% Cayley rotation
elseif any(strcmp({'Cayley', 'Caley rotation', 'C'}, typeR))

%% Exponentional rotation
elseif any(strcmp({'Exponential', 'Exponential rotation', 'E'}, typeR))
for c = 1:n-1
   r = r * gallery('randhess',n); 
end

end

