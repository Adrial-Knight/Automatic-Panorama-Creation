function H01 = autoH(path_0, path_1, epsilon, K)
    I_0 = rgb2gray(imread(path_0));
    I_1 = rgb2gray(imread(path_1));
    keypoints_0 = detectSIFTFeatures(I_0);
    keypoints_1 = detectSIFTFeatures(I_1);
    
    [features_0, validPoints_0] = extractFeatures(I_0, keypoints_0);
    [features_1, validPoints_1] = extractFeatures(I_1, keypoints_1);
    
    [indexPairs, ~] = matchFeatures(features_0, features_1);
    matchPoints_0 = validPoints_0.Location(indexPairs(:, 1), :);
    matchPoints_1 = validPoints_1.Location(indexPairs(:, 2), :);
    pointsHomogenes_1 = [matchPoints_1, ones(size(matchPoints_1, 1), 1)];
    
    c = zeros(K, 1);
    H_cell = cell(K, 1);
    WarnState = warning("off", "MATLAB:nearlySingularMatrix");
    warning("off", "MATLAB:SingularMatrix");
    for k = 1:K
        random_correspondance = randperm(size(pointsHomogenes_1, 1), 4);
        random_points_0 = matchPoints_0(random_correspondance, :);
        random_points_1 = matchPoints_1(random_correspondance, :);
        H01 = homographie(random_points_0, random_points_1);
        c(k) = cout(H01, epsilon, matchPoints_0, matchPoints_1);
        H_cell{k} = H01;
    end
    warning(WarnState);
    
    [~, argmin] = min(c);
    H01 = H_cell{argmin};
end

function c = cout(H01, epsilon, points_0, points_1)
    pointsEstimate = zeros(size(points_0));
    for i = 1:length(points_0)
        pointsEstimate(i, :) = transformePoint(H01, points_0(i, :));
    end
    diff = points_1 - pointsEstimate;
    norm = sqrt(diff(:, 1).^2 + diff(:, 2).^2);
    c = sum(norm > epsilon);
end