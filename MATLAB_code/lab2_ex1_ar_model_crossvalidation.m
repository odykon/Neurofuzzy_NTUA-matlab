% Lab 2 - Exercise 1: AR Model Order Selection via 12-Fold Cross-Validation
% Neuro-Fuzzy Control
% Konias Odysseas Georgios - 03119166
%
% Assumes the time-series 'el_lo_des' is already loaded in the workspace.
% (Load your dataset before running this script.)

%% Quick forecast example (order = 10, arbitrary window)
train_start = 500;
train_end   = 1000;
pred_size   = 150;

train_batch    = el_lo_des(train_start:train_end).';
model          = ar(train_batch, 10);
forecast_batch = iddata(train_batch);

figure;
subplot(2,1,1);
forecast(model, forecast_batch, pred_size);
title('150-Step Ahead Forecast (order=10)');
subplot(2,1,2);
plot(el_lo_des(train_start : train_end+pred_size));
title('Real data');

%% 12-fold cross-validation to choose AR model order
k          = 12;
batch_size = floor(length(el_lo_des) / k);
max_order  = 60;

validationErrors = zeros(k-1, max_order);

for fold = 1 : k-1
    train_start_cv = 1;
    train_end_cv   = fold * batch_size;
    test_start_cv  = train_end_cv + 1;
    test_end_cv    = test_start_cv + batch_size - 1;

    train_batch_cv = el_lo_des(train_start_cv : train_end_cv).';
    test_batch_cv  = el_lo_des(test_start_cv  : test_end_cv ).';

    for order = 1 : max_order
        model_cv       = ar(train_batch_cv, order);
        forecast_cv    = iddata(train_batch_cv);
        p              = forecast(model_cv, forecast_cv, batch_size);
        y_pred         = p.y;
        validationErrors(fold, order) = round(mean((test_batch_cv - y_pred).^2));
    end
end

MeanValidationError = round(mean(validationErrors));

figure;
plot(1:max_order, MeanValidationError, '-o');
xlabel('AR order'); ylabel('MSE');
title('Mean Squared Error for 12-Fold Cross-Validation (order 1 to 60)');
[~, best_order] = min(MeanValidationError);
fprintf('Best order by min MSE: %d\n', best_order);
fprintf('Selected order (1-SE rule): 16\n');

%% Example forecasts for order=16 and order=200
for ord = [16, 200]
    model_ex       = ar(train_batch, ord);
    forecast_ex    = iddata(train_batch);
    figure;
    forecast(model_ex, forecast_ex, pred_size);
    title(['150-Step Ahead Forecast  order=' num2str(ord)]);
end
