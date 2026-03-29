% Lab 3 - Part 1, Exercise 1: Gradient Descent
% Neuro-Fuzzy Control
% Konias Odysseas Georgios - 03119166
%
% Minimises f(x1,x2) = x1^2 + (x2-1)^2 + (x1-x2)^4
% using gradient descent with optional step normalisation.

%% Setup
rng(0);
x0 = randn(2,1) * 10;
% x0 = [30; 20];   % uncomment to use a fixed starting point

x = x0;

syms f(a,b)
f(a,b) = a^2 + (b-1)^2 + (a-b)^4;

x_plot = x;
f_plot = double(f(x(1), x(2)));

%% Gradient Descent loop
step_size = 0.01;
n_steps   = 100;

for i = 1:n_steps
    x1 = x(1);  x2 = x(2);

    grad = [2*x1 + 4*(x1-x2)^3; ...
            2*(x2-1) - 4*(x1-x2)^3];

    step = step_size * grad;

    % Step normalisation: prevent very large steps near the start
    if norm(step) > 1
        step = step / norm(step);
    end

    x_new  = x - step;
    x_plot = [x_plot,  x_new];
    f_plot = [f_plot,  double(f(x_new(1), x_new(2)))];
    x      = x_new;
end

%% Plot
figure;
subplot(2,1,1);
plot(x_plot(1,:), x_plot(2,:), '-x');
hold on; text(x(1), x(2), 'end');
title('Gradient Descent'); xlabel('x1'); ylabel('x2');

subplot(2,1,2);
plot(log(double(f_plot)));
xlabel('step'); ylabel('log f(x1,x2)');
title('log f over iterations');

fprintf('Final x = [%.4f, %.4f],  f = %.6f\n', x(1), x(2), double(f(x(1),x(2))));
