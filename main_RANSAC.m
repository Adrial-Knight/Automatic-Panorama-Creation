%% init
close all; clear; clc;
addpath("images/data/", "fonctions");

%% transformation des images en abacules
chemin = "_-" + string(0:9) + ".jpg";
n = length(chemin);
abacules = {n};
for i = 1:n
    abacules{i} = imageVersAbacule(imread(chemin(i)));
end

%% calcul des homographies
epsilon = 1;
K = 1000;
homographies = {n-1};
for i = 1:n-1
    homographies{i} = autoH(chemin{i}, chemin{i+1}, epsilon, K);
end

%% sommation des abacules sur la 1
for i = 2:n
    H = compositionHomographique(homographies, i, 1);
    abacules{i} = transformeAbacule(H, abacules{i}); % transformation
    abacules{1} = sommeAbacule(abacules{1}, abacules{i}); % sommation
end

%% résultat
image = uint8(abacules{1}.image);
imshow(imrotate(image, 90));
