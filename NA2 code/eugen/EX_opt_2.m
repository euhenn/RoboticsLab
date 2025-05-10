clear all; close all; clc;

%% Load data
load('data/ekf_dist_001.mat');
values = out.data.signals.values;
x_actual = squeeze(values(:,1));
y_actual = squeeze(values(:,2));
x_ekf    = squeeze(values(:,3));
y_ekf    = squeeze(values(:,4));

%% Plot
figure;
plot(x_actual, y_actual, 'b-', 'LineWidth', 1.5); hold on;
plot(x_ekf, y_ekf, 'ro', 'MarkerSize', 3, 'MarkerFaceColor', 'r');
grid on;

title('Actual vs EKF, var = 0.01');
legend('Actual position','EKF estimated position');
xlabel('X [m]');
ylabel('Y [m]');


%% Load data
load('data/ekf_dist_0001.mat');
values = out.data.signals.values;
x_actual = squeeze(values(:,1));
y_actual = squeeze(values(:,2));
x_ekf    = squeeze(values(:,3));
y_ekf    = squeeze(values(:,4));

%% Plot
figure;
plot(x_actual, y_actual, 'b-', 'LineWidth', 1.5); hold on;
plot(x_ekf, y_ekf, 'ro', 'MarkerSize', 3, 'MarkerFaceColor', 'r');
grid on;

title('Actual vs EKF, var = 0.001');
legend('Actual position','EKF estimated position');
xlabel('X [m]');
ylabel('Y [m]');

%% Load data
load('data/ekf_dist_00001.mat');
values = out.data.signals.values;
x_actual = squeeze(values(:,1));
y_actual = squeeze(values(:,2));
x_ekf    = squeeze(values(:,3));
y_ekf    = squeeze(values(:,4));

%% Plot
figure;
plot(x_actual, y_actual, 'b-', 'LineWidth', 1.5); hold on;
plot(x_ekf, y_ekf, 'ro', 'MarkerSize', 3, 'MarkerFaceColor', 'r');
grid on;

title('Actual vs EKF, var = 0.0001');
legend('Actual position','EKF estimated position');
xlabel('X [m]');
ylabel('Y [m]');