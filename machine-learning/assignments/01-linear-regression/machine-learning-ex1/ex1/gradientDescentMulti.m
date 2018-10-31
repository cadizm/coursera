function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters)
    %GRADIENTDESCENTMULTI Performs gradient descent to learn theta
    %   theta = GRADIENTDESCENTMULTI(x, y, theta, alpha, num_iters) updates theta by
    %   taking num_iters gradient steps with learning rate alpha

    % Initialize some useful values
    m = length(y); % number of training examples
    J_history = zeros(num_iters, 1);

    for iter = 1:num_iters
        % Perform a single gradient step on the parameter vector theta

        % first row of X is 1's, so X' multiplies (X * theta - y) by 1
        % for theta_0, and by X(i) for theta_1
        theta = theta - (alpha / m) * (X' * (X * theta - y));

        % Save the cost J in every iteration
        J_history(iter) = computeCostMulti(X, y, theta);

    end
end
