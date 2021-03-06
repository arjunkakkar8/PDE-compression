function conf = PixelTracing(img, d)
    edges = edge(img, 'log');
    Kvis = reshape(edges',1, numel(img));
   	width = size(img, 2);
    height = size(img, 1);
    conf = zeros(1,numel(Kvis));
    Q1 = zeros(1,numel(Kvis));
    Q2 = zeros(1,numel(Kvis));
    ilast = -1;
    Q1(find(Kvis,1)) = 1;
    
    while numel(find(Q1))~=0
        % find i in Q1 and remove i from Q1
        i = find(Q1,1);
        Q1(i) = 0;
        
        if Kvis(i)>0
            conf(i) = 1;
            Kvis(i) = 0;
            Q2(i) = 1;
            ilast = i;
        end
        
        while numel(find(Q2))~=0
            j = find(Q2, 1);
            Q2(j) = 0;
            neighbors = zeros(1, 4);
            % left neighbor
            if mod(j, width)>1
               neighbors(1)=j-1;
            end
            % right neighbor
            if mod(j,width)>0
                neighbors(2) = j+1;
            end
            % top neighbor
            if floor(j/width)>0
                neighbors(3)=j-width;
            end
            % bottom neighbor
            if ceil(j/width)<height
                neighbors(4)=j+width;
            end
            
            neighbors = neighbors(neighbors~=0);
            
            for k=1:numel(neighbors)
                iN = neighbors(k);
                if Kvis(k)>0
                    if PixelDistance(iN, ilast, img)>d 
                        Q1(iN) = 1;
                        
                    else
                        Q2(iN) = 1;
                        Kvis(iN) = 0;
                        conf(iN) = 1;
                        ilast = iN;
                    end
                end
            end           
        end        
    end
end

function dist = PixelDistance(i, j, mat)
    width = size(mat, 2);
    ixy = [ceil(i/width),mod(i, width)];
    jxy = [ceil(j/width),mod(j, width)];
    dist = sqrt(((ixy(1)-jxy(1))^2+(ixy(2)-jxy(2))^2));
end

