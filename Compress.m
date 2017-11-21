% maybe we could remove width, height, compimg from output?
% this seems a little bit redundant as we can get them from 
% just two - origimg and pos

% compress image based on called method
function [origimg, width, height, pos, compimg] = Compress(file, ratio, method, propedge)
    % Import image
    img = imread(file);
    % Store greyvalues of image
    origimg = double(rgb2gray(img));
    
    % Dimensions of image
    width = size(origimg, 2); 
    height = size(origimg, 1); 
    
    % Choose initial points and store initial values
    pos = Init(origimg, ratio, method, propedge);
    compimg = origimg(pos);
end
