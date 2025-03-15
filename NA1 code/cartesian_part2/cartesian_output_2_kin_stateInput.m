function [q, input] = cartesian_output_2_kin_stateInput(x,y,x_dot,y_dot,x_ddot,y_ddot)
    % cartesian flat outputs are x,y
    % state: x, y, theta 
    % input: v, w
    
    % first: calculate x_dot, y_dot, x_ddot, y_ddot with gradient()
    %it does not see T_SIMULATION
    % dim = length(s);
    % t = 1/dim;
    % x_dot = gradient(x,t);
    % y_dot = gradient(y,t);
    % x_ddot = gradient(x_dot,t);
    % y_ddot = gradient(y_dot,t);
    
    
    % calculate theta to complete the state:
    theta = atan2(y_dot,x_dot);
    
    % calculate v: (when +/- ?)
    v = sqrt(y_dot.^2 + x_dot.^2);
    
    % omega
    w = (x_dot.*y_ddot - y_dot.*x_ddot)./(y_dot.^2 + x_dot.^2);
    
    q = [x; y; theta];
    input = [v; w];
    %test
end