clear all;
close all;
addpath(genpath('utils'));
addpath("cartesian_part2\")
%% Set simulation parameters
r = 0.03;
d = 0.165;
T_SIMULATION = 25;
Q_INITIAL = [0;0;0];

%% Set input
OMEGA_L = 1;
OMEGA_R = 1;

%%  2
% scuffed timing law:
Ts = 0.01;
s = linspace(Ts, 1, 1/Ts)

%%
addpath("cartesian_part2\")
x = linspace(0,10,1000);
y = logspace(0,20,1000);

[q,input] = cartesian_output_2_kin_stateInput(x,y,s);
%test


%%  2.1.1
qi = [-1; -1; pi/2];
qf = [1; 1; pi/2];

ki = 1;
kf = 2;


[x, y] = cartesian_polyn(qi, qf, s, ki, kf);
[q, input] = cartesian_output_2_kin_stateInput(x, y, s);
close all;
plot_unicycle_2D(q, s)

%% 2.1.2

qi = [-2; -0.2; -pi];
qf = [1; 1; -3*pi/4];

ki = 1;
kf = 5;


[x, y] = cartesian_polyn(qi, qf, s, ki, kf);
[q, input] = cartesian_output_2_kin_stateInput(x, y, 1);
close all;
plot_unicycle_2D(q, Ts)