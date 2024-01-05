function [sigma_vector] = generate_sigma_vector(data, r_vector, m_hat, epsilon, K_hat_matrix, timeshift_amount )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

N = length(data(1,:));
scaled_r_vector = zeros(N,1);
dummy = ones(N,1);

for i=1:N
scaled_r_vector(i) = 1/((N - 2*timeshift_amount)*((pi*epsilon*(r_vector(i)^2))^(m_hat/2)));
end

sigma_vector = scaled_r_vector.*(K_hat_matrix*dummy);


end

