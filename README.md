# Neuro-Fuzzy Control — Lab Code


## Files

| File | Description |
|------|-------------|
| `lab1_ex1_fuzzy_train_controller.m` | Mamdani FIS for train speed control (Lab 1, Ex.1) |
| `lab1_ex1_fuzzy_train_controller_with_force.m` | Extended FIS with external force handling |
| `lab1_ex2a_lyapunov_cvx.m` | Common Lyapunov matrix via CVX SDP (Lab 1, Ex.2A) |
| `lab1_ex2b_switched_system_response.m` | Switched system simulation (Lab 1, Ex.2B) |
| `lab2_ex1_ar_model_crossvalidation.m` | AR model order selection via 12-fold CV (Lab 2, Ex.1) |
| `lab2_ex2_least_squares_vs_lasso.m` | OLS vs LASSO regularization (Lab 2, Ex.2) |
| `lab3_ex1_gradient_descent.m` | Gradient descent implementation (Lab 3, Ex.1) |
| `lab3_ex1_newtons_method.m` | Newton's method implementation (Lab 3, Ex.1) |
| `lab3_ex2_illconditioned_gd_momentum.m` | Ill-conditioned GD and momentum method (Lab 3, Ex.2) |
| `lab3_ex3_condition_number_vs_dimension.m` | Condition number vs matrix dimension (Lab 3, Ex.3) |
| `lab3_ex4_relu_nn_piecewise.m` | ReLU network for piecewise-linear function (Lab 3, Part 2, Ex.1) |

## Notes
- Lab 1, Ex.1 requires the Fuzzy Logic Toolbox and a Simulink model for the closed-loop simulation.
- Lab 1, Ex.2A requires [CVX](http://cvxr.com/cvx/).
- Lab 2, Ex.1 requires the System Identification Toolbox and the `el_lo_des` dataset loaded in the workspace.
- Lab 2, Ex.2 requires the Statistics and Machine Learning Toolbox.
- Lab 3, Ex.1–2 require the Symbolic Math Toolbox.
