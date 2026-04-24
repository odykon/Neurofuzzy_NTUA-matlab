# Neuro-Fuzzy Control — NTUA Lab Assignments

MATLAB implementations for the Neuro-Fuzzy Control course at the National Technical University of Athens (NTUA).  
**Author:** Konias Odysseas Georgios — 03119166

The three labs cover three areas of modern control: **fuzzy rule-based control**, **system identification & regression**, and **numerical optimisation for neural network training**.

---

## Lab 1 — Fuzzy Control & Lyapunov Stability

**Goal:** Design and analyse controllers that use fuzzy logic and prove closed-loop stability via Lyapunov theory.

### Exercise 1 — Mamdani Fuzzy Train Controller

A Mamdani Fuzzy Inference System (FIS) is designed to bring a train to rest at a station.

| Script | Purpose |
|--------|---------|
| `lab1_ex1_fuzzy_train_controller.m` | Builds the base FIS with two inputs (position, velocity) and one output (control signal *u*) |
| `lab1_ex1_fuzzy_train_controller_with_force.m` | Extends the rule base to handle an external opposing force *F* |

- **Inputs:** position along track, current velocity  
- **Output:** throttle / braking signal *u ∈ [−1, 1]*  
- **Membership functions:** trapezoidal and triangular MFs for regions `far`, `400m`, `close`, `very_close` (position) and `zero`, `very_slow`, `slow`, `good`, `fast` (velocity)  
- **Closed-loop simulation:** runs inside a Simulink model (`train_sim.slx`) that implements the nonlinear train dynamics  
- **Test scenarios:** varying reference speed (90 / 120 km/h), track length, mass (+10%), and external disturbance force
- - **Relation to PID:** this fuzzy controller is an instance of **nonlinear PD control** — the position input acts as the proportional term and the velocity input acts as the derivative term, with the fuzzy rules encoding nonlinear, state-dependent "gains" in place of fixed linear coefficients. The absence of an integral term is why a constant disturbance force requires explicit new rules rather than being rejected automatically.

### Exercise 2 — Stability of a Switched Linear System

A discrete-time switched system `x(n+1) = h₁(x₂)·A₁·x(n) + h₂(x₂)·A₂·x(n)` is analysed for stability.

| Script | Purpose |
|--------|---------|
| `lab1_ex2a_lyapunov_cvx.m` | Finds a **common Lyapunov matrix** P by solving a Semidefinite Programme (SDP) via CVX: `Aᵢᵀ P Aᵢ − P ≼ −I` |
| `lab1_ex2b_switched_system_response.m` | Simulates the state trajectories for 14 values of parameter *a* to visualise convergence / divergence |

- **Key result:** a common Lyapunov function exists (and stability is guaranteed) for |*a*| ≤ 0.5; the SDP is infeasible for |*a*| ≥ 1.

---

## Lab 2 — System Identification & Regularised Regression

**Goal:** Identify data-driven models of dynamical systems and compare classical vs. regularised estimation.

### Exercise 1 — AR Model Order Selection (12-Fold Cross-Validation)

`lab2_ex1_ar_model_crossvalidation.m`

- Fits **AutoRegressive (AR)** models of orders 1–60 to a real time-series (`el_lo_des` dataset) using MATLAB's System Identification Toolbox  
- Selects the best model order via **12-fold cross-validation** with mean-squared error (MSE) criterion  
- Applies the **1-SE rule** to choose a parsimonious model (order 16) and demonstrates overfitting at order 200  
- Produces 150-step-ahead forecasts for the selected models

### Exercise 2 — Ordinary Least Squares vs LASSO Regularisation

`lab2_ex2_least_squares_vs_lasso.m`

- Generates a synthetic sparse regression problem (80 features, only 20 non-zero true coefficients)  
- Compares **OLS** `ĉ = (XᵀX)⁻¹Xᵀy` against **LASSO** with 10-fold cross-validated λ selection (1-SE rule)  
- Shows that LASSO correctly recovers the 60 near-zero coefficients that OLS cannot distinguish from signal

---

## Lab 3 — Optimisation & Neural Networks

**Goal:** Implement and analyse gradient-based optimisation algorithms that underpin neural network training.

### Part 1 — Numerical Optimisation

| Script | Method | Function minimised |
|--------|--------|--------------------|
| `lab3_ex1_gradient_descent.m` | **Gradient Descent** (with step normalisation) | `f(x₁,x₂) = x₁² + (x₂−1)² + (x₁−x₂)⁴` |
| `lab3_ex1_newtons_method.m` | **Newton's Method** (second-order) | same as above |
| `lab3_ex2_illconditioned_gd_momentum.m` | GD vs **Heavy-Ball (Momentum)** | `f(x₁,x₂) = A·x₁² + (1/A)·x₂²` |
| `lab3_ex3_condition_number_vs_dimension.m` | Condition number analysis | Random Hessians of increasing dimension |

Key takeaways:
- Newton's method converges in far fewer iterations than gradient descent on the same problem.
- High condition numbers (large *A*) cause gradient descent to zig-zag; momentum damps the oscillations and recovers fast convergence.

### Part 2 — Neural Networks

`lab3_ex4_relu_nn_piecewise.m`

- Constructs **by hand** a single hidden-layer ReLU network `y = W₂·ReLU(W₁x + b₁) + b₂` that exactly represents a given piecewise-linear function  
- Demonstrates that any piecewise-linear function can be expressed as a finite-width ReLU network with analytically determined weights

---

## Requirements

| Lab | Required MATLAB Toolboxes / Libraries |
|-----|---------------------------------------|
| Lab 1, Ex.1 | Fuzzy Logic Toolbox, Simulink |
| Lab 1, Ex.2A | [CVX](http://cvxr.com/cvx/) (free academic licence) |
| Lab 2, Ex.1 | System Identification Toolbox + `el_lo_des` dataset in workspace |
| Lab 2, Ex.2 | Statistics and Machine Learning Toolbox |
| Lab 3, Ex.1–2 | Symbolic Math Toolbox |

---

## Reports

Full write-ups (problem statements, derivations, and results) are in the PDF reports:

- `Neurofuzzy_lab1_report_03119166.pdf`
- `Neurofuzzy_lab2_report_03119166.pdf`
- `Neurofuzzy_lab3_report_03119166.pdf`
