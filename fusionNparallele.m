%% init
close all; clear; clc;
addpath("images", "traitements");

%% paramètres
chemin = ["e0.png";"e1.png";"e2.png";"e3.png";"e4.png"];
reduction = 1;

%% début de la fonction %%
n = length(chemin);

%% récupération des N images %%
    images = {n};
    for i = 1:n
        images{i} = recuperationImage(chemin(i), reduction);
    end

%% récupérations des points
    points = {n, 2};
    for i = 1:n-1
        [points{i, 2}, points{i+1, 1}] = recuperationPoints(images{i}, images{i+1});
    end
    points{1, 1} = [];

%% initialisation des abacules
clc;
    abacules = {n};
    for i = 1:n
        abacules{i} = imageVersAbacule(images{i});
    end

%% transformations parallèles
    points = load('points.mat').points;
    points{1, 1} = [];
    for i = 1:ceil(log2(n))
        disp("itération " + i);
        for j = 1:2^i:n-2^(i-1)
            k = j+2^i-2^(i-1);
            disp("fusion entre " + j + " et " + k);
            H = homographie(points{k, 1}, points{j, 2});
            abacules{k} = transformeAbacule(H, abacules{k});
            abacules{j} = sommeAbacule(abacules{j}, abacules{k});
            for l = 1:4
                points{j, 2}(l, :) = transformePoint(H, points{k, 1}(l, :));
            end
        end
    end

%% résultat
    image = uint8(abacules{1}.image);
    imshow(image)