function [U, S] = pca(X)
    %PCA Run principal component analysis on the dataset X
    %   [U, S, X] = pca(X) computes eigenvectors of the covariance matrix of X
    %   Returns the eigenvectors U, the eigenvalues (on diagonal) in S

    % Instructions: You should first compute the covariance matrix. Then, you
    %               should use the "svd" function to compute the eigenvectors
    %               and eigenvalues of the covariance matrix.
    %
    % Note: When computing the covariance matrix, remember to divide by m (the
    %       number of examples).

    [m, n] = size(X);  % useful values
    sigma = (1 / m) * (X' * X);  % covariance matrix

    [U, S, V] = svd(sigma);

end
