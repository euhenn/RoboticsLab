function [x, y,x_dot,y_dot,x_ddot,y_ddot] = cartesian_polyn(qi, qf, s, ki, kf)
    % s as vector like 0:0.1:1000
    %evaluate the weight as written in the slide
    a1 = qf(1);
    a2 = qi(1);
    b1 = qf(2);
    b2 = qi(2);
    
    a4 = ki*cos(qi(3)) + 3*qi(1);
    a3 = kf*cos(qf(3)) - 3*qf(1);
    
    b4 = ki*sin(qi(3)) + 3*qi(2);
    b3 = kf*sin(qf(3)) - 3*qf(2);
    
    % evaluate path
    x = a1*s.^3 - a2*(s-1).^3 + a3*s.^2.*(s-1) + a4*s.*(s-1).^2;
    y = b1*s.^3 - b2*(s-1).^3 + b3*s.^2.*(s-1) + b4*s.*(s-1).^2;

    %analitical calculation of velocity
    x_dot=3*a1*s.^2-3*a2*(s-1).^2+a3*(2*s.*(s-1)+s.^2)+a4*((s-1).^2+s.*2.*(s-1));
    y_dot=3*b1*s.^2-3*b2*(s-1).^2+b3*(2*s.*(s-1)+s.^2)+b4*((s-1).^2+s.*2.*(s-1));

    %analitical calculation of acceleration
    x_ddot=6*a1*s-6*a2*(s-1)+a3*(2*s+2*(s+(s-1)))+a4*(2*(s-1)+2*((s-1)+s));
    y_ddot=6*b1*s-6*b2*(s-1)+b3*(2*s+2*(s+(s-1)))+b4*(2*(s-1)+2*((s-1)+s));

end