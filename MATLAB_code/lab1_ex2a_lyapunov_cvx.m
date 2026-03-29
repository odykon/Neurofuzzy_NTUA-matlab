% Lab 1 - Exercise 2A: Lyapunov Stability via CVX (SDP)
% Neuro-Fuzzy Control
% Konias Odysseas Georgios - 03119166
%
% Finds a common Lyapunov matrix P for the switched system with matrices
% A1 and A2, by solving the SDP:
%   A_i' * P * A_i - P <= -I,  P >= I
% using CVX (http://cvxr.com/cvx/).

%% Test for various values of 'a'
a_values = [-5, -3, -2, -1, -0.5, -0.3, -0.1, 0, 0.1, 0.3, 0.5, 1, 3, 5];

for a = a_values
    A1 = [0.9  a ; 0   0.8];
    A2 = A1';           % A2 = [0.9 0; a 0.8]
    n  = length(A1);

    cvx_begin sdp quiet
        variable P(n,n) symmetric
        A1' * P * A1 - P <= -eye(n)  %#ok<NODEF>
        A2' * P * A2 - P <= -eye(n)
        P >= eye(n)
    cvx_end

    fprintf('a = %5.2f  |  status: %s\n', a, cvx_status);
    if strcmp(cvx_status, 'Solved')
        disp(P);
    end
end

%% Notes
% If cvx_status == 'Solved', stability is guaranteed by the Lyapunov
% function V(x) = x'*P*x for the switched system.
% Results from the report:
%   Feasible  : |a| <= 0.5
%   Infeasible: |a| >= 1
