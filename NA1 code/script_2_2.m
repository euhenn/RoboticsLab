clear all;
close all;
addpath(genpath('utils'));
addpath("chained_part2\")
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
z1 = linspace(pi/200,pi/2,100);
z3 = logspace(0,20,100);

[z,input] = chainedOut2State(z1,z3,s);
%test


%%  2.2.1 NOT FINISHED ! !
qi = [-1; -1; pi/2];
qf = [1; 1; pi/2];

ki = 1;
kf = 2;


[x, y] = cartesian_polyn(qi, qf, s, ki, kf);
[z, input] = cartesian_output_2_kin_stateInput(x, y, s);
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