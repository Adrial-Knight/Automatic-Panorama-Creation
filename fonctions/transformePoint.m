function Y = transformePoint(H, X)
    % TRANSFORMEPOINT(H, X) renvoie un vecteur Y en utilisant l'homographie H sur X
    X = [double(X) 1];
    Y = int16(ceil([sum(X.*H(1, :))/sum(X.*H(3, :)), sum(X.*H(2, :))/sum(X.*H(3, :))]));
end