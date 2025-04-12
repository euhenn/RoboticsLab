function [q, u] = cartesian_output_2_kin_stateInput(x,y,x_dot,y_dot,x_ddot,y_ddot,s_dot)
    theta = atan2(y_dot,x_dot);

    %   v
    v = s_dot.*sqrt(y_dot.^2 + x_dot.^2);
    
    %   omega
    w = s_dot.*(x_dot.*y_ddot - y_dot.*x_ddot)./(y_dot.^2 + x_dot.^2);

    q = [x; y; unwrap(theta)];
    u = [v; w];
end