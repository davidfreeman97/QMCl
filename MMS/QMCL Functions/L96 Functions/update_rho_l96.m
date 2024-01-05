function [new_rho] = update_rho(rho,phi, new_x, training_data, nx, epsilon)
%%% NEW update_rho WITH MATRIX OPERATIONS 


%The Quantum-Bayes rule step. Updates rho based on new_x (the covariate of
    %the new omega). 
%Inputs: 
    %rho - LxL matrix 
    %new_x - a vector in R^2 (for the L63 case)
    %training_data - 3xn matrix (of our training data)
    %phi - NxL matrix 
%Note: Currently uses a Gaussian kernel 

%epsilon is a small scaling factor in our kernel 

L = length(phi(1,:));
N = length(phi(:,1));

%F will be our length n vector defining the function F = k(new_x,-) (the
%values of the vector are F evaluated on the training datapoints)
F = zeros(N,1);
x_matrix = training_data(1:nx, :);


for i=1:N
   %I think this was an error!
   %F(i,1) = exp((-1/epsilon)*((x_matrix(1,i)-new_x(1))^2+(x_matrix(1,i)-new_x(2))^2));
   F(i,1) = exp((-1/epsilon)*((norm(new_x - x_matrix(:,i)))^2));
end

F_matrix = repmat(F, 1,L);
phi_prime = phi.*F_matrix; 
G = (1/N)*(phi.')*phi_prime; %Review derivation of this line
trace_value = trace(G*rho*G); 
new_rho = (1/trace_value)*G*rho*G;    
end
