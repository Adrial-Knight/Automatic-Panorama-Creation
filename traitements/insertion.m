function image = insertion(cheminUnivers, cheminFragment)
%INSERTION insère la seconde image (fragment) dans la première (univers)
%% récupération de l'univers et du fragment à insérer
    fragment.image = uint16(imread(cheminFragment));
    univers.image  = uint16(imread(cheminUnivers));
    [fragment.h, fragment.w, ~] = size(fragment.image);
    [univers.h, univers.w, ~]   = size(univers.image);

%% homographie
    univers.boite  = recuperationPoints(uint8(univers.image));
    fragment.boite = [1 1; 1 fragment.h; fragment.w 1; fragment.w fragment.h];
    H = homographie(univers.boite, fragment.boite);

% insertion du fragment
    compteur = zeros(univers.h, univers.w, 'uint16');
    for x = 1:univers.w
        for y = 1:univers.h
            [xx, yy] = coordonnees(transformePoint(H, [x, y]));
            if (1 < xx && xx <= fragment.w && 1 < yy && yy <= fragment.h)
                if (compteur(y, x) == 0)
                    univers.image(y, x, :) = fragment.image(yy, xx, :);
                else
                    univers.image(y, x, :) = fragment.image(yy, xx, :) + univers.image(y, x, :);
                end
                compteur(y, x) = compteur(y, x) + 1;
            end
        end
    end

%% normalisation du résultat
    compteur(compteur == 0) = 1;
    image = uint8(univers.image ./ compteur);
end