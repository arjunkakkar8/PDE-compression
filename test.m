% This is a first test code file and contains the most basic interpretation
% of PDE based compression. Features to add in the future from the
% literature would be stopping times and intellegent selection of storage
% points.

% Another problem I was thinking of is that we should probably always keep
% the boundary values. So N=1, N=100 should always be in our

% Set seed
rng(100)
N = 100; % Size of input data
n = 10;  % Size of compressed data

% Define starting function
f = rand(1,N);
% Store a random subset of points
[fcomp, pos] = datasample(f(2:N), n-2, 'Replace', false);
fcomp = [fcomp, f(1), f(N)]; % Store endpoints
pos = [pos, 1, N];           % Store positions of endpoints

% Arrange these in order
[pos, order] = sort(pos);
fcomp = fcomp(order);

% Reconstruction
g = rand(1, N); % Start with random values
g(pos) = fcomp; % Insert the values we know from the compressed vector fcomp

% Initialize the values matrix that stores the image information at every
% timestep
numiter = 100;
h = 2;
values = zeros(numiter+1, N);
values(1,:) = g;

for iter = 1:numiter
    % Compute the next iteration using f(x,t)+(f(x+1,t)+f(x-1,t)-2f(x,t))/h^2=f(x,t+1),
    % where we assume that h^2 = 1 for simplicity
    gnext = values(iter,:) + (1/h.^2).*(circshift(values(iter,:), 1)+circshift(values(iter,:), -1)-2.*values(iter,:));
    gnext(pos) = fcomp; % Make sure we enforce the girdpoints we know
    
    values(iter+1,:)=gnext; % Attach the values to a matrix
end


% Vector with initial data for plotting
fcompplot = zeros(1,N);
fcompplot(pos) = fcomp;

% Plot the results from the procedure
figure
subplot(2, 1, 1)
hold on
bar(values(numiter,:))
bar(fcompplot, 'FaceColor', 'Red')
hold off
title('Reconstructed Information')
subplot(2, 1, 2)
bar(values(1,:))
title('Original Information')