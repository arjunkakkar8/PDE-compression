% 1. Compression
[origimg, pos] = Compress('image.jpeg', .1, 'random');

% 2. Decompression
reimg = Decomp(origimg, pos, 'aniso', 200);

% Processing
% Empty step for now

% 3. Results
%Results(origimg, reimg, pos);