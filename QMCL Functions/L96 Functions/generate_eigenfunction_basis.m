function [phi] = generate_eigenfunction_basis(training_data, L)
%Generates a basis of eigenfunctions for the space of classical observables
%on the state space (R^3). 
%Inputs:
    %training_data - 3xn matrix of the training data
%Output:
    %NxL matrix of eigenfunctions (on the training data)
%Note: Creation of eigenfunctions is aginst a Gaussian kernel (for now)



epsilon = 10;


N = length(training_data(1,:));
K = zeros(N,N);

%matrix representing the kernel 
%for i=1:N
    %for j=1:N
        %K(i,j) = gaussian_kernel(training_data(:,i), training_data(:,j));
        
        %K(i,j) = (1/sqrt(N))*gaussian_kernel(training_data(:,i), training_data(:,j));
        %%%I think this is wrong^
        
    %end
%end

distance_matrix = dmat(training_data, training_data);
K = exp(-(1/epsilon)*distance_matrix);



%Deleted redundant part here

%The eigenvectors (representing eigenfunctions) of K will be
%orthonormal basis we are looking for. We choose the first L of them 
%(ordered by decreasing eigenvalue) where L is the spectral resolution we
%have chosen. 
 
[V, D] = eigs(K, L);

phi = sqrt(N)*V;
end

