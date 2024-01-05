function [sum] = sum_against_kernel(classical_state, phi, training_data, phi_index)
N = length(phi(:,1));
intermediate = 0; 
for k=1:N
    intermediate = intermediate + gaussian_kernel(classical_state, training_data(:,k))*phi(k, phi_index); 
end

sum=intermediate;