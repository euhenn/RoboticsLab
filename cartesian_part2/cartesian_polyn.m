function [x, y] = cartesian_polyn(qi, qf, s, ki, kf)
% s as vector like 0:0.1:1000
a1 = qf(1);
a2 = qi(1);
b1 = qf(2);
b2 = qi(2);

a4 = ki*cos(qi(3)) + 3*qi(1);
a3 = kf*cos(qf(3)) - 3*qf(1);

b4 = ki*sin(qi(3)) + 3*qi(2);
b3 = kf*sin(qf(3)) - 3*qf(2);

x = a1*s.^3 - a2*(s-1).^3 + a3*s.^2.*(s-1) + a4*s.*(s-1).^2;
y = b1*s.^3 - b2*(s-1).^3 + b3*s.^2.*(s-1) + b4*s.*(s-1).^2;

end