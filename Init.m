function pos = Init(origimg, ratio, method, propedge)

    origSize = numel(origimg);
    compSize = floor(origSize*ratio);
    
    % Select initial points based on called method
    switch method
        % randomly select initial points
        case 'random'
            pos = datasample(1:origSize, compSize, 'Replace', false);
        
        % randomly select edge points and non-edge points
        % given proportion propedge (default to 0.2)
        case 'edgeRand'
            contour = edge(origimg, 'log');
            edges = find(contour)'; 
            edgeSize = propedge * compSize;
            
            edges = datasample(edges, min(compSize, edgeSize));
            
            nonEdges = find(contour==0);
            points = datasample(nonEdges, max(0, compSize-edgeSize));
            
            pos = [edges points];
        
        % evenly spaced grid 
        % case 'grid'
            
    end

end
