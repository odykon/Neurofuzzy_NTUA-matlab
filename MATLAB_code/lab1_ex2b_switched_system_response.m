% Lab 1 - Exercise 2B: Switched System Response Simulation
% Neuro-Fuzzy Control
% Konias Odysseas Georgios - 03119166
%
% Simulates the discrete-time switched system:
%   x(n+1) = h1(x2)*A1*x(n) + h2(x2)*A2*x(n)
% where the switching weights depend on x2(n):
%   h1 = clamp(x2 - 0.5, 0, 1),  h2 = 1 - h1
% and checks whether x -> 0 for different values of 'a'.

%% Parameters
values = [-5, -3, -2, -1, -0.5, -0.3, -0.1, 0, 0.1, 0.3, 0.5, 1, 3, 5];
N      = 500;               % simulation steps
x0     = [0.3; 0.3];       % initial conditions

i = 0;
figure;
for a = values
    A1 = [0.9  a; 0   0.8];
    A2 = [0.9  0; a   0.8];

    x        = zeros(2, N+1);
    x(:, 1)  = x0;

    for n = 1:N
        h1       = min(max(x(2,n) - 0.5, 0), 1);
        h2       = 1 - h1;
        x(:,n+1) = h1 * A1 * x(:,n) + h2 * A2 * x(:,n);
    end

    i = i + 1;
    subplot(5, 3, i);
    plot(x(1,:)); hold on;
    plot(x(2,:));
    title(['a = ' num2str(a)]);
    legend('x_1','x_2','Location','best');
end

sgtitle('Switched System Response for Various Values of a');

%% Notes
% The system appears asymptotically stable for |a| <= 0.5 (confirmed by
% Lyapunov analysis in Ex2A) and also for a = -1, -2, -3, -5 with the
% chosen initial conditions. Stability may fail for other initial conditions
% when no common Lyapunov function exists.
