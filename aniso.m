% implementation of anisotropic diffusion
% in Perona, Malik paper
% See http://www.coe.utah.edu/~cs7640/readings/PeronaMalik-PAMI-1990.pdf

% conduction is 'exp' or 'frac', two different methods
% exp favors high-constrast edges over low-contrast ones,
% frac favors wide regions over smaller ones.
% K is some constant value noise estimator
function reimg = aniso(origimg, pos, numiter, conduction, K)
    Nx = size(origimg, 1);
    Ny = size(origimg, 2);
    comp = zeros(Nx,Ny);
    comp(pos) = origimg(pos);
    
    for i = 1:numiter
        
        % add a boundary to current boundary
        temp = pad(comp,[1,1],'replicate');
        
        % nearest-neighbor differences
        % north
        % circshift
        diffN = circshift(temp,[1,0])-temp;
        diffN = diffN(2:end-1,2:end-1);
        % south
        diffS = circshift(temp,[-1,0])-temp;
        diffS = diffS(2:end-1,2:end-1);
        % east
        diffE = circshift(temp,[0,1])-temp;
        diffE = diffE(2:end-1,2:end-1);
        % west
        diffW = circshift(temp,[0,-1])-temp;
        diffW = diffW(2:end-1,2:end-1);
        
        % conduction coefficients
        switch conduction
            case 'exp'
                cN = exp(-(diffN/K).^2);
                cS = exp(-(diffS/K).^2);
                cE = exp(-(diffE/K).^2);
                cW = exp(-(diffW/K).^2);
                
            case 'frac'
                cN = 1./(1+(diffN/K).^2);
                cS = 1./(1+(diffN/K).^2);
                cE = 1./(1+(diffN/K).^2);
                cW = 1./(1+(diffN/K).^2);     
        end
        
        comp = comp + 0.1.*(cN.*diffN+cS.*diffS+cE.*diffE+cW.*diffW); 
        comp(pos) = origimg(pos);
    end
    
    reimg = comp;

end