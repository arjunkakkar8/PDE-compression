% Implementation of 2D image reconstruction using
% Laplacian operator

% Import image
img = imread('testChapin.jpg');
% Store greyvalues of image
imggray = rgb2gray(img);

% Dimensions of image
width = size(imggray, 2);
height = size(imggray, 1);
N = width * height;

% Size of compressed data
n = floor(N * 0.3);

% Random greyvalues for now
f = reshape(imggray,1,N);

% Generate confidence vector of length N with n 1's
c = zeros(1, N);
knownIndex = randperm(N, n);

for i = 1:numel(knownIndex)
    c(knownIndex(i)) = 1;
end

% Confidence diagonal matrix from c
C = speye(N).*c;


% Generate the Laplacian operator matrix A
hx = 1;
hy = 1;

% Initialize A as N by N matrix
A = zeros(N);

% Fill in matrix A by Mainberger(p.13)
for i = 1:N
    for j = 1:N
        if neighbor(i, j, height, width) == 1
            A(i,j) = 1./(hx)^2;
            
        elseif neighbor(i, j, height, width) == 2
            A(i,j) = 1./(hy)^2;
                
        elseif i == j 
            % right neighbor
            if mod(i, width) < width
                A(i,j) = A(i,j) - 1./(hx)^2;
            end
            % left neighbor
            if mod(i, width) > 1
                A(i,j) = A(i,j) - 1./(hx)^2;
            end
            % top neighbor
            if floor(i/width) > 0
                A(i,j) = A(i,j) - 1./(hy)^2;
            end
            % bottom neighbor
            if floor(i/width) < height - 1
                A(i,j) = A(i,j) - 1./(hy)^2;
            end    
            
        else
            A(i,j) = 0;
        end
    end
end

% Compute Mext
Mext = C - (speye(N) - C) * A;

% Compute u = inverse Mext * C * f
u = inverse(Mext) * C * f.';

% Reconstruct image
compimg = mat2gray(reshape(u, height, width));
imshow(compimg)
title('Compressed Image')

% returns 1 if i and j are neighboring cells
% in h by w image
function isNb = neighbor(i, j, h, w)
      
      % Reorder i, j s.t. i <= j
      if i > j
          temp = j;
          j = i;
          i = temp;
      end
      
      % neighbors in y direction 
      if i + h == j
          isNb = 2;
          
      % neighbors in x direction
      elseif i + 1 == j && mod(i, w) ~= 0
          isNb = 1;
          
      else
          isNb = 0;
      end
end







