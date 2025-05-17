function obstacles(robot_pose)
x = [-2.90, -1.60, -1.50, -1.40, -0.60, 0.20, 1.00, 1.45, 1.80, 2.20, 2.90];
y = [-1.50, -1.10, -0.70, -0.30, -0.20, 0.10, 0.20, 1.50];

% figure(1);
hold on;
axis equal;
grid on;
xlabel('x [m]');
ylabel('y [m]');
title('TurtleBot Environment');

% First gray square
fill([x(3), x(5), x(5), x(3)], [y(3), y(3), y(6), y(6)], [0.7 0.7 0.7], ...
     'EdgeColor', 'k', 'FaceAlpha', 0.4);

% Second gray square
fill([x(6), x(7), x(7), x(6)], [y(3), y(3), y(1), y(1)], [0.7 0.7 0.7], ...
     'EdgeColor', 'k', 'FaceAlpha', 0.4);


fill([x(5), x(6), x(6), x(5)], [y(1), y(1), y(6), y(6)], [1 0.6 0.6], 'EdgeColor', 'r', 'FaceAlpha', 0.4);
text(mean([x(5), x(6)]), mean([y(1), y(6)]), 'Red Zone', 'HorizontalAlignment', 'center');

fill([x(7), x(11), x(11), x(7)], [y(1), y(1), y(8), y(8)], [1 0.7 0.4], 'EdgeColor', [1 0.5 0], 'FaceAlpha', 0.4);
text(mean([x(7), x(9)+1]), mean([y(1)+2, y(8)]), 'Orange Zone', 'HorizontalAlignment', 'center');

fill([x(1), x(3), x(3), x(1)], [y(6), y(6), y(8), y(8)], [0.8 0.9 1], 'EdgeColor', 'b', 'FaceAlpha', 0.4);
text(mean([x(1), x(3)]), mean([y(6), y(8)]), 'Initial Area', 'HorizontalAlignment', 'center');

% Goal points
plot(x(2), y(2), 'ko', 'MarkerFaceColor', 'k'); 
% text(x(2), y(2), '  Task 1 Goal');

plot(x(7), y(4), 'ks', 'MarkerFaceColor', 'k');
% text(x(7), y(4), '  Task 2 Goal');

plot(x(8), y(4), 'kd', 'MarkerFaceColor', 'k');
% text(x(8), y(4), '  Task 3 Start');

% Cube for Task 3/4
cube_center = [(x(9) + x(10))/2, (y(5) + y(7))/2];
cube_size = 0.3;
rectangle('Position', [cube_center(1)-cube_size/2, cube_center(2)-cube_size/2, cube_size, cube_size], ...
    'EdgeColor', 'k', 'LineWidth', 2);
% text(cube_center(1), cube_center(2), 'Cube', 'HorizontalAlignment', 'center');

% Optionally plot robot pose
if nargin > 0 && ~isempty(robot_pose)
    plot(robot_pose(1), robot_pose(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    quiver(robot_pose(1), robot_pose(2), 0.3*cos(robot_pose(3)), 0.3*sin(robot_pose(3)), ...
        'r', 'LineWidth', 2, 'MaxHeadSize', 1);
end

end
