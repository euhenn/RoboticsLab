clear;
close;

%% import datas
load("data\prob99.mat");
load("data\prob9.mat");

%% plot the probability loss
figure;
plot_unicycle_2D_EKF_filter(prob9.q(:,:),prob9.q_EKF(:,1:3)',pagetranspose(prob9.PHI),0);
grid on;
title("Actual vs EKF with probability loss 90%");
legend("Actual position","EKF position");
figure;
plot_unicycle_2D_EKF_filter(prob99.q(:,:),prob99.q_EKF(:,1:3)',pagetranspose(prob99.PHI),0);
grid on;
title("Actual vs EKF with probability loss 99%");
legend("Actual position","EKF position");