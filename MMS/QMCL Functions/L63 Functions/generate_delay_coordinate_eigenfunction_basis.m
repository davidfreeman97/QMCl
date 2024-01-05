function [phi] = generate_delay_coordinate_eigenfunction_basis(training_data, L, Q)
%Generates a basis of eigenfunctions for the space of classical observables
%on the state space (R^3). 
%Inputs:
    %training_data - 3xn matrix of the training data
%Output:
    %NxL matrix of eigenfunctions (on the training data)
%Note: Creation of eigenfunctions is aginst a Gaussian kernel (for now)

N = length(training_data(1,:));
K = zeros(N-Q,N-Q);
epsilon = 2; 

truncated_training_data = training_data(1:2, :);
G = Q-1;
floor_value = floor(G/2);
ceiling_value = ceil(G/2);
V = zeros(Q, (N-G), 2);

for i=(floor_value + 1):(N-ceiling_value)
    for j=(i-floor_value):(i+ceiling_value)
        V(j,i,:) = truncated_training_data(:,j);
    end
    i
end

K_q = zeros((N-Q), (N-Q)); 


for i=1:(N-Q)
    for j=1:(N-Q)
        for k=1:Q
            K_q(i,j) = K_q(i,j)+two_dimensional_gaussian_kernel(V(k, i, :), V(k, j, :));
        end
    end
    i
end
%matrix representing the kernel 
for i=1:(N-Q)
    for j=1:(N-Q)
        K(i,j) = exp(-K_q(i,j)/(epsilon*Q));
        %K(i,j) = (1/sqrt(N))*gaussian_kernel(training_data(:,i), training_data(:,j));
        %added in the sqrt() retroactively - make sure its correct
        %trying without 1/sqrt(N) to see how it works
    end
    i
end

%Deleted redundant part here

%The eigenvectors (representing eigenfunctions) of K will be
%orthonormal basis we are looking for. We choose the first L of them 
%(ordered by decreasing eigenvalue) where L is the spectral resolution we
%have chosen. 

[V, D] = eigs(K, L);

phi = sqrt(N)*V;
end