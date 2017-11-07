function [ l ] = determL(type, m, n, k )
%{
returns a deterministic L Matrix as described in Ledermann et al (2011)
    steps:
        1. find pre image v
        2. get GS image w
        3. select n last columns of w

Parameters
==========
m : int
    number of rows in l
n : int
    number of columns in l
k : int
    additional parameter for Type I,II,III L matrices


Output
==========
l : numeric (two dimensional array)
    deterministic L Matrix
%}

%% Assertions
assert(nargin >= 3, 'determL:not enough input arguments')

assert(m > n, 'determL:m must be bigger than n')

assert(floor(m) == m, 'determL:m is not an Integer');

assert(floor(n) == n, 'determL:n is not an Integer');

types = {'Ledermann', 'TypeI','TypeII', 'TypeIII','Type I','Type II', ...
    'Type III', 'I', 'II', 'III'};

assert(any(strcmp(types, type)), ...
    sprintf('determL: %s is not supported as type', type));

if nargin == 4
    assert(floor(k) == k && ~strcmp(type,'Ledermann'), ...
        'determL:m is not an Integer')
end 
%% Ledermann
if strcmp('Ledermann', type)
    v = zeros(m, m-1);
    for c=1:m-1
       v(c,c) = 1;
       v(c+1,c) = -1;
    end
end

%% Type I
if any(strcmp({'TypeI', 'Type I', 'I'}, type))
    assert(nargin==4, 'determL:not enough input arguments, probably k not specified')
    assert(2*k <= m+1-n, 'determL: does not fullfill 2k <= m+1-n see Ledermann et al (2011)')
    v = zeros(m, m+1-2*k);
    for c = 1:m+1-2*k
       v(c:c+2*k-1, c) = repmat([1;-1],k,1);
    end
end

%% Type II
if any(strcmp({'TypeII', 'Type II', 'II'}, type))
    assert(nargin==4, 'determL:not enough input arguments, probably k not specified')
    assert(m-k >= n, 'determL: does not fullfill 2k <= m+1-n see Ledermann et al (2011)')
    v = zeros(m, m-k);
    for c = 1:m-k
       v(c:c+k-1, c) = ones(k,1);
       v(c+k, c) = -k;
    end
end

%% Type III
if any(strcmp({'TypeIII', 'Type III', 'III'}, type))
    assert(nargin==4, 'determL:not enough input arguments, probably k not specified')
    assert(m-2 >= n, 'determL: does not fullfill 2k <= m+1-n see Ledermann et al (2011)')
    v = zeros(m, m-2);
    for c = 1:m-2
       v(c, c) = k;
       v(c+1, c) = -1;
       v(c+2, c) = 1-k;
    end
end

% w gs image of v    
w = gs(v);
% last n columns form L Matrix
l = w(:, end-(n-1):end);

end

    