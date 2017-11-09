% Another problem I was thinking of is that we should probably always keep
% the boundary values. So N=1, N=100 should always be in our

% Not following the above advice anymore, using newmann boundary conditions
% instead.

% Set seed
rng(101)
Nx = 316;      % X size of input data
Ny = 475;      % Y size of input data
n = 59000;     % Size of compressed data

compression = 100*n/(Nx*Ny);

% Import test image
raw = imread('anotherimg.jpg');     % Read image
gray = rgb2gray(raw);               % Convert to grayscale(for now)
img = gray(1:Nx, 1:Ny);             % Keep the specified amount

% Define starting function
f = img;

% Store a random subset of points
pos = datasample(1:Nx*Ny, n, 'Replace', false); % Select 5 storage points
fcomp = f(pos);

% Reconstruction
g = rand(Nx, Ny)*255;   % Start with random values
g(pos) = fcomp;         % Insert the values we know from the compressed vector fcomp

% Initialize the values matrix that stores the image information at every
% timestep
numiter = 500;
h = 2; % This is technically a combination of h and timestep t
values = zeros(Nx+2, Ny+2, 2);  % Create a N+2 by N+2 gird
values(2:Nx+1,2:Ny+1,2) = g;    % Add values in the inner N by N grid

% Add values in the boundary to implement the Neumann condition
values(2:Nx+1, 1, 2) = values(2:Nx+1, 2, 2);            % Left Boundary
values(2:Nx+1, Ny+2, 2) = values(2:Nx+1, Ny+1, 2);      % Right Boundary
values(1, 2:Ny+1, 2) = values(2, 2:Ny+1, 2);            % Top Boundary
values(Nx+2, 2:Ny+1, 2) = values(Nx+1, 2:Ny+1, 2);      % Bottom Boundary

for iter = 1:numiter
    % Compute the next iteration using finite difference form of laplacian
    gnext = values(:,:,2) + (1/h.^2).*(circshift(values(:,:,2), [1,0])+circshift(values(:,:,2), [-1,0])+circshift(values(:,:,2), [0,1])+circshift(values(:,:,2), [0,-1])-4.*values(:,:,2));
    % Enforce the girdpoints we know again
    inner = gnext(2:Nx+1, 2:Ny+1);
    inner(pos) = fcomp;
    gnext(2:Nx+1, 2:Ny+1) = inner;
    % Enforce the boundary again
    gnext(2:Nx+1, 1) = gnext(2:Nx+1, 2);            % Left Boundary
    gnext(2:Nx+1, Ny+2) = gnext(2:Nx+1, Ny+1);      % Right Boundary
    gnext(1, 2:Ny+1) = gnext(2, 2:Ny+1);            % Top Boundary
    gnext(Nx+2, 2:Ny+1) = gnext(Nx+1, 2:Ny+1);      % Bottom Boundary
    
    values(:,:,1)=values(:,:,2); % Store last values
    values(:,:,2)=gnext;         % Update values
    disp(iter);
end

% Check convergence of the solution by looking at the MSE between the last
% two iterations
convergence =sqrt(mean(mean((values(2:Nx+1,2:Ny+1,2)-values(2:Nx+1,2:Ny+1,1)).^2)));

% Finally store the reconstructed compressed image
compimg = mat2gray(values(:,:,2));

% Compute closeness metrics
mse = sqrt(mean(mean((values(2:Nx+1,2:Ny+1,2)-g).^2))); % MSE
absdist = mean(mean(abs(values(2:Nx+1,2:Ny+1,2)-g))); % Absolute Distance

% Closeness message
closenessmsg = ['The distance between the reconstructed image and the original image is - MSE: ',...
    num2str(mse), ', Absolute Distance: ', num2str(absdist),'.'];
disp(closenessmsg)

% Completion message
msg = ['The image was created with ', num2str(compression),...
    '% of the original information and the convergence metric is ', num2str(convergence), '.'];
disp(msg)

% Display the results of the procedure
subplot(1, 2, 1)
imshow(f)
title('Original Image')
subplot(1, 2, 2)
imshow(compimg)
title('Compressed Image')