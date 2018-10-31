function [J, grad] = costFunction(theta, X, y)
    %COSTFUNCTION Compute cost and gradient for logistic regression
    %   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
    %   parameter for logistic regression and the gradient of the cost
    %   w.r.t. to the parameters.

    % Instructions: Compute the cost of a particular choice of theta.
    %               You should set J to the cost.
    %               Compute the partial derivatives and set grad to the partial
    %               derivatives of the cost w.r.t. each parameter in theta
    %
    % Note: grad should have the same dimensions as theta

    % vectorized implementations
    % https://share.coursera.org/wiki/index.php/ML:Logistic_Regression#Cost_Function

    m = length(y);  % number of training examples

    J = -((log(sigmoid(X * theta))' * y) + ((log(1 - sigmoid(X * theta))') * (1 - y))) / m;

    grad = (X' * (sigmoid(X * theta) - y)) / m;

end
