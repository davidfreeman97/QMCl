function [phi] = generate_delay_coord_eigenfunction_basis_variable_bandwidth(training_data, L,Q, knn)
%Generates a basis of eigenfunctions for the space of classical observables
%on the space R^Q where Q is the number of values in your delay coordinate
%embedding 

%Inputs:
    %training_data - 3xn matrix of the training data
%Output:
    %NxL matrix of eigenfunctions (on the training data)
%Note: Creation of eigenfunctions is aginst a Gaussian kernel (for now)

N = length(training_data(1,:));
K = zeros(N-2*Q,N-2*Q);
delay_coord_training_data = zeros(((2*Q+1)*length(training_data(:,1))),N-2*Q);

for i=(Q+1):(N-(Q))
intermediate = training_data(:, ((i-Q):(i+Q)));
delay_coord_training_data(:,i-Q) = intermediate(:);
%The Q-shift above centers it on the correct index
end


[sigma_vector, optimized_epsilon, m_hat] = generate_variable_bandwidth_matrix(delay_coord_training_data, 0:.5:40, knn, Q);

fprintf('Optimal Epsilon is...')
optimized_epsilon

fprintf('M_hat is...')
m_hat




for i=1:(N-2*Q)
    for j=1:(N-2*Q)
        K(i,j) = bandwidth_kernel_2(i,j,delay_coord_training_data, 2*Q*optimized_epsilon, sigma_vector, m_hat);
    end
end

[V, D] = eigs(K, L);

phi = sqrt(N-(2*Q))*V;
end
