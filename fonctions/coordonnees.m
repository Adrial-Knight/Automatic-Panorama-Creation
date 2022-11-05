function varargout = coordonnees(X)
%COORDONNEES retourne les premières coordonnées du vecteur X
    for i = 1:nargout
        varargout{i} = X(i);
    end
end