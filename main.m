% 1. Compression
[origimg, pos] = Compress('image.jpeg', [100,100], .3, 'edgeRand', 0.4, 1);

% 2. Decompression
reimg = Decomp(origimg, pos, 'explicit');
%reimg = Decomp(origimg, pos, 'aniso', 1000, [], 'frac', 1000);

% Processing
% Empty step for now

% 3. Results
Results(origimg, reimg, pos);