% Lab 2 - Exercise 2: Least Squares vs LASSO Regularization
% Neuro-Fuzzy Control
% Konias Odysseas Georgios - 03119166

%% Generate synthetic data
rng(42);                                        % for reproducibility
c = [randn(1,10), zeros(1,60), randn(1,10)];   % sparse true coefficients (80 total)
x = randn(80, 100);                             % 80 features, 100 observations
e = randn(1, 100);                              % noise
y = c * x + 0.5 * e;                           % noisy measurements

%% Reshape for standard regression convention (rows = observations)
X = x.';   % 100 x 80
Y = y.';   % 100 x 1

%% Ordinary Least Squares
% c_ls = (X'X)^{-1} X'Y  (Phi(x) = x)
A    = X.' * X;
b_ls = X.' * Y;
c_ls = A \ b_ls;

figure;
plot(c_ls); hold on; plot(c, 'r--');
legend('Least Squares \hat{c}', 'True c');
title('Least Squares Result');
xlabel('coefficient index');

%% LASSO with 10-fold cross-validation
[B, FitInfo] = lasso(X, Y, 'CV', 10);

figure;
lassoPlot(B, FitInfo, 'PlotType', 'CV');
legend('show');
title('Cross-Validated MSE of LASSO Fit');

%% Select lambda using the 1-SE rule
idxLambda1SE = FitInfo.Index1SE;
c_lasso      = B(:, idxLambda1SE);

fprintf('Lambda MinMSE : %.4f\n', FitInfo.LambdaMinMSE);
fprintf('Lambda 1SE    : %.4f  (selected)\n', FitInfo.Lambda1SE);

figure;
plot(c_lasso); hold on; plot(c, 'r--');
legend('LASSO \hat{c} (Lambda 1SE)', 'True c');
title('LASSO Result for Lambda 1SE');
xlabel('coefficient index');

%% Notes
% LASSO regularization shrinks small/irrelevant coefficients toward zero,
% giving better recovery of the 60 true zeros compared to plain OLS.
