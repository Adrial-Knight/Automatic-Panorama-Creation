function abacule = sommeAbacule(abacule_1, abacule_2)
%SOMMEABACUME somme deux abacules
%% nouvelle boite
    abacule.boite = [min(abacule_1.boite(1, 1), abacule_2.boite(1, 1)), ...
                     min(abacule_1.boite(1, 2), abacule_2.boite(1, 2)); ...
                     max(abacule_1.boite(2, 1), abacule_2.boite(2, 1)), ...
                     max(abacule_1.boite(2, 2), abacule_2.boite(2, 2))];

%% définition du nouveau masque et de la nouvelle image
    [w, h] = coordonnees([abacule.boite(2, :) - abacule.boite(1, :) + 1]);
    [~, ~, c] = size(abacule_1.image);
    abacule.masque = zeros(h, w, 1, 'uint16');
    abacule.image  = zeros(h, w, c, 'uint16');

%% remplissage du nouveau masque et de la nouvelle image
    abacule.masque = sommeGeographique(abacule.masque, abacule.boite(1, :), abacule_1.masque, abacule_1.boite(1, :));
    abacule.masque = sommeGeographique(abacule.masque, abacule.boite(1, :), abacule_2.masque, abacule_2.boite(1, :));
    abacule.image  = sommeGeographique(abacule.image,  abacule.boite(1, :), abacule_1.image,  abacule_1.boite(1, :));
    abacule.image  = sommeGeographique(abacule.image,  abacule.boite(1, :), abacule_2.image,  abacule_2.boite(1, :));

%% normalisation
    [abacule.image, abacule.masque] = normalise(abacule.image, abacule.masque);

function univers = sommeGeographique(univers, origine, fragment, depart)
%SOMMEGEOGRAPHIQUE somme les deux matrices univers et fragment grâce à
%leurs coordonnées géographiques (origine et départ respectivement).
%L'univers doit pouvoir contenir géographiquement le fragment.
    [h, w, ~] = size(fragment);
    [dw, dh]  = coordonnees(depart - origine + 1);
    univers(dh:dh+h-1, dw:dw+w-1, :) = univers(dh:dh+h-1, dw:dw+w-1, :) + fragment;