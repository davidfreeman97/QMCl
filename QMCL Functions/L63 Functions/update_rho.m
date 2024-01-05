function [new_rho] = update_rho(rho,phi, new_x, training_data, epsilon)
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
%epsilon = 2;

L = length(phi(1,:));
N = length(phi(:,1));

%F will be our length n vector defining the function F = k(new_x,-) (the
%values of the vector are F evaluated on the training datapoints)
%F = zeros(N,1);
x_matrix = training_data(1:2, :);

% 
% for i=1:N
%    F(i,1) = exp((-1/epsilon)*((x_matrix(1,i)-new_x(1))^2+(x_matrix(2,i)-new_x(2))^2));
% end

F = exp((-1/epsilon)*(sum((x_matrix - new_x).^2, 1)));
F = F';
%F_matrix = repmat(F, 1,L);

%phi_prime = phi.*F_matrix; 
phi_prime = phi.*F; 

G = (1/N)*(phi.')*phi_prime; 
new_rho = G*rho*G;
new_rho = new_rho/trace(new_rho); 

%Could have version for pure states where we leave it as G*rho and unpack
%later 
%G = (1/N)*(phi.')*phi_prime; 
%trace_value = trace(G*rho*G); 
%new_rho = (1/trace_value)*G*rho*G;    
end
