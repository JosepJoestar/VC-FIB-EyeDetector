function [eyes, noEyes] = getEyes(dataset, ratio)
    images = dataset{1};
    eyesData = dataset{2};
   
    resize = 64;
    n = length(images);
    eyes = zeros([resize, resize, 2*n]);
    
    noEyesPerImage = ceil(2*(100 - ratio) / ratio);
    noEyes = zeros([resize, resize, noEyesPerImage * n]);
    
    for i = 1:n
        [left, right] = getEyesInImage(images(:, :, i), eyesData(i, :), resize);
        eyes(:, :, 2*i - 1) = left;
        eyes(:, :, 2*i) = right;
        
        subImages = getNoEyesInImage(images(:, :, i), eyesData(i, :), resize, noEyesPerImage);
        % TODO: Sense bucle
        for j = 1:noEyesPerImage
           noEyes(:,:, noEyesPerImage*(i-1) + j) = subImages(:, :, j);
        end
    end
end