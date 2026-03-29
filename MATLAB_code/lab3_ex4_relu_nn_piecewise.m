% Lab 3 - Part 2, Exercise 1: ReLU Neural Network for Piecewise-Linear Function
% Neuro-Fuzzy Control
% Konias Odysseas Georgios - 03119166
%
% Represents the piecewise-linear function:
%   y = ReLU(x) + 2*ReLU(-x-2) + ReLU(-x) + 2*ReLU(-x-1)
% as a single hidden-layer neural network with ReLU activations:
%   y_nn = W2 * ReLU(W1*x + b1) + b2
%
% Decomposition:
%   y1 = ReLU(x)
%   y2 = ReLU(-x-2)          [scaled by 2]
%   y3 = ReLU(-x) - 2*ReLU(-x-1) + ReLU(-x-2)
%   y  = y1 + 2*y2 + y3

%% Network weights (column vectors / row vectors for batch eval)
W1 = [1; -1; -1; -1];          % 4 x 1  (hidden weights, one input)
b1 = [0; -2;  0; -1];          % 4 x 1  (hidden biases)
W2 = [1,  2,  1,  2];          % 1 x 4  (output weights)
b2 = 0;                         % scalar output bias

relu = @(z) max(0, z);

%% Evaluate on a grid
x_vals  = linspace(-4, 4, 500).';
hidden  = relu(W1.' .* x_vals + b1.');   % 500 x 4
y_nn    = (hidden * W2.') + b2;           % 500 x 1

%% True piecewise function (for verification)
y_true = relu(x_vals)          + ...
         2 * relu(-x_vals - 2) + ...
         relu(-x_vals)         + ...
         2 * relu(-x_vals - 1);

%% Plot
figure;
plot(x_vals, y_true, 'b-',  'LineWidth', 2, 'DisplayName', 'True y');
hold on;
plot(x_vals, y_nn,   'r--', 'LineWidth', 1.5, 'DisplayName', 'NN output y_{nn}');
legend; xlabel('x'); ylabel('y');
title('ReLU Neural Network vs True Piecewise-Linear Function');
fprintf('Max absolute error: %.2e\n', max(abs(y_nn - y_true)));

%% Display network parameters
fprintf('\nW1 = [%s]\n', num2str(W1.'));
fprintf('b1 = [%s]\n', num2str(b1.'));
fprintf('W2 = [%s]\n', num2str(W2));
fprintf('b2 = %g\n', b2);
