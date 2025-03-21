%need do pass the total time by the sampling frequency

function [z,z_dot] = from_qiqf_to_chain(qi, qf, total_time, s_dot, s, Ts)
z = zeros(3,total_time/Ts);
z_dot = zeros(3,total_time/Ts);

%initial condition transformation
zi = [qi(3);
    qi(1)*cos(qi(3)) + qi(2)*sin(qi(3));
    qi(1)*sin(qi(3)) - qi(2)*cos(qi(3));
    ];
zf = [qf(3);
    qf(1)*cos(qf(3)) + qf(2)*sin(qf(3));
    qf(1)*sin(qf(3)) - qf(2)*cos(qf(3))
    ];

%to avoid straight trajectory problem
if(zi(1)==zf(1))
    zf(1) = zi(1) + (2*pi);
end

%coefficients of the polynom
a = [zf(1),zi(1)];
b = [zf(3) , zi(3) , zf(2)*(zf(1)-zi(1)) - 3*zf(3) , zi(2)*(zf(1)-zi(1)) + 3*zi(3)];

for i = 1:1:total_time/Ts
    z1 = a(1)*s(i) - a(2)*(s(i)-1);
    z1_dot = a(1) - a(2);
    
    z3 = b(1)*(s(i)^3) - b(2)*((s(i)-1)^3) + b(3)*(s(i)-1)*(s(i)^2) + b(4)*s(i)*((s(i)-1)^2);
    z3_dot = b(1)*(s(i)^2)*3 - b(2)*((s(i)-1)^2)*3 + b(3)*(s(i)^2 + 2*(s(i)-1)*s(i)) + b(4)*((s(i)-1)^2 + s(i)*2*(s(i)-1));
    z3_ddot = b(1)*(s(i))*6 - b(2)*((s(i)-1))*6 + b(3)*(s(i)*2 + 2*(s(i)*2-1)) + b(4)*((s(i)-1)*2 + 2*(s(i)*2-1));
    
    z2 = z3_dot/z1_dot;
    z2_dot = (z3_ddot)/((a(1) - a(2)));
    
    z(:,i) =  [z1;z2;z3];
    z_dot(:,i) = [z1_dot;z2_dot;z3_dot];
    
end
end