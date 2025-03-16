clear all;
close all;

% MAIN PARAMETERS AND VALUES
total_time = 10;
Ts = 0.01;
t = Ts:Ts:total_time;
qi = [0,0,pi+2*pi/3]';
qf = [1,1,pi/3]';

%to choose the time law
% 1 for the constant velocity
% 2 for the trapezoid
mode = 1;

%run the simulink for chained
% sim("simulink_template_2_3.slx");
% run("simulink_template_2_3.slx");

%run the films animation
[s,s_dot] = time_law_fn(t,total_time,1);

[z,z_dot] = from_qiqf_to_chain(qi,qf,total_time,s_dot,s,Ts);
% [z,z_dot] = from_qiqf_to_chain_with_trasl(qi,qf,total_time,s_dot,s,Ts);

[q,u] = from_traj_to_kinem(z,z_dot,total_time,s_dot,Ts);
animate_unicycle_2D(q,Ts,1);
plot_unicycle_2D(q,1/Ts);