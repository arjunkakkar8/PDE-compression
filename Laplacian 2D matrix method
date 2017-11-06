% Implementation of 2D image reconstruction using
% Laplacian operator

% Import image [TBD]

% Dimensions of image
width = 3;
height = 2;
N = width * height;

% Size of compressed data
n = N / 3;

% Random greyvalues for now
u = rand(1,N);

% Store greyvalues of image into height by width
% matrix u

% Generate confidence vector of length N with n 1's
c = zeros(1, N);
knownIndex = randperm(N, n);

for i = 1:numel(knownIndex)
    c(knownIndex(i)) = 1;
end

% Confidence diagonal matrix from c
C = diag(c);

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
            % TBD
            
        else
            A(i,j) = 0;
        end
    end
end


% returns 1 if i and j are neighboring cells
% in h by w image
function isNb = neighbor(i, j, h, w);
      isNb = 1;
      
      % Reorder i, j s.t. i <= j
      if i > j
          temp = j;
          j = i;
          i = temp;
      end
      
      % Initialize to False
      isNb = 0;
      
      % neighbors in y direction 
      if i + h == j
          isNb = 2;
      % neighbors in x direction
      elseif i + 1 == j && mod(i, w) ~= 0
          isNb = 1;
      end
end







