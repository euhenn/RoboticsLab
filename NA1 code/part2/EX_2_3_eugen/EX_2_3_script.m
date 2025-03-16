%% Definition of the parameters
r = 0.03; % wheel radius
d = 0.165; % wheel distance
a = 1;
b = 1;

%% Definition of the variables we will need in the Simulink

T_SIM = 60;             % simulation time
t_law = 1;              % choice of timing law (0:constant, 1:trapezoidal)
T_c = 50;               % constant velocity time (both for constant and trapezoidal time law)
T_a = 1;                % acceleration-deceleration time



%% Definition of test cases

%diff_flatness (0:cartesian, 1:chained form)
%translation  (0:no translation, 1:translation) 

%2.1.1
test_cases(1) = struct('diff_flatness', 0, 'translation', 0, ...
                       'q_i', [-1, -1, pi/2], 'q_f', [1, 1, pi/2], ...
                       'k_i', 10, 'k_f', 10);
%2.1.1 different k                  
test_cases(2) = struct('diff_flatness', 0, 'translation', 0, ...
                       'q_i', [-1, -1, pi/2], 'q_f', [1, 1, pi/2], ...
                       'k_i', 15, 'k_f', 5);
%2.1.2 + re-orientation
test_cases(3) = struct('diff_flatness', 0, 'translation', 0, ...
                       'q_i', [-1, -1, pi/2], 'q_f', [1, 1, -pi/2], ...
                       'k_i', 11, 'k_f', 10);
%2.1.2 different k + re-orientation
test_cases(4) = struct('diff_flatness', 0, 'translation', 0, ...
                       'q_i', [-1, -1, pi/2], 'q_f', [1, 1, -pi/2], ...
                       'k_i', 15, 'k_f', 5);
%2.2.1
test_cases(5) = struct('diff_flatness', 1, 'translation', 0, ...
                       'q_i', [0, 0, -pi/3], 'q_f', [1, 1, pi/3], ...
                       'k_i', 10, 'k_f', 10);
%2.2.2                  
test_cases(6) = struct('diff_flatness', 1, 'translation', 0, ...
                       'q_i', [0, 0, 5*pi/3], 'q_f', [1, 1, pi/3], ...
                       'k_i', 10, 'k_f', 10);
%2.2.3
test_cases(7) = struct('diff_flatness', 1, 'translation', 0, ...
                       'q_i', [1, 1, -pi/3], 'q_f', [2, 2, pi/3], ...
                       'k_i', 10, 'k_f', 10);
%2.2.4 + re-orientation
test_cases(8) = struct('diff_flatness', 1, 'translation', 0, ...
                       'q_i', [1, 1, -pi/3], 'q_f', [1, 1, pi/3], ...
                       'k_i', 10, 'k_f', 10);
%2.2.5 translation
test_cases(9) = struct('diff_flatness', 1, 'translation', 1, ...
                       'q_i', [1, 1, -pi/3], 'q_f', [2, 2, pi/3], ...
                       'k_i', 10, 'k_f', 10);
%2.2.5 translation + re-orientation
test_cases(10) = struct('diff_flatness', 1, 'translation', 1, ...
                       'q_i', [1, 1, -pi/3], 'q_f', [1, 1, pi/3], ...
                       'k_i', 10, 'k_f', 10);

%% Run simulations for all test cases
test_case_labels = ["2.1.1", "2.1.1 different k", "2.1.2 + re-orientation", ...
                    "2.1.2 different k + re-orientation", "2.2.1", "2.2.2", ...
                    "2.2.3", "2.2.4 + re-orientation", "2.2.5 translation", ...
                    "2.2.5 translation + re-orientation"];


figure;

% running all test cases
for i = 1:length(test_cases)
    fprintf('Running Test Case %s...\n', test_case_labels(i));
    
    % get parameters from the exercise case
    diff_flatness = test_cases(i).diff_flatness;
    translation = test_cases(i).translation;
    q_i = test_cases(i).q_i;
    q_f = test_cases(i).q_f;
    k_i = test_cases(i).k_i;
    k_f = test_cases(i).k_f;
    k_sign = sign(k_i);
    
    % Plan trajectory
    if diff_flatness == 0
        y = planTrajectoryCartesianPolynomials(q_i, q_f, k_i, k_f);
    else
        y = planTrajectoryChainedForm(q_i, q_f, translation);
    end
    
    % Simulate
    out = sim("EX_2_3_simulink.slx");

    % get data
    time = out.q.time(:,1);
    x = out.q.signals(1).values;
    y = out.q.signals(2).values;
    x_exp = out.q_exp.signals(1).values;
    y_exp = out.q_exp.signals(2).values;

    % subplot
    subplot(2, 5, i);
    plot(x, y, 'b', 'LineWidth', 2); hold on;
    plot(x_exp, y_exp, 'r--', 'LineWidth', 2);
    hold off;
    grid on;
    xlabel('X position'); ylabel('Y position');
    title(sprintf('ex:%s', test_case_labels(i)));
    legend('Simulated', 'Expected');
end



%% Definition of functions

function [y] = planTrajectoryCartesianPolynomials(q_i, q_f, k_i, k_f)

y(1,1) = q_f(1);
y(1,2) = q_i(1);
y(1,3) = k_f * cos(q_f(3)) - 3 * q_f(1);
y(1,4) = k_i * cos(q_i(3)) + 3 * q_i(1);

y(2,1) = q_f(2);
y(2,2) = q_i(2);
y(2,3) = k_f * sin(q_f(3)) - 3 * q_f(2);
y(2,4) = k_i * sin(q_i(3)) + 3 * q_i(2);

end

function [y] = planTrajectoryChainedForm(q_i, q_f, translation)

if (translation == 0)

    z_i = [q_i(3), q_i(1)*cos(q_i(3))+q_i(2)*sin(q_i(3)), q_i(1)*sin(q_i(3))-q_i(2)*cos(q_i(3))];
    z_f = [q_f(3), q_f(1)*cos(q_f(3))+q_f(2)*sin(q_f(3)), q_f(1)*sin(q_f(3))-q_f(2)*cos(q_f(3))];
else

    z_i = [q_i(3), 0, 0];
    z_f = [q_f(3), (q_f(1)-q_i(1))*cos(q_f(3))+(q_f(2)-q_i(2))*sin(q_f(3)), (q_f(1)-q_i(1))*sin(q_f(3))-(q_f(2)-q_i(2))*cos(q_f(3))];
end

y(1,1) = z_f(1);
y(1,2) = z_i(1);

y(2,1) = z_f(3);
y(2,2) = z_i(3);
y(2,3) = z_f(2) * (z_f(1) - z_i(1)) - 3 * z_f(3);
y(2,4) = z_i(2) * (z_f(1) - z_i(1)) - 3 * z_i(3);

end