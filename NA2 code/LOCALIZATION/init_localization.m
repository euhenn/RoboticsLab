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

zoh_activation=1;%2=on 1=off

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
Q_INIT = [q(1,1), q(2,1), q(3,1)]';
% set also Q_INIT_LOC (eventually with initial error)
% set also Z_INIT_EKF (eventually with initial error)

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


