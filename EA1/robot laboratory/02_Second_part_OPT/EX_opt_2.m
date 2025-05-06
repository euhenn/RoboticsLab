clc
clear all;
close all;

addpath(genpath("../../methods"));% import metods
addpath(genpath("../../EA1"));% import folder with code

%%
%nominal parameters
r_nom = 0.03;
d_nom = 0.165;
d = d_nom;
r = r_nom;
omega_max = 10;

%time
Ts = 0.04;
T_s = 0.04;

prob_gps_loss = 0;    % 0.0 to 1.0 loss probability for GPS where 0 = no loss; defined p_loss in notes

%% EKF parameters
Q_INIT = [-0.5;-0.5;pi/2];
% Initial EKF state vector
Z_INIT_EKF  = [-0.5; -0.5; pi/2; 0; 0; 0; 0];
% EKF initial covariance
P_INIT_EKF = diag([0.001, 0.001, 0.0175/6, 0.0175/6, 0.0175/6, 0.0175/6*Ts, 0.0175/6*Ts].^2);

ENCODER_QUANTIZATION = 1;

% EKF process noice covariance
D = diag([0.001, 0.001, 0.0175/6, 0.0175/6, 0.0175/6, 0.0175/6*Ts, 0.0175/6*Ts].^2);

% EKF measurement noise
R_2 = diag([ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6].^2);                         %(delta wheels angles)
R_5 = diag(([0.001, 0.001, 0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);  %(GPS(3 values) + delta wheels angles)


%%  2.2 Test Locatization strategies (integration and EFK) by simulating collected data. 
% In the EKF consider also possible measurement loss. 
% Simulate all the time law configurations and evaluate eventual differences.
load("..\measurements\Tc_18.mat")
Tc = 18;               % constant velocity time (both for constant and trapezoidal time law)         
Ta = 1;                % acceleration-deceleration time
total_time = 2*Ta + Tc; 
q = sim_Tc_18.measures.signals.values(:,1:3);   % [x, y, theta]
omega_wheels = sim_Tc_18.measures.signals.values(:,4:5);  % [omega_R, omega_L]

% offset removal (not needed i guess)
q0 = q(1,:);   % initial position [x0, y0, theta0]
q(:,1) = q(:,1) - q0(1);  % subtract initial x
q(:,2) = q(:,2) - q0(2);  % subtract initial y
q(:,3) = q(:,3) - q0(3);  % subtract initial theta

% Now q starts exactly from [0; 0; 0]

% Update the measurements to use the shifted q
measurements = sim_Tc_18.measures;
measurements.signals.values(:,1:3) = q;

Q_INIT = [0; 0; 0];       % since we shifted everything
Q_INIT_LOC  = Q_INIT;
Z_INIT_EKF = [0; 0; 0; 0; 0; 0; 0];

PHI_INIT = [0; 0];
sim("dummy.slx")
%%

figure(1);
subplot(3,1,1)
plot(data_Exact(:,2), data_Exact(:,1))
title("Localization Exact");
grid on;
xlabel("X [m]" );
ylabel("Y [m]" );

subplot(3,1,2)
plot(data_RK(:,2), data_RK(:,1))
title("Localization RK");
grid on;
xlabel("X [m]" );
ylabel("Y [m]" );

subplot(3,1,3)
title("Localization Euler");
plot(data_Euler(:,2), data_Euler(:,1))
grid on;
xlabel("X [m]" );
ylabel("Y [m]" );

%%
load("..\measurements\Tc_30.mat")
load("..\measurements\Tc_45.mat")
