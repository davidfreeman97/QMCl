function [quantum_state] = embed_classical_state_as_quantum_state(classical_state, phi, training_data, epsilon)
%phi = matrix of data driven basis functions
%classical state = vector in R^3
L = length(phi(1,:));
%Outdated to dmat!
%K = gaussian_kernel(classical_state, classical_state);
%Also - this value is just 1...so we can replace it with 1 everywhere

% for i=1:L
%     for j = 1:L
%         quantum_state(i,j) = (sum_against_kernel(classical_state, phi, training_data, i)*sum_against_kernel(classical_state, phi, training_data, j))/K;
%     end
%     i
% end
sum_against_kernel_vec = zeros(L,1); 
for i=1:L
    sum_against_kernel_vec(i,1) = sum_against_kernel(classical_state, phi, training_data, i, epsilon);
end

quantum_state = sum_against_kernel_vec*transpose(sum_against_kernel_vec);

