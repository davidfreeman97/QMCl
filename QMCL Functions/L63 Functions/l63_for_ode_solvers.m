function [dxdydz] = l63_for_ode_solvers(t,y)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
dxdydz = [2.3*y(1)-6.2*y(3)-0.49*y(1)*y(2)-0.57*y(2)*y(3); -62-2.7*y(2)+0.49*((y(1))^2)-0.49*((y(3))^2)+0.14*y(1)*y(3);-0.63*y(1) - 13*y(3) + 0.43*y(1)*y(2) + 0.49*y(2)*y(3)];
end



