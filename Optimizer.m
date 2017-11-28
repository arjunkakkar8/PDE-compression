% Read in the image
image = double(rgb2gray(imread('image.jpeg')));
% Compression Ratio
compression = 0.1;
% Number of variables to be optimized
nvar = floor(numel(image)*compression);


% Objective function that must be minimized
objfun = @(pos) mse(image, pos);

% 
x = fmincon(objfun, nvar,[],[],[],[],[],[],[], 1:numel(image));


% Define a function that calculates mse
function value = mse(origimg, pos)
results = Decomp(origimg, pos, 'explicit');
value = sqrt(mean2((mat2gray(origimg)-mat2gray(results)).^2));
end