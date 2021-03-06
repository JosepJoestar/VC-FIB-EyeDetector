function [leftEye, rightEye] = getEyesInImage(image, eyesInfo, resize)
    eyesPos = vec2mat(eyesInfo, 2);
    dist = pdist(eyesPos, 'euclidean');
    rectSize = 0.65 * dist;
    halfSize = rectSize / 2;
    
    leftPos = eyesPos(1, :) - halfSize;
    rightPos = eyesPos(2, :) - halfSize;
    
    leftEye = imcrop(image, [leftPos, rectSize, rectSize]);
    rightEye = imcrop(image, [rightPos, rectSize, rectSize]);
    
    leftEye = imresize(leftEye, [resize, resize]); 
    rightEye = imresize(rightEye, [resize, resize]);
end