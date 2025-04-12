clear all;
close all;

addpath(genpath("../methods"));% inport metods
addpath(genpath("../EA1"));% inport folder with code
%%
%nominal parameters
r_nom = 0.03;
d_nom = 0.165;
omega_max = 10;

%time
Ts = 0.04;
total_time = 40;
t = 0:Ts:total_time;
Ta = 1;
Tc = 30;

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
    