clear all;
close all;
addpath(genpath('utils'));

%% Set simulation parameters
T_SIM = 15.0; %todo implement total sim time
T_s = 0.04;

omega_M = 10;

r_nominal = 0.03;
d_nominal = 0.165;
r = r_nominal;
d = d_nominal;
r_actual = r_nominal;
d_actual = d_nominal;
% r_actual = 0.0302;
% d_actual = 0.1694;

%   positions
x = [-2.90, -1.60, -1.50, -1.40, -0.60, 0.20, 1.00, 1.45, 1.80, 2.20, 2.90];
y = [-1.50, -1.10, -0.70, -0.30, -0.20, 0.10, 0.20, 1.50];
% desired configuration
q_d = [x(2);y(2);0];
% initial configuration
Q_INIT = [x(1)+0.5;y(8)-0.5;-pi/2];

%% EKF parameters
p_loss = 0;    % 0.0 to 1.0 loss probability for GPS where 0 = no loss; defined p_loss in note
ENCODER_QUANTIZATION = 1;

Z_INIT_EKF  = [Q_INIT; 0; 0; 0; 0];    % Initial EKF state vector

% EKF initial covariance
P_INIT_EKF = diag([0.101, 0.101, 0.101, 0.0175/6, 0.0175/6, 0.0175/6*T_s, 0.0175/6*T_s].^2);

% EKF process noice covariance
D = diag([0.001, 0.001, 0.001, 0.0175/6, 0.0175/6, 0.0175/6*T_s, 0.0175/6*T_s].^2);

% EKF measurement noise
R_2 = diag([ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6].^2);                         %(delta wheels angles)
R_3 = diag(([0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);                %(GPS(1 value) + delta wheels angles)
R_4 = diag(([0.001, 0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);         %(GPS(2 values) + delta wheels angles)
R_5 = diag(([0.001, 0.001, 0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);  %(GPS(3 values) + delta wheels angles)
%% Set controller parameters

% posture
k_1 = 1;
k_2 = 1;
k_3 = 0.1;
control_par = [k_1, k_2, k_3];

%%  plotting
addpath(genpath('..\graphs'));
plotter_pose_xyth(pose_xyth);