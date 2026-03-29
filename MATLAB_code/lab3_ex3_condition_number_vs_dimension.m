% Lab 3 - Part 1, Exercise 3: Condition Number vs Matrix Dimension
% Neuro-Fuzzy Control
% Konias Odysseas Georgios - 03119166
%
% For each dimension N = 1..100, generates 100 random PSD matrices Q = A*A'
% and records the median condition number kappa = max(|eig|)/min(|eig|).

n_max    = 100;
n_trials = 100;

figure; hold on;
for N = 1:n_max
    k_values = zeros(1, n_trials);
    for i = 1:n_trials
        A           = randn(N, N);
        Q           = A * A;              % PSD matrix
        eigenvalues = eig(Q);
        k_values(i) = abs(max(eigenvalues)) / abs(min(eigenvalues));
    end
    median_value = median(k_values);
    plot(N, median_value, 'x');
end

xlabel('N (matrix dimension)');
ylabel('\kappa (condition number, median)');
title('Median Condition Number for 100 Tests per Dimension');
hold off;

%% Notes
% The condition number grows roughly linearly with N, reflecting that
% larger random matrices are more likely to have widely spread eigenvalues.
