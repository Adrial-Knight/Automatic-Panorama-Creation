function abacule = imageVersAbacule(image)
%IMAGEVERSABACULE convertit une image en abacule (fragment d'une mosaïque).
%Un abacule est une strucutre comportant trois champs:
%   - boite:  matrice 2x2 en int16 représentant les positions géographiques des pixels
%             en haut à gauche et en bas à droite.
%   - image:  matrice comportant les valeurs des pixels en uint8 (0-255).
%   - masque: matrice de même taille que l'image indiquant si le pixel correspondant est régulier.
    [h, w, ~] = size(image);
    abacule.boite  = int16([1 1; w h]);
    abacule.image  = uint16(image);
    abacule.masque = ones(h, w, 'uint16');
end