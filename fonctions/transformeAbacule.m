function nouveau = transformeAbacule(H, ancien)
%TRANSFORMEABACULE transforme l'ancien abacule grâce à l'homographie H
%% nouvelle boite
    boite = [transformePoint(H, ancien.boite(1, :)); transformePoint(H, ancien.boite(2, :))];
    nouveau.boite = [min(boite(:, 1)) min(boite(:, 2)); max(boite(:, 1)) max(boite(:, 2))];

%% constantes utiles
    H_inv = inv(H);
    [h.nouveau, w.nouveau] = dimensionBoite(nouveau.boite);
    [h.ancien, w.ancien]   = dimensionBoite(ancien.boite);
    [~, ~, c] = size(ancien.image);

%% nouveau masque et nouvelle image
    nouveau.masque = zeros(h.nouveau, w.nouveau, 1, 'uint16');
    nouveau.image  = zeros(h.nouveau, w.nouveau, c, 'uint16');
    for x = 1:w.nouveau
        for y = 1:h.nouveau
            dest    = [nouveau.boite(1, 1) + x, nouveau.boite(1, 2) + y];
            origine = transformePoint(H_inv, dest);
            indice  = [origine(2)-ancien.boite(1, 2)+1, origine(1)-ancien.boite(1, 1)+1];
            if(4 == (sum(ones(1, 2) <= indice) + sum(indice <= [h.ancien, w.ancien])))
                nouveau.masque(y, x) = nouveau.masque(y, x) + ancien.masque(indice(1), indice(2));
                nouveau.image(y, x, :) = nouveau.image(y, x, :) + ancien.image(indice(1), indice(2), :);
            end
        end
    end

%% normalisation
    [nouveau.image, nouveau.masque] = normalise(nouveau.image, nouveau.masque);

function [h, w] = dimensionBoite(boite)
    h = boite(2, 2) - boite(1, 2) + 1;
    w = boite(2, 1) - boite(1, 1) + 1;