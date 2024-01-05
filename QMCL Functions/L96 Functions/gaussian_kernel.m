function [value] = gaussian_kernel(omega_1,omega_2)
%Inputs:
    %omega_1, omega_2 - vectors in R^3
    

%NOTE: Gaussian Kernel is obselete now! we use dmat 
epsilon = 7;



%previously 15
value = exp((-1/epsilon)*(norm(omega_1 - omega_2))^2);
%value = exp((-1/epsilon)*((omega_1(1)-omega_2(1))^2+(omega_1(2)-omega_2(2))^2));
end

