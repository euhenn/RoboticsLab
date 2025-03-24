clear all;
close all;
%addpath(genpath('path-to-functions'));%uncomment to add the path to your functions

%% Set simulation parameters
T_s = 0.1; 
total_time = 20;
t = 0:T_s:total_time;
r = 0.03;
d = 0.165;
r_actual = 0.031;
d_actual = 0.164;

% wheels angles init
PHI_INIT = [0;0];
%% Eight-shape trajectory parameters
R = 0.4;
omega_trj = 2*pi;
%% EKF parameters
% % EKF initil covariance
% P_INIT_EKF = diag([0.001, 0.001, 0.0175/6, 0.0175/6, 0.0175/6, 0.0175/6*T_s, 0.0175/6*T_s].^2);
% % EKF process covariance
% D = diag([0.001, 0.001, 0.0175/6, 0.0175/6, 0.0175/6, 0.0175/6*T_s, 0.0175/6*T_s].^2);
% % EKF measurement noise (delta wheels angles)
% R_2 = diag([ENCODER_QUANRIZATION/6,ENCODER_QUANRIZATION/6].^2);
% % EKF measurement noise (GPS + delta wheels angles)
% R_4 = diag(([0.001, 0.001, ENCODER_QUANRIZATION/6,ENCODER_QUANRIZATION/6]).^2);

%% Get an eight-shaped geometric path

mode = 2;           
[s, s_dot] = time_law_fn(t,total_time,mode);

x=R*sin(2*omega_trj.*s);
y=R*sin(omega_trj.*s);

x_dot = R*2*omega_trj*cos(2*omega_trj*s);
y_dot = R*omega_trj*cos(omega_trj*s);

x_ddot = R*4*omega_trj*omega_trj*(-sin(2*omega_trj*s));
y_ddot = R*omega_trj*omega_trj*(-sin(omega_trj*s));

[q, input] = cartesian_output_2_kin_stateInput(x,y,x_dot,y_dot,x_ddot,y_ddot);

% plot_unicycle_2D(q, 1/T_s);



%% Sample s and get q trajectory with differential flatness
% set Q_INIT to the initial q (will be used as initialization in simulink)
Q_INIT = [q(1,1), q(2,1), q(3,1)]';
% set also Q_INIT_LOC (eventually with initial error)
% set also Z_INIT_EKF (eventually with initial error)

%% Plot the trajectory

%% Get timing law
