clear all;
close all;

%% load parameters
load("OPT1_planned_traj.mat");
actual_measures = load("Tc_30.mat");

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

%% creation of the actual graph

figure
subplot(2,1,1)
plot(actual_measures.sim_Tc_30.tout, [actual_measures.sim_Tc_30.measures.signals.values(:,1:2), unwrap(actual_measures.sim_Tc_30.measures.signals.values(:,3))] ,'LineWidth', 0.6)
grid on
title("Actual position and orientation")
legend({"$x[m]$","$y[m]$", "$\theta[rad]$"}, 'Fontsize',10, 'Location','northeast')
xlabel("time [s]", 'interpreter','latex')

subplot(2,1,2)
plot(actual_measures.sim_Tc_30.tout, actual_measures.sim_Tc_30.measures.signals.values(:,4:5) ,'LineWidth', 0.6)
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
title("Actual trajectory")
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
plot(Planned_traj.q.signals.values(:,1), Planned_traj.q.signals.values(:,2),"LineStyle",":","LineWidth",1.3,"Color","b")
plot(actual_measures.sim_Tc_30.measures.signals.values(:,1), actual_measures.sim_Tc_30.measures.signals.values(:,2) ,"LineWidth",1,"Color","k")
hold off;
grid on
title("Planned and actual path")
legend({"$Planned$","$Actual$"}, 'Fontsize',10, 'Location','northeast')
xlim([-0.6,0.8])
ylim([-0.6,0.8])

% save plot
% set(gcf,'Position',[500 100 300 200]*3);
% fig = gcf;
% exportgraphics(fig,'4.pdf','ContentType','vector');

figure
hold on;
plot(Planned_traj.q.time, Planned_traj.Wheels.signals.values,"LineStyle",":","LineWidth",2,"Color","k")
plot(actual_measures.sim_Tc_30.tout, actual_measures.sim_Tc_30.measures.signals.values(:,4:5) ,"LineWidth",0.6,"Color","b")
hold off;
grid on
title("Planned and actual wheels speed")
legend({"$Planned$","$Actual$"}, 'Fontsize',10, 'Location','northeast')


% save plot
% set(gcf,'Position',[500 100 300 200]*3);
% fig = gcf;
% exportgraphics(fig,'4.pdf','ContentType','vector');