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
end