function out = Results(origimg, reimg, pos)

% Compute closeness metrics
mse = sqrt(mean2((origimg-reimg).^2));  % MSE
absdist = mean2(abs(origimg-reimg));    % Absolute Distance

% Closeness message
closenessmsg = ['The distance between the reconstructed image and the original image is - MSE: ',...
    num2str(mse), ', Absolute Distance: ', num2str(absdist),'.'];
disp(closenessmsg)

allpoints = zeros(size(origimg));
allpoints(pos)=origimg(pos);

% Display the results of the procedure
subplot(2, 2, 1)
imshow(mat2gray(origimg))
title('Original Image')
subplot(2, 2, 2)
imshow(mat2gray(reimg))
title('Compressed Image')
subplot(2, 2, 3)
imshow(mat2gray(origimg-reimg))
title('Difference between the Original and Compressed Image')
subplot(2, 2, 4)
imshow(allpoints)
title('All the initial points')

end