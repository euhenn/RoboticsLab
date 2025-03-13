%% Definition of the variables we will need in the Simulink

T_SIM = 60;            % simulation time 
t_law = 1;              % choice of timing law (0:constant, 1:trapezoidal)
T_c = 20;               % constant velocity time (both for constant and trapezoidal time law)         
T_a = 1;                % acceleration-deceleration time

diff_flatness = 0;      % choice of input interpretation (0:cartesian, 1:chained form)
reorientation = 0;      % in case of chained form, choice of a translation (0:no translation, 1:translation) 

q_i = [-1, -1, pi/2];
q_f = [1, 1, pi/2];
k_i = 10;
k_f = 10; 
k_sign = sign(k_i);

%% Call of the function that calculates the trajectory given the initial and final conditions

if (diff_flatness == 0)
    y = planTrajectoryCartesianPolynomials(q_i, q_f, k_i, k_f);
else 
    y = planTrajectoryChainedForm(q_i, q_f, reorientation);
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

function [y] = planTrajectoryChainedForm(q_i, q_f, reorientation)

    if (reorientation == 0)

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


