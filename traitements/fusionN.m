function image = fusionN(chemin)
%% transformation des images en abacules
    n = length(chemin);
    abacules = {n};
    for i = 1:n
        abacules{i} = imageVersAbacule(imread(chemin(i)));
    end

%% calcul des homographies
    homographies = {n-1};
    for i = 1:n-1
        [points.origines, points.destination] = recuperationPoints(abacules{i}.image, abacules{i+1}.image);
        homographies{i} = homographie(points.origines, points.destination);
    end

%% sommation des abacules sur la 1
    for i = 2:n
        H = compositionHomographique(homographies, i, 1);
        abacules{i} = transformeAbacule(H, abacules{i}); % transformation
        abacules{1} = sommeAbacule(abacules{1}, abacules{i}); % sommation
    end

%% résultat
    image = uint8(abacules{1}.image);

function H = compositionHomographique(homographies, i, j)
%COMPOSITIONHOMOGRAPHIQUE renvoit l'homographie pour passer de l'image i à l'image j
    H = [1 0 0; 0 1 0; 0 0 1]; % matrice identité
    if (i < j)
        for k = i:j-1
            H = mtimes(H, homographies{k});
        end
    elseif (i > j)
        for k = j:i-1
            H = mtimes(H, inv(homographies{k}));
        end
    end