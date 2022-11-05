function [points_1, points_2] = recuperationPoints(image_1, image_2)
%RECUPERATIONPOINTS demande à l'utilisateur de saisir les points nécessaires
    if(nargin == 1)
        imshow(image_1);
        [X, Y] = ginput(4);
        [X, I] = sort(X);
        Y = Y(I);
        [Y(1:2), I] = sort(Y(1:2));
        X(1:2) = X(I);
        [Y(3:4), I] = sort(Y(3:4));
        X(3:4) = X(I+2);
        points_1 = [X, Y];

    elseif(nargin == 2)
        suffixes = ["^{er}", "^e"];
        points_1 = NaN * ones(4, 2);
        points_2 = NaN * ones(4, 2);
        for i = 1:4
            sgtitle("Selection du " + i + suffixes(1 + (i > 1)) + " point");
            affichage(image_1, image_2, 1);
            points_1(i, :) = ginput(1);

            affichage(image_1, image_2, 2);
            points_2(i, :) = ginput(1);
        end
    end
    close;

function affichage(image_1, image_2, selection)
%Gère l'alternance des images
    if(selection == 1)
        image_2 = image_2 * 0.4;
        titres = ["Cliquer sur l'image", ""];
    else
        image_1 = image_1 * 0.4;
        titres = ["", "Cliquer sur le point correspondant"];
    end
    image_1 = uint8(image_1);
    image_2 = uint8(image_2);
    cla reset
    subplot(2, 1, 1);
    imshow(image_1);
    title(titres(1));
    subplot(2, 1, 2);
    imshow(image_2);
    title(titres(2));