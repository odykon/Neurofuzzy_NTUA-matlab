% Lab 1 - Exercise 1 (Extended): Fuzzy Train Controller with External Force
% Neuro-Fuzzy Control
% Konias Odysseas Georgios - 03119166
%
% Run lab1_ex1_fuzzy_train_controller.m first to build the base FIS,
% then run this script to add the 'very_slow' membership function and
% update the rules for robustness against an external opposing force F.

%% (Re-)build base FIS if not already in workspace
if ~exist('train','var')
    run('lab1_ex1_fuzzy_train_controller.m');
end

%% Add 'very_slow' membership function for velocity
train = addMF(train, 'velocity', 'trapmf', [0 0 10 20], 'Name', 'very_slow');

%% Updated fuzzy rules (robust to external force)
rules_updated = [ ...
    "If (position is far) and (velocity is zero) then u is accelerate"; ...
    "If (position is far) and (velocity is slow) then u is accelerate"; ...
    "If (velocity is fast) then u is decelerate"; ...
    "If position is 400m and (velocity is slow) then u is decelerate"; ...
    "If position is 400m and (velocity is very_slow) then u is accelerate"; ...
    "If (position is close) and (velocity is not zero) then u is decelerate"; ...
    "If (position is very_close) and (velocity is not zero) then u is break" ...
];

% Clear old rules and add updated set
train = addRule(train, rules_updated);

%% External force parameter (set in Train Dynamics Simulink block)
F = -20;  % N, opposing direction of motion

%% Display updated velocity membership functions
figure;
plotmf(train, 'input', 2);
title('Updated Membership Functions for velocity (with very\_slow)');

%% Notes
% Test scenario used in the report:
%   v_ref=120, d=2500, F=-20, m=110
