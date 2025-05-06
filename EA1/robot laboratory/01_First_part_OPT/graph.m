clear all;
close all;
clc;
%% load parameters
load("OPT1_planned_traj.mat");
actual_measures = load("post_id_report.mat");

set(groot, 'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(gca,'TickLabelInterpreter','latex');

%% creation of the planning plots
figure
hold on
subplot(2,1,1)
plot(Planned_traj.tout, Planned_traj.q.signals.values ,'LineWidth', 0.6)
grid on
title("Planned position and orientation")
legend({"$x[m]$","$y[m]$", "$\theta[rad]$"}, 'Fontsize',10, 'Location','northeast')
xlabel("time [s]", 'interpreter','latex')

subplot(2,1,2)
plot(Planned_traj.tout, Planned_traj.Wheels.signals.values ,'LineWidth', 0.6)
grid on
title("Wheels velocities")
legend({"Right wheel[rad/s]", "Left wheel[rad/s]"}, 'Fontsize',10, 'Location','northeast')
xlabel("time [s]", 'interpreter','latex')
ylim([min([Planned_traj.Wheels.signals.values(:,1);Planned_traj.Wheels.signals.values(:,2)]) max([Planned_traj.Wheels.signals.values(:,1);Planned_traj.Wheels.signals.values(:,2)])+4])
hold off

% save plot
% set(gcf,'Position',[500 100 300 200]*3);
% fig = gcf;
% exportgraphics(fig,'1.pdf','ContentType','vector');

figure
plot(Planned_traj.q.signals.values(:,1), Planned_traj.q.signals.values(:,2) ,'LineWidth', 0.6)
title("Planning trajectory")
grid on
ylabel("y [m]")
xlabel("x [m]")

% save plot
% set(gcf,'Position',[500 100 300 200]*3);
% fig = gcf;
% exportgraphics(fig,'2.pdf','ContentType','vector');

%% creation of the Post identification graph

figure
subplot(2,1,1)
plot(actual_measures.out.tout, [actual_measures.out.q.signals.values(:,1:2), unwrap(actual_measures.out.q.signals.values(:,3))] ,'LineWidth', 0.6)
grid on
title("Post identification position and orientation")
legend({"$x[m]$","$y[m]$", "$\theta[rad]$"}, 'Fontsize',10, 'Location','northeast')
xlabel("time [s]", 'interpreter','latex')

subplot(2,1,2)
plot(actual_measures.out.tout, actual_measures.out.wheels.signals.values(:,1:2) ,'LineWidth', 0.6)
grid on
title("Wheels velocities")
legend("Right wheel[rad/s]", "Left wheel[rad/s]", 'Fontsize',10, 'Location','northeast')
xlabel("time [s]", 'interpreter','latex')
ylim([min([Planned_traj.Wheels.signals.values(:,1);Planned_traj.Wheels.signals.values(:,2)]) max([Planned_traj.Wheels.signals.values(:,1);Planned_traj.Wheels.signals.values(:,2)])+4])


% save plot
% set(gcf,'Position',[500 100 300 200]*3);
% fig = gcf;
% exportgraphics(fig,'3.pdf','ContentType','vector');

figure
plot(Planned_traj.q.signals.values(:,1), Planned_traj.q.signals.values(:,2) ,'LineWidth', 0.6)
title("Post identification trajectory")
grid on
ylabel("y [m]")
xlabel("x [m]")

% save plot
% set(gcf,'Position',[500 100 300 200]*3);
% fig = gcf;
% exportgraphics(fig,'4.pdf','ContentType','vector');

%% creation of the comparison plots

figure
hold on;
plot(Planned_traj.q.signals.values(:,1), Planned_traj.q.signals.values(:,2),"Color","r")
plot(actual_measures.out.q.signals.values(:,1), actual_measures.out.q.signals.values(:,2),"k--")
hold off;
grid on
title("Planned and Post identification path")
legend({"$Planned$","$Actual$"}, 'Fontsize',10, 'Location','northeast')
xlim([-0.6,0.8])
ylim([-0.6,0.8])

% save plot
% set(gcf,'Position',[500 100 300 200]*3);
% fig = gcf;
% exportgraphics(fig,'4.pdf','ContentType','vector');

figure
hold on;
plot(Planned_traj.q.time, Planned_traj.Wheels.signals.values(:,1),"r")
plot(actual_measures.out.tout, actual_measures.out.wheels.signals.values(:,1) ,"k")
hold off;
grid on
title("Planned Before and Post identification left wheel speed")
legend({"Before Identification","After Identification"}, 'Fontsize',10, 'Location','northeast')


% save plot
% set(gcf,'Position',[500 100 300 200]*3);
% fig = gcf;
% exportgraphics(fig,'4.pdf','ContentType','vector');