# Neuro-Fuzzy Control — NTUA Lab Assignments

MATLAB implementations for the Neuro-Fuzzy Control course at NTUA.  
**Author:** Konias Odysseas Georgios — 03119166

---

## Lab 1 — Fuzzy Control & Lyapunov Stability

**Ex.1:** Mamdani FIS to bring a train to rest at a station. Inputs are position and velocity; output is a throttle/brake signal. The controller is an instance of **nonlinear PD control** — position acts as the P term and velocity as the D term, with fuzzy rules encoding state-dependent gains. The lack of an I term is why a constant disturbance force requires explicit rule extensions. Requires Fuzzy Logic Toolbox + Simulink.

**Ex.2:** Lyapunov stability of a discrete-time switched linear system. A common Lyapunov matrix P is found via SDP (CVX). Feasible for |a| ≤ 0.5; infeasible for |a| ≥ 1. Requires [CVX](http://cvxr.com/cvx/).

## Lab 2 — System Identification & Regression

**Ex.1:** AR model order selection for a real time-series using 12-fold cross-validation. Best order chosen by 1-SE rule (order 16). Requires System Identification Toolbox + `el_lo_des` dataset.

**Ex.2:** OLS vs LASSO on a sparse regression problem (80 features, 20 non-zero). LASSO recovers the sparse structure; OLS does not. Requires Statistics and Machine Learning Toolbox.

## Lab 3 — Optimisation & Neural Networks

**Ex.1–3:** Gradient descent, Newton's method, and heavy-ball momentum on ill-conditioned quadratics. Shows how high condition numbers hurt GD and how momentum fixes it. Requires Symbolic Math Toolbox.

**Ex.4:** Single hidden-layer ReLU network constructed analytically to exactly represent a piecewise-linear function.

---

Reports: `Neurofuzzy_lab{1,2,3}_report_03119166.pdf`
