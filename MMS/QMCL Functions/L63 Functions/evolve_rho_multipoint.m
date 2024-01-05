function [new_rho] = evolve_rho_multipoint(rho,phi,N, M)
%applies the QM time-evolution operator for one time step. (This yields rho
%conjugated by the Koopman operator, normalized to have trace = 1). 
%Inputs:
    % phi - the set (cardinality L) of orthonormal basis functions for
            %the space of classical observables. Each is represented by a 
            %vector of length n, where the i'th component is the value of 
            %the that basis function on omega_i. For coding purposes, this will be represented as a nxL matrix 
            %NOTE: Created against a certain kernel, which we are for now choosing to be Gaussian
    % rho - LxL matrix representing our current QM state
L = length(phi(1,:));

%turns Koopman operator into a matrix (U)
%This is the old version using the for loop
% U = zeros(L,L);
%     for i = 1:L
%         for j=1:L
%             sum = 0;
%             for k=1:(N-1)
%             sum = sum + phi(k,i)*phi(k+1,j);
%             end
%             U(i,j) = (1/N)*sum;
%         end
%     end

phi_prime = reshape(phi, [N, M*L]); 
psi_prime = [phi_prime(2:N, :); zeros(1, M*L)];
psi = reshape(psi_prime, [N*M, L]); 

U = (transpose(phi)*psi)/(N*M);
%Matrix-ized version 

intermediate = transpose(U)*rho*U;

new_rho = (1/trace(intermediate))*intermediate;

% trace_value = trace(transpose(U)*rho*U);
% 
% new_rho = (1/trace_value)*(transpose(U)*rho*U);
    
end