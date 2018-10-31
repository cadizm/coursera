function [J, grad] = costFunctionReg(theta, X, y, lambda)
    %COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
    %   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
    %   theta as the parameter for regularized logistic regression and the
    %   gradient of the cost w.r.t. to the parameters.

    % Instructions: Compute the cost of a particular choice of theta.
    %               You should set J to the cost.
    %               Compute the partial derivatives and set grad to the partial
    %               derivatives of the cost w.r.t. each parameter in theta

    m = length(y);  % number of training examples

    % compute using original cost function

    [J, grad] = costFunction(theta, X, y);

    % now regularize over feature set, excluding theta(1)

    J = J + ((sum(theta(2:end).^2) * lambda) / (2 * m));

    grad = [grad(1); grad(2:end) + ((lambda / m) * (theta(2:end)))];

end
