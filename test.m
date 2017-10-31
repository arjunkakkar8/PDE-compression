% Set seed
rng(100)

% Size of input data
N = 100;
% Size of compressed data
n = 10;

% Define starting function
f = rand (1,N);
% Store a random subset of points
[fcomp, pos] = datasample(f, n, 'Replace', false);

