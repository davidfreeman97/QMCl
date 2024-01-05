function [new_rho] = rho_initialization(rho,phi, initial_omega, training_data)
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
%was using up until 2/1/22
%epsilon = .1;
epsilon = .1;

L = length(phi(1,:));
N = length(phi(:,1));

%F will be our length n vector defining the function F = k(new_x,-) (the
%values of the vector are F evaluated on the training datapoints)
F = zeros(N,1);
%x_matrix = training_data;


for i=1:N
   %I think this was an error!
   %F(i,1) = exp((-1/epsilon)*((x_matrix(1,i)-new_x(1))^2+(x_matrix(1,i)-new_x(2))^2));
   F(i,1) = exp((-1/epsilon)*(((training_data(1,i)-initial_omega(1))^2)+((training_data(2,i)-initial_omega(2))^2) +((training_data(3,i)-initial_omega(3))^2)));
end

F_matrix = repmat(F, 1,L);
phi_prime = phi.*F_matrix; 
G = (1/N)*(phi.')*phi_prime; 
trace_value = trace(G*rho*G); 
new_rho = (1/trace_value)*G*rho*G;    
end