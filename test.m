%% lancement de l'insertion
init(); image = insertion("dest.jpg", "src.jpg"); imshow(image);

%% lancement de l'extraction
init(); image = extraction("dest.jpg", 500, 750); imshow(image);

%% lancement de la mosaique N
init(); image = fusionN(["1.png";"2.png"]); imshow(image);

%% fonction utile
function init()
    close all; clc; clear; addpath("fonctions", "images", "traitements");
end