% Implementation of Gauss-Siedel Method to solve 
% Ax = b efficiently where A is an N by N matrix
% x and b are both N by 1 (row) vectors
% Code is based on algorithm on Wikipedia 
% url:https://en.wikipedia.org/wiki/Gauss?Seidel_method

% Input: A is N by N matrix, b is length N vectorBG
% Output: length N vector solution to Ax = b 

A = [16 3; 7 -11];
b = [11;13];
x = GS(A,b);


function x = GS(A, b)
    % get N
    N = numel(b);
    
    % Max number of iterations
    numIter = 5000;
    % Metric of convergence
    convSize = 0.0001;
    
    % Choose an initial guess x to the solution
    x = rand(N, 1);
    
    % Initialize while loop conditions
    sse = Inf;
    iter = 0;
    
    % Repeat until convergence
    while (iter<numIter) && (sse>convSize)
        temp = x;
        
        for i=1:N
            sigma = 0;
            
            for j = 1:N
                if j~=i
                    sigma = sigma + A(i,j) * temp(j);
                end
            end
            
            x(i) = (b(i)-sigma)/A(i,i);
        end
        
        % check convergence
        iter = iter + 1;
        % sum of squared errors
        sse = norm(temp - x);
    end
    
    if sse>convSize
        divMsg = ['Did not converge after ', num2str(iter),' iterations.'];
        disp(divMsg);
        
    else
        msg = ['Converged after ', num2str(iter),' iterations'];
        disp(msg);
    end
end
