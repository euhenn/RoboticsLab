clc
clear all;
close all;
%start from folder robotics labs
addpath(genpath("methods"));% inport metods
addpath(genpath("EA1"));% inport folder with code
%%

%nominal parameters
r_nom = 0.03;
d_nom = 0.165;
omega_max = 10;

%time
Ts = 0.04;

Ta = 1;
Tc = 30;
total_time = 2*Ta + Tc;
t = 0:Ts:total_time;
%trajectory
R = 0.4;
omega_trj = 2*pi;
mode = 2;           
[s, s_dot] = time_law_fn(t,total_time,mode,Ta,Tc);

%% Get an eight-shaped geometric path (1.1)

%trajectory
x=R*sin(2*omega_trj.*s);
y=R*sin(omega_trj.*s);

%trajectory analitic derivatives
x_dot = R*2*omega_trj*cos(2*omega_trj*s);
y_dot = R*omega_trj*cos(omega_trj*s);

x_ddot = R*4*omega_trj*omega_trj*(-sin(2*omega_trj*s));
y_ddot = R*omega_trj*omega_trj*(-sin(omega_trj*s));

% %% simulation
% sim("robot_LAB__1_3.slx");

%   v
v = s_dot.*sqrt(y_dot.^2 + x_dot.^2);

%   omega
w = s_dot.*(x_dot.*y_ddot - y_dot.*x_ddot)/(y_dot.^2 + x_dot.^2);


omega_L = (2*v - d_nom*w) ./ (2*r_nom);
omega_R = (2*v + d_nom*w) ./ (2*r_nom);

%%  [☑] 1.8 Run the experiment with different control law configurations ️

% Tc=30;
% total_time = 2*Ta + Tc;
% t = 0:Ts:total_time;
% out = sim('robot_LAB__2.slx');
% sim_Tc_30=out;
% 
% 
% Tc=18;
% total_time = 2*Ta + Tc;
% t = 0:Ts:total_time;
% out = sim('robot_LAB__2.slx');
% sim_Tc_18=out;
% 
% 
% Tc=45;
% total_time = 2*Ta + Tc;
% t = 0:Ts:total_time;
% out = sim('robot_LAB__2.slx');
% sim_Tc_45=out;


%% Initial conditions
load(fullfile("EA1/robot laboratory/measurements/", 'Tc_30.mat'));
Q_INIT      = sim_Tc_30.measures.signals.values(1,1:3)';                % Initial pose
PHI_INIT    = [0; 0];                   % Initial wheels angles
Q_INIT_LOC  = sim_Tc_30.measures.signals.values(1,1:3)';                % Initial pose for localization
Z_INIT_EKF  = [sim_Tc_30.measures.signals.values(1,1:3)'; 0; 0; 0; 0];    % Initial EKF state vector

%k = 0                  % 0 = forward, 1 = backwards

flag_GPS = 1;           % 0 = GPS OFF, 1 = GPS ON
prob_gps_loss = 0.99;    % 0.0 to 1.0 loss probability for GPS where 0 = no loss; defined p_loss in notes
%% EKF parameters
ENCODER_QUANTIZATION = 1;

% EKF initial covariance
P_INIT_EKF = diag([0.001, 0.001, 0.0175/6, 0.0175/6, 0.0175/6, 0.0175/6*Ts, 0.0175/6*Ts].^2);

% EKF process noice covariance
D = diag([0.001, 0.001, 0.0175/6, 0.0175/6, 0.0175/6, 0.0175/6*Ts, 0.0175/6*Ts].^2);

% EKF measurement noise
R_2 = diag([ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6].^2);                         %(delta wheels angles)
R_3 = diag(([0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);                %(GPS(1 value) + delta wheels angles)
R_4 = diag(([0.001, 0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);         %(GPS(2 values) + delta wheels angles)
R_5 = diag(([0.001, 0.001, 0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);  %(GPS(3 values) + delta wheels angles)

%%  2.1 Use data collected with Tc = 30 [sec] to identify robot parameters and calibrate the robot and motion capture
run("id_template.m")

fprintf('Uncalibrated estimates:\n');
fprintf('r = %.4f [m]\n', r_unconstrained_hat);
fprintf('d = %.4f [m]\n\n', d_unconstrained_hat);

fprintf('Calibrated estimates:\n');
fprintf('r = %.4f [m]\n', r_cal_hat);
fprintf('d = %.4f [m]\n', d_cal_hat);
fprintf('x offset = %.4f [m]\n', x_off_cal_hat);
fprintf('y offset = %.4f [m]\n', y_off_cal_hat);
fprintf('Orientation offset = %.4f [rad]\n', offset_hat);


fprintf('Calibration error statistics:\n');
fprintf('Mean error X: %.4f, Std: %.4f, Original Std: %.4f\n', mean_E_X, std_E_X, std_X);
fprintf('Mean error Y: %.4f, Std: %.4f, Original Std: %.4f\n', mean_E_Y, std_E_Y, std_Y);
fprintf('Mean error Theta: %.4f, Std: %.4f, Original Std: %.4f\n', mean_E_theta, std_E_theta, std_theta);

%%  2.2 Test Locatization strategies (integration and EFK) by simulating collected data. 
% In the EKF consider also possible measurement loss. 
% Simulate all the time law configurations and evaluate eventual differences.
d = d_nom;
r = r_nom;
