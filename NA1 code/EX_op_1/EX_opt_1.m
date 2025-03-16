%% Definition of the parameters 
r = 0.03; % wheel radius 
d = 0.165; % wheel distance 
a = 0;
b = 2;

x_0 = 1;
y_0 = 1;
theta_0 = 0;

%% run sim
out=sim("Experiment1_optional_simulink.slx");

%% Plotting 

time = out.q.time(:,1);

%fist subplot
x = out.q.signals(1).values;
y = out.q.signals(2).values;
theta = out.q.signals(3).values;
figure;
subplot(2,2,1);
plot(time, x, 'r', time, y, 'b', time, theta, 'g');
grid on;
xlabel('Time[s]');
ylabel('q');
legend('x', 'y', 'theta');

%second subplot
v = out.u.signals(1).values;
w = out.u.signals(2).values;
subplot(2,2,3);
plot(time, v, 'r', time, w, 'b');
grid on;
xlabel('Time[s]');
ylabel('u');
legend('v', 'w');

%third subplot
z1 = out.z.signals(1).values;
z2 = out.z.signals(2).values;
z3 = out.z.signals(3).values;
subplot(2,2,2);
plot(time, z1, 'r', time, z2, 'b', time, z3, 'g');
grid on;
xlabel('Time[s]');
ylabel('z');
legend('z1', 'z2', 'z3');

%forth subplot
v1 = out.v.signals(1).values;
v2 = out.v.signals(2).values;
subplot(2,2,4);
plot(time, v1, 'r', time, v2, 'b');
grid on;
xlabel('Time[s]');
ylabel('v');
legend('v1', 'v2');



