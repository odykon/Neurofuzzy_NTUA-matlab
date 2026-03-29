% Lab 3 - Part 1, Exercise 2: Ill-Conditioned Gradient Descent & Momentum
% Neuro-Fuzzy Control
% Konias Odysseas Georgios - 03119166
%
% Minimises f(x1,x2) = A*x1^2 + (1/A)*x2^2
% Explores the effect of the condition number of the Hessian on plain
% gradient descent, and compares with the heavy-ball (momentum) method.

%% Parameters
A_values  = [0.1, 0.2, 10, 20];
n_steps   = 50;
step_size = 0.01;

syms f_sym(a,b,A_sym)
f_sym(a,b,A_sym) = A_sym*a^2 + (1/A_sym)*b^2;

%% Plain Gradient Descent for each A
figure;
for idx = 1:length(A_values)
    A  = A_values(idx);
    x  = [1; 1];        % fixed starting point
    x_plot = x;
    f_plot = A*x(1)^2 + (1/A)*x(2)^2;

    for i = 1:n_steps
        grad   = [2*A*x(1);  (2/A)*x(2)];
        step   = step_size * grad;
        if norm(step) > 1, step = step/norm(step); end
        x      = x - step;
        x_plot = [x_plot,  x];
        f_plot = [f_plot,  A*x(1)^2 + (1/A)*x(2)^2];
    end

    subplot(2, length(A_values), idx);
    plot(x_plot(1,:), x_plot(2,:), '-x');
    hold on; text(x(1), x(2), 'end');
    title(['A = ' num2str(A)]); xlabel('x1'); ylabel('x2');
end

fprintf('\nCondition numbers:\n');
for A = A_values
    kappa = max(A, 1/A)^2;
    fprintf('  A = %5.2f  ->  kappa = %.1f\n', A, kappa);
end

%% Heavy-Ball (Momentum) Method for A = 0.2
A  = 0.2;
a1 = 0.2;   % momentum coefficient
a2 = 0.2;   % learning rate
x  = [1; 1];
v  = [0.1; 0.1];
x_plot_m = x;
f_plot_m = A*x(1)^2 + (1/A)*x(2)^2;

for i = 1:n_steps
    grad  = [2*A*x(1);  (2/A)*x(2)];
    v     = a1*v - a2*grad;
    step  = -v;
    if norm(step) > 1, step = step/norm(step); end
    x     = x - step;
    x_plot_m = [x_plot_m,  x];
    f_plot_m = [f_plot_m,  A*x(1)^2 + (1/A)*x(2)^2];
end

subplot(2, length(A_values), length(A_values)+1);
plot(x_plot_m(1,:), x_plot_m(2,:), '-x');
hold on; text(x(1), x(2), 'end');
title(['Momentum  A=' num2str(A) '  ' num2str(n_steps) ' steps']); xlabel('x1'); ylabel('x2');

%% A=20 with tuned momentum parameters
A  = 20;
a1 = 0.8;
a2 = 0.05;
n_steps_long = 200;
x  = [1; 1];
v  = 0.1;
x_plot_m2 = x;

for i = 1:n_steps_long
    grad  = [2*A*x(1);  (2/A)*x(2)];
    v_new = a1*v - a2*grad;
    step  = -v_new;
    if norm(step) > 1, step = step/norm(step); end
    x     = x - step;
    x_plot_m2 = [x_plot_m2, x];
    v = v_new;
end

figure;
plot(x_plot_m2(1,:), x_plot_m2(2,:), '-x');
hold on; text(x(1), x(2), 'end');
title(['A = 20, a1 = ' num2str(a1) ', a2 = ' num2str(a2) ', ' num2str(n_steps_long) ' steps']);
xlabel('x1'); ylabel('x2');
