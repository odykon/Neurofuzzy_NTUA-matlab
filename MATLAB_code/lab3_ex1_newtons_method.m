% Lab 3 - Part 1, Exercise 1: Newton's Method
% Neuro-Fuzzy Control
% Konias Odysseas Georgios - 03119166
%
% Minimises f(x1,x2) = x1^2 + (x2-1)^2 + (x1-x2)^4
% using Newton's method (analytic inverse Hessian).

%% Setup
rng(0);
x0 = randn(2,1) * 10;
% x0 = [30; 20];   % uncomment for a fixed starting point

x = x0;

syms f(a,b)
f(a,b) = a^2 + (b-1)^2 + (a-b)^4;

x_plot = x;
f_plot = double(f(x(1), x(2)));

%% Newton's Method loop
n_steps = 30;

for i = 1:n_steps
    x1 = x(1);  x2 = x(2);

    % Gradient
    grad = [2*x1 + 4*(x1-x2)^3; ...
            2*(x2-1) - 4*(x1-x2)^3];

    % Analytic inverse Hessian elements
    % H = [12*(x1-x2)^2 + 2,  -12*(x1-x2)^2;
    %      -12*(x1-x2)^2,       12*(x1-x2)^2 + 2]
    h1 = (12*(x1-x2)^2 + 2) / (48*x1^2 - 96*x1*x2 + 48*x2^2 + 4);
    h2 = (3*(x1-x2)^2)      / (12*x1^2 - 24*x1*x2 + 12*x2^2 + 1);
    inv_Hessian = [h1  h2; h2  h1];

    step   = inv_Hessian * grad;
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
title("Newton's Method"); xlabel('x1'); ylabel('x2');

subplot(2,1,2);
plot(log(double(f_plot)));
xlabel('step'); ylabel('log f(x1,x2)');
title('log f over iterations (Newton)');

fprintf('Final x = [%.4f, %.4f],  f = %.6f\n', x(1), x(2), double(f(x(1),x(2))));
