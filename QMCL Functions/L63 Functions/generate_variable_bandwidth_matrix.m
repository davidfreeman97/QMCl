function [sigma_vector, optimized_epsilon, m_hat] = generate_variable_bandwidth_matrix(data, epsilon_pool, knn, timeshift_amount)
%UNTITLED Summary of this function goes here
%   Inputs:
    %data - The given training data 
    %epsilon_pool: The set of values from which you want to search for an
    %optimal value of epsilon in the kernel construction 
    %knn - number of nearest neighbors to use in calculation
    
    %Outputs:
    %sigma_vector - A vector of the bandwidth function (sigma) values on
    %each x_i in the training data (sigma(x_i)is the ith entry
    %optimized_epsilon - the best epsilon pick for the constant epsilon
    %from the epsilon pool given
    %m_hat - approximate dimension of system
    
    [optimized_epsilon, r_vector, m_hat, K_hat_matrix] = optimize_bandwidth_parameter(data, epsilon_pool, knn, timeshift_amount);
    
    sigma_vector = generate_sigma_vector(data, r_vector, m_hat, optimized_epsilon, K_hat_matrix, timeshift_amount);
    
end

