% 1. Compression
[origimg, pos] = Compress('anotherimg.jpg', [3168, 4752], .1, 'edgeRand', .8, 4);

% 2. Decompression
reimg = Decomp(origimg, pos, 'iterative', 500);
%reimg = Decomp(origimg, pos, 'aniso', 200);

% Processing
% Empty step for now

% 3. Results
Results(origimg, reimg, pos);