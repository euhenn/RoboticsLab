clear all;
close all;
addpath(genpath('utils'));

%% Set simulation parameters
r = 0.03;
d = 0.165;
T_SIMULATION = 25;
Q_INITIAL = [0;0;0];

%% Set input
OMEGA_L = 1;
OMEGA_R = 1;

%%
addpath("..\cartesian_part2\")
total_time = 1;
Ts = 0.01;
t = 0:Ts:total_time;

A = 5;
B = 5;
omega_x = 2*pi;
omega_y = 2*pi;
[x, y, x_dot, y_dot, x_ddot, y_ddot] = eight_traj(t, A, B, omega_x, omega_y);

[q, input] = cartesian_output_2_kin_stateInput(x, y, x_dot, y_dot, x_ddot, y_ddot);

input_v = [t.', input(1,:).'];
input_w = [t.', input(2,:).'];

% input_v = input(1,:).';
% input_w = input(2,:).';



