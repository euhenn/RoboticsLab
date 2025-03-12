% MAIN PARAMETERS AND VALUES
total_time = 100;
qi = [0,0,-pi/3]';
qf = [1,1,pi/3]';

% TRANSFORMATION FROM CARTESIAN TO CHAINED
zi = [qi(3);
    qi(1)*cos(qi(3)) + qi(2)*sin(qi(3));
    qi(1)*sin(qi(3)) - qi(2)*cos(qi(3));
    ];

zf = [qf(3);
    qf(1)*cos(qf(3)) + qf(2)*sin(qf(3));
    qf(1)*sin(qf(3)) - qf(2)*cos(qf(3));
    ];

if(zi(1)==zf(1))
    zf(1) = zi(1) + (2*pi);
end

% DETERMINATION OF THE PARAMETERS OF THE POLYNOMIAL FUNCTION
a = [zf(1),zi(1)];
b = [zf(3) , zi(3) , zf(2)*(zf(1)-zi(1)) - 3*zf(3) , zi(2)*(zf(1)-zi(1)) + 3*zi(3)];


z1 = a(1)*s - a(2)*(s-1);
z3 = b(1)*(s^3) - b(2)*((s-1)^3) + b(3)*(s-1)*(s^2) + b(4)*s*((s-1)^2);
z2 = (b(1)*(s^2)*3 - b(2)*((s-1)^2)*3 + b(3)*(s^2 + 2*(s-1)*s) + b(4)*((s-1)^2 + s*2*(s-1)))/(a(1) - a(2));
z_dot = (b(1)*(s)*6 - b(2)*((s-1))*6 + b(3)*(s*2 + 4*s-2) + b(4)*((s-1)*2 + s*4-2))/((a(1) - a(2))^2);
