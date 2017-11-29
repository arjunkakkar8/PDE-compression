% Function that computes the mse between an image and its reconstruction
function [mse, reimg] = geneticMSE(origimg, pos)

width = size(origimg, 2);  % Must be greater than 2
height = size(origimg, 1); % Must be greated than 2
N = width * height;

% Random greyvalues for now
f = reshape(origimg',1,N);

% Generate confidence vector of length N with n 1's
c = zeros(1, N);
c(pos) = 1;

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

u = Mext\(C * f.');

% Create image matrix
reimg = reshape(u, width, height)';

mse = sqrt(mean(mean((origimg-reimg).^2)));
end
