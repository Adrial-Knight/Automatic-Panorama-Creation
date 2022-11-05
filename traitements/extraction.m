function image = extraction(chemin, h, w)
%EXTRACTION extrait un fragment de l'image univers aux dimensions (h, w)
%% récupération de l'univers et des points à extraire
    univers.image = uint16(imread(chemin));
    univers.boite = recuperationPoints(uint8(univers.image));
    [~, ~, c] = size(univers.image);

%% homographie
    fragment.boite = [1 1; 1 h; w 1; w h];
    H = homographie(fragment.boite, univers.boite);

%% cration de l'image extraite
    fragment.image  = zeros(h, w, c, 'uint16');
    fragment.masque = zeros(h, w, 'uint16');
    for x = 1:w
        for y = 1:h
            [xx, yy] = coordonnees(transformePoint(H, [x, y]));
            fragment.image(y, x, :) = fragment.image(y, x, :) + univers.image(yy, xx, :);
            fragment.masque(y, x)   = fragment.masque(y, x) + 1;
        end
    end

%% normalisation
    image = uint8(normalise(fragment.image, fragment.masque));
end