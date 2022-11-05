function H = homographie(X, Y)
    % HOMOGRAPHIE(X, Y) retourne l'homographie H permettant du monde de X au monde de Y.
    num = NaN * ones(8, 8); % numérateur
    den = reshape(Y.', 8, 1); % dénominateur
    for i = 1:4
        x1 = X(i, 1);
        y1 = X(i, 2);
        x2 = Y(i, 1);
        y2 = Y(i, 2);
        num(2*i-1, :) = [x1, y1, 1, 0, 0, 0, -x1*x2, -y1*x2];
        num(2*i, :)   = [0, 0, 0, x1, y1, 1, -x1*y2, -y1*y2];
    end
    X = (num\den).';
    H = [X(1:3); X(4:6); X(7:8) 1];
end