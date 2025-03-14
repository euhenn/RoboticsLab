function [x, y, x_dot, y_dot, x_ddot, y_ddot] = eight_traj(t, A, B, omega_x, omega_y)
    %8-shaped trajectory using a Lissajous curve    
    %trajectory (Lissajous curve)
    x = A*sin(omega_x*t);
    y = B*sin(2*omega_y*t);

    %first derivatives
    x_dot = A*omega_x*cos(omega_x*t);
    y_dot = 2*B*omega_y*cos(2*omega_y*t);
    %second derivatives
    x_ddot = -A*omega_x^2*sin(omega_x*t);
    y_ddot = -4*B*omega_y^2*sin(2*omega_y*t);
    
    % Plot the trajectory
    figure;
    plot(x, y, 'b', 'LineWidth', 2);
    xlabel('X Position');
    ylabel('Y Position');
    title('Eight-Shaped Trajectory');
    axis equal;
    grid on;
end

