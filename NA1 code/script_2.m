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
x = linspace(0,10,1000);
y = logspace(0,20,1000);

[q,input] = cartesian_output_2_kin_stateInput(x,y,T_SIMULATION);
%test
