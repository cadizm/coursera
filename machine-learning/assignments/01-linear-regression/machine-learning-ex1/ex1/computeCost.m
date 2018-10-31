
% https://share.coursera.org/wiki/index.php/ML:Linear_Regression_with_Multiple_Variables

function J = computeCost(X, y, theta)
    m = length(y);  % number of training examples
    J = (1 / (2 * m)) * ((X * theta) - y)' * ((X * theta) - y);

end
