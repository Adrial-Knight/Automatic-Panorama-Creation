function [image, masque] = normalise(image, masque)
%NORMALISE utilise les valeurs du masque pour finir le moyennage de l'image,
%puis normalise le masque avec des valeurs binaires
    image = image ./ masque;
    image(image == Inf) = 0;
    image = uint16(image);
    masque(masque ~= 0) = 1;
end