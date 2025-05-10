% clear;
% close;

%% import datas
load("data\prob0.mat");
T_s = 0.04;
%% plots
figure;
plot_unicycle_2D_EKF_filter(prob0.q(:,:),prob0.q_EKF(:,1:3)',prob0.PHI,0);
grid on;
title("Actual vs EKF estimates");
legend("Actual position","EKF position");

figure;
plot_unicycle_2D_EKF_filter(prob0.q_euler(:,:),prob0.q_EKF(:,1:3)',prob0.PHI,0);
grid on;
title("Euler localization vs EKF estimates");
legend("Euler localization ","EKF position");

figure;
plot_unicycle_2D_EKF_filter(prob0.q_RK2(:,:),prob0.q_EKF(:,1:3)',prob0.PHI,0);
grid on;
title("RK2 localization vs EKF estimates");
legend("RK2 localization ","EKF position");

figure;
plot_unicycle_2D_EKF_filter(prob0.q_exact(:,:),prob0.q_EKF(:,1:3)',prob0.PHI,0);
grid on;
title("Exact localization vs EKF estimates");
legend("Exact localization ","EKF position");