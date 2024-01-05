function [new_rho] = evolve_rho(rho,phi)
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
N = length(phi(:,1));

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


%Matrix-ized version 
phi_1 = phi(1:(N-1), :);
phi_2 = phi(2:N, :);
U = ((phi_1).')*phi_2;
trace_value = trace(transpose(U)*rho*U);

new_rho = (1/trace_value)*(transpose(U)*rho*U);
    
end