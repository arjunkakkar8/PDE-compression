% compress image based on called method
function [origimg, pos] = Compress(file, ratio, method, propedge)
% Set proportion of edge points to be 0.2 by default
if nargin < 4
    propedge = 0.2;
end
% Import image
img = imread(file);
% Store greyvalues of image
origimg = double(rgb2gray(img));

% Choose initial points and store initial values
pos = Init(origimg, ratio, method, propedge);
end
