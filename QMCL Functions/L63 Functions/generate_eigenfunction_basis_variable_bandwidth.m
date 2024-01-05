function [phi] = generate_eigenfunction_basis_variable_bandwidth(training_data, L, optimal_epsilon, sigma_vector)
%Generates a basis of eigenfunctions for the space of classical observables
%on the state space (R^3). 
%Inputs:
    %training_data - 3xn matrix of the training data
    %sigma_vector - the vector of values of the bandwidth function on the
    %training datapoints
    %optimal_epsilon - the epsilon value generated through the automatic
    %procedure
%Output:
    %NxL matrix of eigenfunctions (on the training data)
%Note: Creation of eigenfunctions is aginst a Gaussian kernel (for now)

%used until 2/1/22



sigma_vector_squared = sigma_vector.*sigma_vector; 
%Need because bandwidth kernel square roots the vector elements
N = length(training_data(1,:));
K = zeros(N,N);

%matrix representing the kernel 
for i=1:N
    for j=1:N
        K(i,j) = bandwidth_kernel(i,j,training_data, optimal_epsilon, sigma_vector_squared);
        %1/sqrt(N) ???
    end
end

%distance_matrix = dmat(training_data, training_data);
%K = exp(-(1/epsilon)*distance_matrix);


%The eigenvectors (representing eigenfunctions) of K will be
%orthonormal basis we are looking for. We choose the first L of them 
%(ordered by decreasing eigenvalue) where L is the spectral resolution we
%have chosen. 

[V, D] = eigs(K, L);

phi = sqrt(N)*V;
end

