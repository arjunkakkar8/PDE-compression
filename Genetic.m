% Use the GAToolbox by adding it to your path by specifying its exact
% address in the Github folder.
% addpath('/Users/ak23/PDE-compression/genetic')
% addAttachedFiles(gcp, {'geneticMSE.m'});

IMG = double(rgb2gray(imread('image.jpeg')));
IMG = IMG(1:100, 1:100);
COMP = 0.1;
NUMONES = floor(COMP*numel(IMG)); % Number of ones that each individual can have

NIND=70;        % Gives the population size
MAXGEN=1000;     % Gives the number of generations
NVAR=numel(IMG);% Number of variables
GGAP=0.9;

% Initial binary population
% candidates = [ones(1, NUMONES), zeros(1, NVAR-NUMONES)];
% Chrom = zeros(NIND, NVAR);
% for i = 1:NIND
% Chrom(i,:) = candidates(randperm(length(candidates)));
% end

% Initialize generations
gen = 0;

% Evaluate the objective function
ObjV = objfun(Chrom, IMG);
disp(ObjV)
disp(min(ObjV))

while gen < MAXGEN
    FitnV = ranking(ObjV);
    
    SelCh = select('sus', Chrom, FitnV, GGAP);
    
    SelCh = recombin('xovdp', SelCh, 0.7);
    
    SelCh = mut(SelCh);
    
    % Make each individual adhere to the constraint by limiting the total
    % number of ones to NUMONES
    for i=1:size(SelCh,1)
        if sum(SelCh(i,:)) > NUMONES
            one = find(SelCh(i, :));
            one = one(randperm(length(one), NUMONES));
            sel = zeros(1, NVAR);
            sel(one) = 1;
            SelCh(i,:)= sel;
        elseif sum(SelCh(i,:)) < NUMONES
            zero = find(~SelCh(i, :));
            zero = zero(randperm(length(zero), NVAR-NUMONES));
            sel = ones(1, NVAR);
            sel(zero) = 0;
            SelCh(i,:)= sel;
        end
    end
    
    ObjVSel = objfun(SelCh, IMG);
    
    [Chrom, ObjV] = reins(Chrom, SelCh, 1, 1, ObjV, ObjVSel);
    
    gen = gen+1;
    disp(gen)
    disp(min(ObjV))
    
    % Final Points from population
%     points = find(Chrom(1,:));
%     showpoints = zeros(size(IMG));
%     showpoints(points) = 1;
%     subplot(1, 3, 1)
%     imshow(showpoints);
%     subplot(1, 3, 2)
%     imshow(mat2gray(IMG))
%     subplot(1, 3, 3)
%     imshow(mat2gray(reimg))
%     drawnow
end

% Function that iterates over the MSE calculation of the population in
% Parallel
function mseV = objfun(indMat, origimg)
mseV = zeros(size(indMat, 1), 1);
parfor i=1:size(indMat, 1)
    pos = find(indMat(i,:));
    mseV(i, 1) = geneticMSE(origimg, pos);
end
end
