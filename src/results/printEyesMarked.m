function [] = printEyesMarked(images, eyePoints)
    for i = 1:length(images)
        eyesPos = vec2mat(eyePoints(i, :), 2);
        dist = pdist(eyesPos, 'euclidean');
        rectSize = 0.65 * dist;
        halfSize = rectSize / 2;
        
        eyesPos = eyePoints(i, :) - halfSize;
        
        I = uint8(squeeze(images(:, :, i)));
        shape = [eyesPos(1), eyesPos(2), rectSize, rectSize];
        I = insertShape(I, 'rectangle', shape, 'LineWidth', 1);
        shape = [eyesPos(3), eyesPos(4), rectSize, rectSize];
        I = insertShape(I, 'rectangle', shape, 'LineWidth', 1);
        imshow(I);
    end
end