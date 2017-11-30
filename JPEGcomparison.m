% Compression + Decompression
% [origimg, pos0] = Compress('image.jpeg', .1, 'random');
% reimg0 = Decomp(origimg, pos0, 'iterative', 200);
%
% [origimg, pos1] = Compress('image.jpeg', .1, 'random');
% reimg1 = Decomp(origimg, pos1, 'iterative', 200);
% 
% [origimg, pos2] = Compress('image.jpeg', .1, 'random');
% reimg2 = Decomp(origimg, pos2, 'iterative', 200);
% 
% [origimg, pos3] = Compress('image.jpeg', .1, 'random');
% reimg3 = Decomp(origimg, pos3, 'iterative', 200);
% 
% [origimg, pos4] = Compress('image.jpeg', .1, 'random');
% reimg4 = Decomp(origimg, pos4, 'iterative', 200);
% 
% [origimg, pos5] = Compress('image.jpeg', .1, 'random');
% reimg5 = Decomp(origimg, pos5, 'iterative', 200);
% 
% [origimg, pos6] = Compress('image.jpeg', .1, 'random');
% reimg6 = Decomp(origimg, pos6, 'iterative', 200);
% 
% [origimg, pos7] = Compress('image.jpeg', .1, 'random');
% reimg7 = Decomp(origimg, pos7, 'iterative', 200);
% 
% [origimg, pos8] = Compress('image.jpeg', .1, 'random');
% reimg8 = Decomp(origimg, pos8, 'iterative', 200);
% 
% [origimg, pos9] = Compress('image.jpeg', .1, 'random');
% reimg9 = Decomp(origimg, pos9, 'iterative', 200);
% 
 [origimg, pos10] = Compress('anotherimg.jpg', [3168, 4752], .44, 'edgeRand', .7, 2);
 reimg10 = Decomp(origimg, pos10, 'iterative');
% 
% [origimg, pos11] = Compress('image.jpeg', .1, 'random');
% reimg11 = Decomp(origimg, pos11, 'iterative', 200);
% 
% [origimg, pos12] = Compress('image.jpeg', .1, 'random');
% reimg12 = Decomp(origimg, pos12, 'iterative', 200);


% jpeg0 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg0.jpg')));
% jpeg1 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg1.jpg')));
% jpeg2 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg2.jpg')));
% jpeg3 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg3.jpg')));
% jpeg4 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg4.jpg')));
% jpeg5 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg5.jpg')));
% jpeg6 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg6.jpg')));
% jpeg7 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg7.jpg')));
% jpeg8 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg8.jpg')));
% jpeg9 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg9.jpg')));
 jpeg10 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg10.jpg')));
% jpeg11 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg11.jpg')));
% jpeg12 = double(rgb2gray(imread('JPEG Compressed Files/anotherimg12.jpg')));

% Calculate the MSE
remse = sqrt(mean2((mat2gray(origimg)-mat2gray(reimg10')).^2));
jpegmse = sqrt(mean2((mat2gray(origimg)-mat2gray(jpeg10)).^2));
