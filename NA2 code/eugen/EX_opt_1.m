clear all; close all; clc;

%% Load data
load('data/ekf_001.mat');
values = out.ekf_001.signals.values;
x_actual = squeeze(values(:,1));
y_actual = squeeze(values(:,2));
x_ekf    = squeeze(values(:,3));
y_ekf    = squeeze(values(:,4));
t        = out.ekf_001.time;

%% Plot
figure;
plot(x_actual, y_actual, 'b-', 'LineWidth', 1.5); hold on;
plot(x_ekf, y_ekf, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
grid on;

title('Actual vs EKF, p loss = 0.01');
legend('Actual position','EKF estimated position');
xlabel('X [m]');
ylabel('Y [m]');

%% Load data
load('data/ekf_090.mat');
values = out.ekf_090.signals.values;
x_actual = squeeze(values(:,1));
y_actual = squeeze(values(:,2));
x_ekf    = squeeze(values(:,3));
y_ekf    = squeeze(values(:,4));
t        = out.ekf_090.time;

%% Plot
figure;
plot(x_actual, y_actual, 'b-', 'LineWidth', 1.5); hold on;
plot(x_ekf, y_ekf, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
grid on;

title('Actual vs EKF, p loss = 0.90');
legend('Actual position','EKF estimated position');
xlabel('X [m]');
ylabel('Y [m]');

%% Load data
load('data/ekf_099.mat');
values = out.ekf_099.signals.values;
x_actual = squeeze(values(:,1));
y_actual = squeeze(values(:,2));
x_ekf    = squeeze(values(:,3));
y_ekf    = squeeze(values(:,4));
t        = out.ekf_099.time;

%% Plot
figure;
plot(x_actual, y_actual, 'b-', 'LineWidth', 1.5); hold on;
plot(x_ekf, y_ekf, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
grid on;

title('Actual vs EKF, p loss = 0.99');
legend('Actual position','EKF estimated position');
xlabel('X [m]');
ylabel('Y [m]');
