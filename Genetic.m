% Use the GAToolbox by adding it to your path by specifying its exact
% address in the Github folder.
% addpath('/Users/ak23/PDE-compression/genetic')
% addAttachedFiles(gcp, {'geneticMSE.m'});

IMG = double(rgb2gray(imread('image.jpeg')));
COMP = 0.1;
NUMONES = floor(COMP*numel(IMG)); % Number of ones that each individual can have

NIND=40;        % Gives the population size
MAXGEN=10;     % Gives the number of generations
NVAR=numel(IMG);% Number of variables
GGAP=1;   

% Initial binary population
candidates = [ones(1, NUMONES), zeros(1, NVAR-NUMONES)];
Chrom = zeros(NIND, NVAR);
for i = 1:NIND
Chrom(i,:) = candidates(randperm(length(candidates)));
end

% Initialize generations
gen = 0;

% Evaluate the objective function
ObjV = objfun(Chrom, IMG);

while gen < MAXGEN
    FitnV = ranking(ObjV);
    
    SelCh = select('sus', Chrom, FitnV, GGAP);
    
    SelCh = recombin('xovdp', SelCh, 0.7);
    
    % SelCh = mut(SelCh);
    
    ObjVSel = objfun(SelCh, IMG);
    
    [Chrom, ObjV] = reins(Chrom, SelCh, 1, 1, ObjV, ObjVSel);
    
    gen = gen+1;
    disp(gen)
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

