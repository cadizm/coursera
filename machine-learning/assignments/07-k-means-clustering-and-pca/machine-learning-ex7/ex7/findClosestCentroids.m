function idx = findClosestCentroids(X, centroids)
    %FINDCLOSESTCENTROIDS computes the centroid memberships for every example
    %   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
    %   in idx for a dataset X where each row is a single example. idx = m x 1
    %   vector of centroid assignments (i.e. each entry in range [1..K])

    % Instructions: Go over every example, find its closest centroid, and store
    %               the index inside idx at the appropriate location.
    %               Concretely, idx(i) should contain the index of the centroid
    %               closest to example i. Hence, it should be a value in the
    %               range 1..K
    %
    % Note: You can use a for-loop over the examples to compute this.

    K = size(centroids, 1);  % set K

    idx = zeros(size(X,1), 1);
    m = size(X, 1);

    for i = 1:m
        x = X(i,:);
        func = @(n) norm(x - centroids(n,:));
        % http://stackoverflow.com/questions/19703558/how-to-apply-a-function-to-all-rows-in-a-matrix
        [_, idx(i)] = min(arrayfun(func, 1:size(centroids,1)));
    end

end
