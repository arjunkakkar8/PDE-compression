% Another problem I was thinking of is that we should probably always keep
% the boundary values. So N=1, N=100 should always be in our

% Not following the above advice anymore, using newmann boundary conditions
% instead.

% Set seed
rng(101)
N = 1000; % Sqrt of size of input data
n = 300000;  % Size of compressed data

compression = n/N^2*100;

% Import test image
raw = imread('anotherimg.jpg'); % Read image
gray = rgb2gray(raw);       % Convert to grayscale(for now)
img = gray(1:N, 1:N);       % Keep a specified amount

% Define starting function
f = img;

% Store a random subset of points
pos = datasample(1:N^2, n, 'Replace', false); % Select 5 storage points
fcomp = f(pos);

% Reconstruction
g = rand(N, N)*255; % Start with random values
g(pos) = fcomp; % Insert the values we know from the compressed vector fcomp

% Initialize the values matrix that stores the image information at every
% timestep
numiter = 100;
h = 2; % This is technically a combination of h and timestep t
values = zeros(N+2, N+2, 2);      % Create a N+2 by N+2 gird
values(2:N+1,2:N+1,2) = g;                % Add values in the inner N by N grid

% Add values in the boundary to implement the Neumann condition
values(2:N+1, 1, 2) = values(2:N+1, 2, 2);          % Left Boundary
values(2:N+1, N+2, 2) = values(2:N+1, N+1, 2);      % Right Boundary
values(1, 2:N+1, 2) = values(2, 2:N+1, 2);          % Top Boundary
values(N+2, 2:N+1, 2) = values(N+1, 2:N+1, 2);      % Bottom Boundary

for iter = 1:numiter
    % Compute the next iteration using finite difference form of laplacian
    
    
    gnext = values(:,:,2) + (1/h.^2).*(circshift(values(:,:,2), [1,0])+circshift(values(:,:,2), [-1,0])+circshift(values(:,:,2), [0,1])+circshift(values(:,:,2), [0,-1])-4.*values(:,:,2));
    % Enforce the girdpoints we know again
    inner = gnext(2:N+1, 2:N+1);
    inner(pos) = fcomp;
    gnext(2:N+1, 2:N+1) = inner;
    % Enforce the boundary again
    gnext(2:N+1, 1) = gnext(2:N+1, 2);          % Left Boundary
    gnext(2:N+1, N+2) = gnext(2:N+1, N+1);      % Right Boundary
    gnext(1, 2:N+1) = gnext(2, 2:N+1);          % Top Boundary
    gnext(N+2, 2:N+1) = gnext(N+1, 2:N+1);      % Bottom Boundary
    
    values(:,:,1)=values(:,:,2); % Store last values
    values(:,:,2)=gnext; % Update values
    disp(iter);
end

% Check convergence of the solution by looking at the MSE between the last
% two iterations
convergence = mean(mean((values(:,:,2)-values(:,:,1)).^2));

% Finally store the compressed image
compimg = mat2gray(values(:,:,2));

% Display the results of the procedure
subplot(1, 2, 1)
imshow(f)
title('Original Image')
subplot(1, 2, 2)
imshow(compimg)
title('Compressed Image')

msg = ['The image was created with ', num2str(compression), '% of the original information and the convergence metric is ', num2str(convergence), '.'];
disp(msg)