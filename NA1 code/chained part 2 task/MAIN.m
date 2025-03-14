clear all;
close all;

% MAIN PARAMETERS AND VALUES
total_time = 10;
Ts = 0.01;
qi = [0,0,-pi/3]';
qf = [1,1,pi/3]';
% qi = [0,0,-pi/3]';
% qf = [1,1,pi/3]';

%run the simulink for chained
% sim("simulink_template_2_3.slx");
% run("simulink_template_2_3.slx");

%run the films animation
[s,s_dot] = time_law_fn(total_time,1,Ts);
[z,z_dot] = from_qiqf_to_chain(qi,qf,total_time,s_dot,s,Ts);
[q,u] = from_traj_to_kinem(z,z_dot,total_time,s_dot,Ts);
animate_unicycle_2D(q,Ts,1);