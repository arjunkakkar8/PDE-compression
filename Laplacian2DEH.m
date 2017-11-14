% Implementation of 2D image reconstruction using
% Laplacian operator

% Proportion of original image stored
compression = 0.5;

% Import image
img = imread('image.jpeg');
% Store greyvalues of image
imggray = double(rgb2gray(img));
%imggray = imggray(1:1000,1:1000);


% Detect edges
edges = edge(imggray,'log');
Nedgepixels = numel(find(edges));

% Dimensions of image
width = size(imggray, 2);  % Must be greater than 2
height = size(imggray, 1); % Must be greated than 2
N = width * height;

% Size of compressed data
n = floor(N * compression);

% greyvalues
f = reshape(imggray',1,N);

% Generate confidence vector of length N with n 1's
c = reshape(edges',1,N);
knownIndex = datasample(find(c==0),n-Nedgepixels,'Replace',false);
% knownIndex = randperm(N, n);

for i = 1:numel(knownIndex)
    c(knownIndex(i)) = 1;
end


% Confidence diagonal matrix from c
C = spdiags(c', 0, N, N);

% Generate the Laplacian operator matrix A
hx = 1;
hy = 1;

% Define A matrix by defining 3 diagonals

% First define the main diagonal 
maindiag = [-1./(hx)^2-1./(hy)^2,...
    repmat(-2./(hx)^2-1./(hy)^2, [1, width-2]),...
    -1./(hx)^2-1./(hy)^2,...
    repmat([-1./(hx)^2-2./(hy)^2,...
    repmat(-2./(hx)^2-2./(hy)^2, [1, width-2]),...
    -1./(hx)^2-2./(hy)^2], [1,height-2]),...
    -1./(hx)^2-1./(hy)^2,...
    repmat(-2./(hx)^2-1./(hy)^2, [1, width-2]),...
    -1./(hx)^2-1./(hy)^2];

% Define the diagonal with x-adjacencies
xdiag = repmat([repmat(1./(hx)^2, [1,width-1]), 0], [1, height]);
xdiagmod = repmat([0, repmat(1./(hx)^2, [1,width-1])], [1, height]);

% Define the diagonal with y-adjacencies
ydiag = repmat(1./(hy)^2, [1, N]);

% Create the A matrix using these diagonals
A = spdiags([ydiag' xdiag' maindiag' xdiagmod' ydiag'],...
    [-width, -1, 0, 1, width], N, N);

% Compute Mext
Mext = C - (speye(N) - C) * A;


disp('Computing the inverse...')
start = tic;
% Compute u = inverse Mext * C * f'
u = Mext\(C * f.');
stop = toc(start);

disp('Time taken for inverse is')
disp(stop)

% Create image matrix
compimg = reshape(u, width, height)';

% Split Image
split = floor(width/2);
splitimg = [imggray(:,1:split),compimg(:,width-split:width)];

% Reconstruct image
subplot(2, 2, 1)
imshow(mat2gray(imggray))
title('Original Image')
subplot(2, 2, 2)
imshow(mat2gray(compimg))
title('Compressed Image')
subplot(2, 2, [3, 4])
imshow(mat2gray(splitimg))
title('Split Image')


