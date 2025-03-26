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
r_used=r;
d_used=d;

zoh_activation=1;%2=on 1=off

% wheels angles init
PHI_INIT = [0;0];

prob_gps_loss = 1.0;    % 0.0 to 1.0 loss probability for GPS where 0 = no loss; defined p_loss in notes
%% Eight-shape trajectory parameters
R = 0.4;
omega_trj = 2*pi;
% EKF parameters
ENCODER_QUANTIZATION = 1;

% EKF initil covariance
P_INIT_EKF = diag([0.001, 0.001, 0.0175/6, 0.0175/6, 0.0175/6, 0.0175/6*T_s, 0.0175/6*T_s].^2);
% EKF process covariance
D = diag([0.001, 0.001, 0.0175/6, 0.0175/6, 0.0175/6, 0.0175/6*T_s, 0.0175/6*T_s].^2);

R_2 = diag([ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6].^2);                         %(delta wheels angles)
R_3 = diag(([0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);                %(GPS(1 value) + delta wheels angles)
R_4 = diag(([0.001, 0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);         %(GPS(2 values) + delta wheels angles)
R_5 = diag(([0.001, 0.001, 0.001, ENCODER_QUANTIZATION/6,ENCODER_QUANTIZATION/6]).^2);  %(GPS(3 values) + delta wheels angles)

%% Get an eight-shaped geometric path (1.1)

%uniform time law
mode = 1;           
[s, s_dot] = time_law_fn(t,total_time,mode);%modify the formula so you can put Tacc and Tcostatnt as input

%trajectory
x=R*sin(2*omega_trj.*s);
y=R*sin(omega_trj.*s);

%trajectory analitic derivatives
x_dot = R*2*omega_trj*cos(2*omega_trj*s);
y_dot = R*omega_trj*cos(omega_trj*s);

x_ddot = R*4*omega_trj*omega_trj*(-sin(2*omega_trj*s));
y_ddot = R*omega_trj*omega_trj*(-sin(omega_trj*s));


% Plot the trajectory
figure(1);
plot(x, y);

%% 1.2 (differential flatness)

%differential flatness
[q, input] = cartesian_output_2_kin_stateInput(x,y,x_dot,y_dot,x_ddot,y_ddot);

%plot q
plot_unicycle_2D(q, 1/T_s);


%% simulink settings
% set Q_INIT to the initial q (will be used as initialization in simulink)
Q_INIT = [q(1,1), q(2,1), q(3,1)]';         % Initial pose

% set also Q_INIT_LOC (eventually with initial error)
Q_INIT_LOC  = Q_INIT;    % Initial pose for localization

% set also Z_INIT_EKF (eventually with initial error)
Z_INIT_EKF  = [0; 0; 0; 0; 0; 0; 0];        % Initial EKF state vector

PHI_INIT    = [0; 0];                       % Initial wheels angles

%% 1.3 (simulink+trap s)

mode=2;%set mode for trap s

out=sim("Sim_localization.slx");% start simulation

%plot data
figure(2);
clf;
subplot(1,3,1);%plot s_dot
plot(out.s_dot_sim.time, out.s_dot_sim.signals.values, 'b');
title('s\_dot');
xlabel('Time [s]');
ylabel('s\_dot');
grid on;


subplot(1,3,2);%ploc x,y des/sim
hold on;
plot(out.q_sim.signals.values(:,2), out.q_sim.signals.values(:,1), 'r', 'DisplayName', 'Sim');
plot(out.q_des_sim.signals.values(:,2), out.q_des_sim.signals.values(:,1), 'b--', 'DisplayName', 'Des');
hold off;
title('Trajectory x-y');
xlabel('y');
ylabel('x');
legend;
grid on;

subplot(1,3,3);%plot theta des/sim
hold on;
plot(out.q_sim.time, out.q_sim.signals.values(:,3), 'r', 'DisplayName', '\theta Sim');
plot(out.q_des_sim.time, out.q_des_sim.signals.values(:,3), 'b--', 'DisplayName', '\theta Des');
hold off;
title('Theta');
xlabel('Time [s]');
ylabel('\theta [rad]');
legend;
grid on;

%% 1.4

zoh_activation=2;%2=on 1=off

%measure from differents ts
T_s=0.04;
sim1=sim("Sim_localization.slx");% start simulation

T_s=0.1;
sim2=sim("Sim_localization.slx");% start simulation

T_s=0.001;
sim3=sim("Sim_localization.slx");% start simulation

%plot resoults
figure(3);
subplot(2,3,1);%ploc x,y of 3 measure
hold on;
plot(sim1.q_sim.signals.values(:,2), sim1.q_sim.signals.values(:,1), 'r', 'DisplayName', 'Ts=0.04');
plot(sim2.q_sim.signals.values(:,2), sim2.q_sim.signals.values(:,1), 'b--', 'DisplayName', 'Ts=0.1');
plot(sim3.q_sim.signals.values(:,2), sim3.q_sim.signals.values(:,1), 'g:', 'DisplayName', 'Ts=0.001');
hold off;
title('Trajectory x-y');
xlabel('y');
ylabel('x');
legend;
grid on;

subplot(2,3,2);%plot theta of 3 measurw
hold on;
plot(sim1.q_sim.time, sim1.q_sim.signals.values(:,3), 'r', 'DisplayName', 'Ts=0.04');
plot(sim2.q_sim.time, sim2.q_sim.signals.values(:,3), 'b--', 'DisplayName', 'Ts=0.1');
plot(sim3.q_sim.time, sim3.q_sim.signals.values(:,3), 'g:', 'DisplayName', 'Ts=0.001');
hold off;
title('Theta');
xlabel('Time [s]');
ylabel('\theta [rad]');
legend;
grid on;

subplot(2,3,4);%plot sim err x of 3 sim
hold on;
plot(sim1.sim_err.time, sim1.sim_err.signals.values(1,:), 'r', 'DisplayName', 'Ts=0.04');
plot(sim2.sim_err.time, sim2.sim_err.signals.values(1,:), 'b', 'DisplayName', 'Ts=0.1');
plot(sim3.sim_err.time, sim3.sim_err.signals.values(1,:), 'g', 'DisplayName', 'Ts=0.001');
hold off;
title('Sim error x');
xlabel('Time [s]');
legend;
grid on;

subplot(2,3,5);%plot sim err y of 3 sim
hold on;
plot(sim1.sim_err.time, sim1.sim_err.signals.values(2,:), 'r', 'DisplayName', 'Ts=0.04');
plot(sim2.sim_err.time, sim2.sim_err.signals.values(2,:), 'b', 'DisplayName', 'Ts=0.1');
plot(sim3.sim_err.time, sim3.sim_err.signals.values(2,:), 'g', 'DisplayName', 'Ts=0.001');
hold off;
title('Sim error y');
xlabel('Time [s]');
legend;
grid on;

subplot(2,3,6);%plot sim err theta of 3 sim
hold on;
plot(sim1.sim_err.time, sim1.sim_err.signals.values(3,:), 'r', 'DisplayName', 'Ts=0.04');
plot(sim2.sim_err.time, sim2.sim_err.signals.values(3,:), 'b', 'DisplayName', 'Ts=0.1');
plot(sim3.sim_err.time, sim3.sim_err.signals.values(3,:), 'g', 'DisplayName', 'Ts=0.001');
hold off;
title('Sim error \theta');
xlabel('Time [s]');
legend;
grid on;

%% 1.5

zoh_activation=2;%2=on 1=off

%measure from differents ts without init errors
Q_INIT_LOC  = Q_INIT;    % Initial pose for localization

T_s=0.04;
sim1=sim("Sim_localization.slx");% start simulation

T_s=0.1;
sim2=sim("Sim_localization.slx");% start simulation

T_s=0.001;
sim3=sim("Sim_localization.slx");% start simulation

%plot resoults
figure(4);

subplot(3,3,1);%plot sim err x of 3 loc strat Ts=0.04
hold on;
plot(sim1.q_euler_err.time, sim1.q_euler_err.signals.values(1,:), 'r', 'DisplayName', 'Euler');
plot(sim1.q_rk2_err.time, sim1.q_rk2_err.signals.values(1,:), 'b--', 'DisplayName', 'rk2');
plot(sim1.q_exact_err.time, sim1.q_exact_err.signals.values(1,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error x Ts=0.04');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,2);%plot sim err y of 3 loc strat Ts=0.04
hold on;
plot(sim1.q_euler_err.time, sim1.q_euler_err.signals.values(2,:), 'r', 'DisplayName', 'Euler');
plot(sim1.q_rk2_err.time, sim1.q_rk2_err.signals.values(2,:), 'b--', 'DisplayName', 'rk2');
plot(sim1.q_exact_err.time, sim1.q_exact_err.signals.values(2,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error y Ts=0.04');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,3);%plot sim err theta of 3 loc strat Ts=0.04
hold on;
plot(sim1.q_euler_err.time, sim1.q_euler_err.signals.values(3,:), 'r', 'DisplayName', 'Euler');
plot(sim1.q_rk2_err.time, sim1.q_rk2_err.signals.values(3,:), 'b--', 'DisplayName', 'rk2');
plot(sim1.q_exact_err.time, sim1.q_exact_err.signals.values(3,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error \theta Ts=0.04');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,4);%plot sim err x of 3 loc strat Ts=0.1
hold on;
plot(sim2.q_euler_err.time, sim2.q_euler_err.signals.values(1,:), 'r', 'DisplayName', 'Euler');
plot(sim2.q_rk2_err.time, sim2.q_rk2_err.signals.values(1,:), 'b--', 'DisplayName', 'rk2');
plot(sim2.q_exact_err.time, sim2.q_exact_err.signals.values(1,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error x Ts=0.1');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,5);%plot sim err y of 3 loc strat Ts=0.1
hold on;
plot(sim2.q_euler_err.time, sim2.q_euler_err.signals.values(2,:), 'r', 'DisplayName', 'Euler');
plot(sim2.q_rk2_err.time, sim2.q_rk2_err.signals.values(2,:), 'b--', 'DisplayName', 'rk2');
plot(sim2.q_exact_err.time, sim2.q_exact_err.signals.values(2,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error y Ts=0.1');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,6);%plot sim err theta of 3 loc strat Ts=0.1
hold on;
plot(sim2.q_euler_err.time, sim2.q_euler_err.signals.values(3,:), 'r', 'DisplayName', 'Euler');
plot(sim2.q_rk2_err.time, sim2.q_rk2_err.signals.values(3,:), 'b--', 'DisplayName', 'rk2');
plot(sim2.q_exact_err.time, sim2.q_exact_err.signals.values(3,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error \theta Ts=0.1');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,7);%plot sim err x of 3 loc strat Ts=0.001
hold on;
plot(sim3.q_euler_err.time, sim3.q_euler_err.signals.values(1,:), 'r', 'DisplayName', 'Euler');
plot(sim3.q_rk2_err.time, sim3.q_rk2_err.signals.values(1,:), 'b--', 'DisplayName', 'rk2');
plot(sim3.q_exact_err.time, sim3.q_exact_err.signals.values(1,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error x Ts=0.001');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,8);%plot sim err y of 3 loc strat Ts=0.001
hold on;
plot(sim3.q_euler_err.time, sim3.q_euler_err.signals.values(2,:), 'r', 'DisplayName', 'Euler');
plot(sim3.q_rk2_err.time, sim3.q_rk2_err.signals.values(2,:), 'b--', 'DisplayName', 'rk2');
plot(sim3.q_exact_err.time, sim3.q_exact_err.signals.values(2,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error y Ts=0.001');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,9);%plot sim err theta of 3 loc strat Ts=0.001
hold on;
plot(sim3.q_euler_err.time, sim3.q_euler_err.signals.values(3,:), 'r', 'DisplayName', 'Euler');
plot(sim3.q_rk2_err.time, sim3.q_rk2_err.signals.values(3,:), 'b--', 'DisplayName', 'rk2');
plot(sim3.q_exact_err.time, sim3.q_exact_err.signals.values(3,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error \theta Ts=0.001');
xlabel('Time [s]');
legend;
grid on;


%measure from differents ts with init errors
Q_INIT_LOC  = Q_INIT+[1;1;0];    % Initial pose for localization

T_s=0.04;
sim1=sim("Sim_localization.slx");% start simulation

T_s=0.1;
sim2=sim("Sim_localization.slx");% start simulation

T_s=0.001;
sim3=sim("Sim_localization.slx");% start simulation

%plot resoults
figure(5);

subplot(3,3,1);%plot sim err x of 3 loc strat Ts=0.04
hold on;
plot(sim1.q_euler_err.time, sim1.q_euler_err.signals.values(1,:), 'r', 'DisplayName', 'Euler');
plot(sim1.q_rk2_err.time, sim1.q_rk2_err.signals.values(1,:), 'b--', 'DisplayName', 'rk2');
plot(sim1.q_exact_err.time, sim1.q_exact_err.signals.values(1,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error x Ts=0.04');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,2);%plot sim err y of 3 loc strat Ts=0.04
hold on;
plot(sim1.q_euler_err.time, sim1.q_euler_err.signals.values(2,:), 'r', 'DisplayName', 'Euler');
plot(sim1.q_rk2_err.time, sim1.q_rk2_err.signals.values(2,:), 'b--', 'DisplayName', 'rk2');
plot(sim1.q_exact_err.time, sim1.q_exact_err.signals.values(2,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error y Ts=0.04');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,3);%plot sim err theta of 3 loc strat Ts=0.04
hold on;
plot(sim1.q_euler_err.time, sim1.q_euler_err.signals.values(3,:), 'r', 'DisplayName', 'Euler');
plot(sim1.q_rk2_err.time, sim1.q_rk2_err.signals.values(3,:), 'b--', 'DisplayName', 'rk2');
plot(sim1.q_exact_err.time, sim1.q_exact_err.signals.values(3,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error \theta Ts=0.04');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,4);%plot sim err x of 3 loc strat Ts=0.1
hold on;
plot(sim2.q_euler_err.time, sim2.q_euler_err.signals.values(1,:), 'r', 'DisplayName', 'Euler');
plot(sim2.q_rk2_err.time, sim2.q_rk2_err.signals.values(1,:), 'b--', 'DisplayName', 'rk2');
plot(sim2.q_exact_err.time, sim2.q_exact_err.signals.values(1,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error x Ts=0.1');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,5);%plot sim err y of 3 loc strat Ts=0.1
hold on;
plot(sim2.q_euler_err.time, sim2.q_euler_err.signals.values(2,:), 'r', 'DisplayName', 'Euler');
plot(sim2.q_rk2_err.time, sim2.q_rk2_err.signals.values(2,:), 'b--', 'DisplayName', 'rk2');
plot(sim2.q_exact_err.time, sim2.q_exact_err.signals.values(2,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error y Ts=0.1');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,6);%plot sim err theta of 3 loc strat Ts=0.1
hold on;
plot(sim2.q_euler_err.time, sim2.q_euler_err.signals.values(3,:), 'r', 'DisplayName', 'Euler');
plot(sim2.q_rk2_err.time, sim2.q_rk2_err.signals.values(3,:), 'b--', 'DisplayName', 'rk2');
plot(sim2.q_exact_err.time, sim2.q_exact_err.signals.values(3,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error \theta Ts=0.1');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,7);%plot sim err x of 3 loc strat Ts=0.001
hold on;
plot(sim3.q_euler_err.time, sim3.q_euler_err.signals.values(1,:), 'r', 'DisplayName', 'Euler');
plot(sim3.q_rk2_err.time, sim3.q_rk2_err.signals.values(1,:), 'b--', 'DisplayName', 'rk2');
plot(sim3.q_exact_err.time, sim3.q_exact_err.signals.values(1,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error x Ts=0.001');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,8);%plot sim err y of 3 loc strat Ts=0.001
hold on;
plot(sim3.q_euler_err.time, sim3.q_euler_err.signals.values(2,:), 'r', 'DisplayName', 'Euler');
plot(sim3.q_rk2_err.time, sim3.q_rk2_err.signals.values(2,:), 'b--', 'DisplayName', 'rk2');
plot(sim3.q_exact_err.time, sim3.q_exact_err.signals.values(2,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error y Ts=0.001');
xlabel('Time [s]');
legend;
grid on;

subplot(3,3,9);%plot sim err theta of 3 loc strat Ts=0.001
hold on;
plot(sim3.q_euler_err.time, sim3.q_euler_err.signals.values(3,:), 'r', 'DisplayName', 'Euler');
plot(sim3.q_rk2_err.time, sim3.q_rk2_err.signals.values(3,:), 'b--', 'DisplayName', 'rk2');
plot(sim3.q_exact_err.time, sim3.q_exact_err.signals.values(3,:), 'g:', 'DisplayName', 'Exact');
hold off;
title('loc error \theta Ts=0.001');
xlabel('Time [s]');
legend;
grid on;

%% 1.6

zoh_activation=2;%2=on 1=off

%measure from differents ts without init errors
Q_INIT_LOC  = Q_INIT;    % Initial pose for localization

T_s=0.04;
sim1=sim("Sim_localization.slx");% start simulation

T_s=0.1;
sim2=sim("Sim_localization.slx");% start simulation

%plot resoults
figure(6);

subplot(2,3,1);%plot sim err x of 3 loc strat Ts=0.04
hold on;
plot(sim1.q_euler_err.time, sim1.q_euler_err.signals.values(1,:), 'r', 'DisplayName', 'Euler');
plot(sim1.q_rk2_err.time, sim1.q_rk2_err.signals.values(1,:), 'b--', 'DisplayName', 'rk2');
plot(sim1.q_exact_err.time, sim1.q_exact_err.signals.values(1,:), 'g:', 'DisplayName', 'Exact');
plot(sim1.error_EFK.time, sim1.error_EFK.signals.values(1,:), 'm-.', 'DisplayName', 'EFK');
hold off;
title('loc error x Ts=0.04');
xlabel('Time [s]');
legend;
grid on;

subplot(2,3,2);%plot sim err y of 3 loc strat Ts=0.04
hold on;
plot(sim1.q_euler_err.time, sim1.q_euler_err.signals.values(2,:), 'r', 'DisplayName', 'Euler');
plot(sim1.q_rk2_err.time, sim1.q_rk2_err.signals.values(2,:), 'b--', 'DisplayName', 'rk2');
plot(sim1.q_exact_err.time, sim1.q_exact_err.signals.values(2,:), 'g:', 'DisplayName', 'Exact');
plot(sim1.error_EFK.time, sim1.error_EFK.signals.values(2,:), 'm-.', 'DisplayName', 'EFK');
hold off;
title('loc error y Ts=0.04');
xlabel('Time [s]');
legend;
grid on;

subplot(2,3,3);%plot sim err x of 3 loc strat Ts=0.04
hold on;
plot(sim1.q_euler_err.time, sim1.q_euler_err.signals.values(3,:), 'r', 'DisplayName', 'Euler');
plot(sim1.q_rk2_err.time, sim1.q_rk2_err.signals.values(3,:), 'b--', 'DisplayName', 'rk2');
plot(sim1.q_exact_err.time, sim1.q_exact_err.signals.values(3,:), 'g:', 'DisplayName', 'Exact');
plot(sim1.error_EFK.time, sim1.error_EFK.signals.values(3,:), 'm-.', 'DisplayName', 'EFK');
hold off;
title('loc error \Theta Ts=0.04');
xlabel('Time [s]');
legend;
grid on;

subplot(2,3,4);%plot sim err x of 3 loc strat Ts=0.1
hold on;
plot(sim2.q_euler_err.time, sim2.q_euler_err.signals.values(1,:), 'r', 'DisplayName', 'Euler');
plot(sim2.q_rk2_err.time, sim2.q_rk2_err.signals.values(1,:), 'b--', 'DisplayName', 'rk2');
plot(sim2.q_exact_err.time, sim2.q_exact_err.signals.values(1,:), 'g:', 'DisplayName', 'Exact');
plot(sim2.error_EFK.time, sim2.error_EFK.signals.values(1,:), 'm-.', 'DisplayName', 'EFK');
hold off;
title('loc error x Ts=0.1');
xlabel('Time [s]');
legend;
grid on;

subplot(2,3,5);%plot sim err y of 3 loc strat Ts=0.1
hold on;
plot(sim2.q_euler_err.time, sim2.q_euler_err.signals.values(2,:), 'r', 'DisplayName', 'Euler');
plot(sim2.q_rk2_err.time, sim2.q_rk2_err.signals.values(2,:), 'b--', 'DisplayName', 'rk2');
plot(sim2.q_exact_err.time, sim2.q_exact_err.signals.values(2,:), 'g:', 'DisplayName', 'Exact');
plot(sim2.error_EFK.time, sim2.error_EFK.signals.values(2,:), 'm-.', 'DisplayName', 'EFK');
hold off;
title('loc error y Ts=0.1');
xlabel('Time [s]');
legend;
grid on;

subplot(2,3,6);%plot sim err theta of 3 loc strat Ts=0.1
hold on;
plot(sim2.q_euler_err.time, sim2.q_euler_err.signals.values(3,:), 'r', 'DisplayName', 'Euler');
plot(sim2.q_rk2_err.time, sim2.q_rk2_err.signals.values(3,:), 'b--', 'DisplayName', 'rk2');
plot(sim2.q_exact_err.time, sim2.q_exact_err.signals.values(3,:), 'g:', 'DisplayName', 'Exact');
plot(sim2.error_EFK.time, sim2.error_EFK.signals.values(3,:), 'm-.', 'DisplayName', 'EFK');
hold off;
title('loc error \Theta Ts=0.1');
xlabel('Time [s]');
legend;
grid on;


%measure from differents ts with init errors
Q_INIT_LOC  = Q_INIT+[1;1;0];    % Initial pose for localization

T_s=0.04;
sim1=sim("Sim_localization.slx");% start simulation

T_s=0.1;
sim2=sim("Sim_localization.slx");% start simulation

%plot resoults
figure(7);

subplot(2,3,1);%plot sim err x of 3 loc strat Ts=0.04
hold on;
plot(sim1.q_euler_err.time, sim1.q_euler_err.signals.values(1,:), 'r', 'DisplayName', 'Euler');
plot(sim1.q_rk2_err.time, sim1.q_rk2_err.signals.values(1,:), 'b--', 'DisplayName', 'rk2');
plot(sim1.q_exact_err.time, sim1.q_exact_err.signals.values(1,:), 'g:', 'DisplayName', 'Exact');
plot(sim1.error_EFK.time, sim1.error_EFK.signals.values(1,:), 'm-.', 'DisplayName', 'EFK');
hold off;
title('loc error x Ts=0.04');
xlabel('Time [s]');
legend;
grid on;

subplot(2,3,2);%plot sim err y of 3 loc strat Ts=0.04
hold on;
plot(sim1.q_euler_err.time, sim1.q_euler_err.signals.values(2,:), 'r', 'DisplayName', 'Euler');
plot(sim1.q_rk2_err.time, sim1.q_rk2_err.signals.values(2,:), 'b--', 'DisplayName', 'rk2');
plot(sim1.q_exact_err.time, sim1.q_exact_err.signals.values(2,:), 'g:', 'DisplayName', 'Exact');
plot(sim1.error_EFK.time, sim1.error_EFK.signals.values(2,:), 'm-.', 'DisplayName', 'EFK');
hold off;
title('loc error y Ts=0.04');
xlabel('Time [s]');
legend;
grid on;

subplot(2,3,3);%plot sim err x of 3 loc strat Ts=0.04
hold on;
plot(sim1.q_euler_err.time, sim1.q_euler_err.signals.values(3,:), 'r', 'DisplayName', 'Euler');
plot(sim1.q_rk2_err.time, sim1.q_rk2_err.signals.values(3,:), 'b--', 'DisplayName', 'rk2');
plot(sim1.q_exact_err.time, sim1.q_exact_err.signals.values(3,:), 'g:', 'DisplayName', 'Exact');
plot(sim1.error_EFK.time, sim1.error_EFK.signals.values(3,:), 'm-.', 'DisplayName', 'EFK');
hold off;
title('loc error \Theta Ts=0.04');
xlabel('Time [s]');
legend;
grid on;

subplot(2,3,4);%plot sim err x of 3 loc strat Ts=0.1
hold on;
plot(sim2.q_euler_err.time, sim2.q_euler_err.signals.values(1,:), 'r', 'DisplayName', 'Euler');
plot(sim2.q_rk2_err.time, sim2.q_rk2_err.signals.values(1,:), 'b--', 'DisplayName', 'rk2');
plot(sim2.q_exact_err.time, sim2.q_exact_err.signals.values(1,:), 'g:', 'DisplayName', 'Exact');
plot(sim2.error_EFK.time, sim2.error_EFK.signals.values(1,:), 'm-.', 'DisplayName', 'EFK');
hold off;
title('loc error x Ts=0.1');
xlabel('Time [s]');
legend;
grid on;

subplot(2,3,5);%plot sim err y of 3 loc strat Ts=0.1
hold on;
plot(sim2.q_euler_err.time, sim2.q_euler_err.signals.values(2,:), 'r', 'DisplayName', 'Euler');
plot(sim2.q_rk2_err.time, sim2.q_rk2_err.signals.values(2,:), 'b--', 'DisplayName', 'rk2');
plot(sim2.q_exact_err.time, sim2.q_exact_err.signals.values(2,:), 'g:', 'DisplayName', 'Exact');
plot(sim2.error_EFK.time, sim2.error_EFK.signals.values(2,:), 'm-.', 'DisplayName', 'EFK');
hold off;
title('loc error y Ts=0.1');
xlabel('Time [s]');
legend;
grid on;

subplot(2,3,6);%plot sim err theta of 3 loc strat Ts=0.1
hold on;
plot(sim2.q_euler_err.time, sim2.q_euler_err.signals.values(3,:), 'r', 'DisplayName', 'Euler');
plot(sim2.q_rk2_err.time, sim2.q_rk2_err.signals.values(3,:), 'b--', 'DisplayName', 'rk2');
plot(sim2.q_exact_err.time, sim2.q_exact_err.signals.values(3,:), 'g:', 'DisplayName', 'Exact');
plot(sim2.error_EFK.time, sim2.error_EFK.signals.values(3,:), 'm-.', 'DisplayName', 'EFK');
hold off;
title('loc error \Theta Ts=0.1');
xlabel('Time [s]');
legend;
grid on;

%% 1.7

%change r and d whit the real value
r_used=r_actual;
d_used=d_actual;

%rerun section 1.5 and 1.6

%% 1.8.1

%change p loss
prob_gps_loss=0.01;

%rerun 1.7
%% 1.8.2
%change p loss
prob_gps_loss=0.9;

%rerun 1.7
%% 1.8.3
%change p loss
prob_gps_loss=0.99;

%rerun 1.7



