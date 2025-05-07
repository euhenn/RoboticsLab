clear all;
close all;
addpath(genpath('utils'));

%% Set simulation parameters
Ts = 0.04;
T_s = 0.04;
%if we are online w/ EKF
ekf_online = 1;

r_nominal = 0.03;
d_nominal = 0.165;
r = r_nominal;
d = d_nominal;
r_actual = r_nominal;
d_actual = d_nominal;
% r_actual = 0.0302;
% d_actual = 0.1694;
omega_M = 12;

controller_index = 2; % 1->cartesian, 2->posture
flg_replanning = true;
% desired configuration
q_d = [2;2;0];
% initial configuration
Q_INIT = [0;0;0];
% simulation time
T_SIM = 20;


%% EKF parameters
%ekf settings
flag_GPS = 1;           % 0 = GPS OFF, 1 = GPS ON
prob_gps_loss = 0;    % 0.0 to 1.0 loss probability for GPS where 0 = no loss; defined p_loss in note
ENCODER_QUANTIZATION = 1;

Z_INIT_EKF  = [Q_INIT; 0; 0; 0; 0];    % Initial EKF state vector
% EKF initial covariance
P_INIT_EKF = diag([0.001, 0.001, 0.0175/6, 0.0175/6, 0.0175/6, 0.0175/6*Ts, 0.0175/6*Ts].^2);

% EKF process noice covariance
D = diag([0.001, 0.001, 0.0175/6, 0.0175/6, 0.0175/6, 0.0175/6*Ts, 0.0175/6*Ts].^2);

% EKF measurement noise
R_2 = diag([ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6].^2);                         %(delta wheels angles)
R_3 = diag(([0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);                %(GPS(1 value) + delta wheels angles)
R_4 = diag(([0.001, 0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);         %(GPS(2 values) + delta wheels angles)
R_5 = diag(([0.001, 0.001, 0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);  %(GPS(3 values) + delta wheels angles)
%% Set controller parameters
if controller_index == 1
    % cartesian
    k_1 = 10; 
    k_2 = 10;
    control_par = [k_1, k_2, 0];
else
    % posture
    k_1 = 1; 
    k_2 = 1;
    k_3 = 0.1;
    control_par = [k_1, k_2, k_3];
end

