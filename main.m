% 1. Compression
[origimg, pos] = Compress('image.jpeg', .1, 'random');
% 2. Decompression
reimg1 = Decomp(origimg, pos, 'explicit');
reimg2 = Decomp(origimg, pos, 'iterative', 300);
% Processing

% 3. Results
Results(origimg, reimg1, pos);