%need do pass the total time by the sampling frequency
function [q,u] = from_traj_to_kinem(z_tot, z_tot_dot, total_time, s_dot,Ts)
%creazione della funzione che riceve la traiettoria desiderata in chained
%form e che restituisce i valori state/input q(t),u(t)
q = zeros(3,(total_time/Ts));
u = zeros(2,(total_time/Ts));

for i = 1:1:total_time/Ts
    z = z_tot(:,i);
    z_dot = z_tot_dot(:,i);

    %matrix transformation
    q2z = [0       , 0        ,1;
           cos(z(1)) , sin(z(1))  ,0;
           sin(z(1)) , -cos(z(1)) ,0];
    
    %we can compute the state 
    q(:,i) = q2z\z;
    % q(1,i) = (z(2) - z(2)*(sin(z(1)))^2 + z(3)*sin(z(1))*cos(z(1)))/cos(z(1));
    % q(2,i) = z(2)*sin(z(1)) - z(3)*cos(z(1));
    % q(3,i) = z(1);

    
    %we can compute the input
    omega = z_dot(1)*s_dot(i);
    v = (z_dot(2) + omega*z(3))*s_dot(i);
    u(:,i) = [v;omega];

end
end