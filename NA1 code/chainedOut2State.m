function [x, y] = chainedOut2State(z1, z3, T_SIMULATION)
% from chained flat output to input/state

% per la derivata farla offline è meglio, calcolarla a mano in funzione di
% s e poi implementarla su simulink così, non si può usare gradient()
% time law into planning for xy theta, then controllore

% first: calculate z1_dot, z3_dot, with gradient()
%it does not see T_SIMULATION
dim = size(z1,2);
t = T_SIMULATION/dim;


z1_dot = gradient(z1,t);
z3_dot = gradient(z3,t);
z2 = z3_dot./z1_dot;

v1 = z1_dot;

% calculating ddot
z1_ddot = gradient(z1_dot,t);
z3_ddot = gradient(z3_dot,t);

v2 = (z1_ddot.*z3_dot + z1_dot.*z3_ddot)./(v1.^2);


end