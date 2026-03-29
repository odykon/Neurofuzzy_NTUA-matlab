% Lab 1 - Exercise 1: Fuzzy Train Controller
% Neuro-Fuzzy Control
% Konias Odysseas Georgios - 03119166

%% System parameters
a1 = 1;
a2 = 0.05;
a3 = 0.1;
b = 200;
m = 100;
F = 0;
v_ref = 90;   % desired velocity (m/s)
d = 2000;     % train station distance (m)
a = v_ref/90;

%% Build the Fuzzy Inference System
train = mamfis('Name', 'train');

% --- Input 1: position ---
train = addInput(train, [-10 d+20], 'Name', 'position');
train = addMF(train, 'position', 'trapmf', [-10 0 d-500 d-400], 'Name', 'far');
train = addMF(train, 'position', 'trapmf', [d-400 d-300 d d],   'Name', '400m');
train = addMF(train, 'position', 'trapmf', [d-200 d-100 d d],   'Name', 'close');
train = addMF(train, 'position', 'trimf',  [d-30 d d+30],       'Name', 'very_close');

% --- Input 2: velocity ---
train = addInput(train, [-10 v_ref+50], 'Name', 'velocity');
train = addMF(train, 'velocity', 'trapmf', [-3 -0.5 0.5 3],                          'Name', 'zero');
train = addMF(train, 'velocity', 'trapmf', [0 20 v_ref-10 v_ref],                    'Name', 'slow');
train = addMF(train, 'velocity', 'trimf',  [v_ref-10 v_ref v_ref+10],                'Name', 'good');
train = addMF(train, 'velocity', 'trapmf', [v_ref v_ref+10 v_ref+50 v_ref+50],       'Name', 'fast');

% --- Output: control signal u ---
deceleration = -0.05 * a;
breaking     = -0.2  * a;

train = addOutput(train, [-1 1], 'Name', 'u');
train = addMF(train, 'u', 'trimf', [0.2 0.3 0.4],                                      'Name', 'accelerate');
train = addMF(train, 'u', 'trimf', [deceleration-0.1 deceleration deceleration+0.1],   'Name', 'decelerate');
train = addMF(train, 'u', 'trimf', [breaking-0.05 breaking breaking+0.05],              'Name', 'break');
train = addMF(train, 'u', 'trimf', [-0.1 0 0.1],                                       'Name', 'nothing');

%% Fuzzy rules
rules = [ ...
    "If (position is far) and (velocity is zero) then u is accelerate"; ...
    "If (position is far) and (velocity is slow) then u is accelerate"; ...
    "If (position is far) and (velocity is fast) then u is decelerate"; ...
    "If position is 400m then u is nothing"; ...
    "If (position is close) and (velocity is not zero) then u is decelerate"; ...
    "If (position is very_close) and (velocity is not zero) then u is break" ...
];

train = addRule(train, rules);

%% Display FIS membership functions
figure;
subplot(3,1,1); plotmf(train, 'input', 1); title('Membership Functions for position');
subplot(3,1,2); plotmf(train, 'input', 2); title('Membership Functions for velocity');
subplot(3,1,3); plotmf(train, 'output', 1); title('Membership Function for u');

%% Notes
% After building the FIS, open the Simulink model "train_sim.slx" to run
% the closed-loop simulation. The Simulink model contains:
%   - Train FIS block  (uses the workspace variable 'train')
%   - Train Dynamics block (implements the differential equation)
%
% Train dynamics (continuous-time):
%   a_train = (b*u - (a1 + m*a2)*v*|v| - a3*x/m) / m   (approx.)
%
% Test scenarios used in the report:
%   1. v_ref=90,  d=2000, m=100, F=0
%   2. v_ref=120, d=3000, m=100, F=0
%   3. v_ref=90,  d=2000, m=110, F=0   (10% mass increase)
%   4. v_ref=90,  d=2000, m=100, F=-20 (external opposing force)
