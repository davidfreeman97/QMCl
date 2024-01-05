function [value] = reduced_gaussian_kernel(omega_1,omega_2, parametrized_variable)
%Inputs:
    %removes stochastic dimension from 
    omega_1(parametrized_variable) = []; 
    omega_2(parametrized_variable) = [];
    
epsilon = 100;
%value = exp((-1/epsilon)*((omega_1(1)-omega_2(1))^2+(omega_1(2)-omega_2(2))^2 + (omega_1(3)-omega_2(3))^2));
value = exp((-1/epsilon)*(norm(omega_1 - omega_2))^2);
end

