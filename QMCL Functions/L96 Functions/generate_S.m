%This function will accept the input 
    %Y - the (classical) observable we want to be randomly drawing from
            %our QM state. This will be a vector of length n (the i'th
            %component is the value of Y evaluated on the i'th training
            %data point).
    % {phi} - the set (cardinality L) of orthonormal basis functions for
            %the space of classical observables. Each is represented by a 
            %vector of length n, where the i'th component is the value of 
            %the that basis function on omega_i. For coding purposes, this will be represented as a nxL matrix 
            %NOTE: Created against a certain kernel, which we are for now choosing to be Gaussian
%and will output 
    % S - the LxL self-adjoint matrix representing the quantum observable 
            %pi(Y)  
            
function [ S ] = generate_S( phi , Y )
N = length(phi(:,1));
L = length(phi(1,:));

%initializes A
A = zeros(L, L);

%creates A, element by element
for i = 1:L 
    for j = 1:L
        sum = 0;
        for n = 1:(N-1)
        sum = sum + phi(n, i) * Y(n) * phi(n,j);
        end
        A(i,j) = (1/N)*sum ;
    end
end

S = (1/2)*(A + transpose(A)); 


