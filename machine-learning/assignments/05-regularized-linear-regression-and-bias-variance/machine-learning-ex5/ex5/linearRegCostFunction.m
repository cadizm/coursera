function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
    %LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear
    %regression with multiple variables
    %   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the
    %   cost of using theta as the parameter for linear regression to fit the
    %   data points in X and y. Returns the cost in J and the gradient in grad

    % Instructions: Compute the cost and gradient of regularized linear
    %               regression for a particular choice of theta.
    %
    %               You should set J to the cost and grad to the gradient.
    %

    m = length(y);  % number of training examples

    J = (1 / (2 * m)) * ((X * theta) - y)' * ((X * theta) - y);
    grad = (X' * ((X * theta) - y)) / m;

    % now regularize over feature set, excluding theta(1)

    J = J + ((sum(theta(2:end).^2) * lambda) / (2 * m));
    grad = [grad(1); grad(2:end) + ((lambda / m) * (theta(2:end)))];

end
