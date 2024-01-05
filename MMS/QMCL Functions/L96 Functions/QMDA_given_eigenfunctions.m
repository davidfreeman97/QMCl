function [data] = QMDA_given_eigenfunctions(amount_of_new_data, timestep, training_data, phi, spectral_resolution)
%NOTE: phi is a matrix of the eigenfunctions on training data


%generates the initial quantum pdf
A = zeros(spectral_resolution,spectral_resolution);
A(1,1) = 1; 
initial_rho = A;


%in our case, Y is just the third dimension of the state
Y = training_data(3,:); 
S = generate_S(phi, Y); 

%Now we generate our new data
rho = initial_rho;
% initial_covariate = [4;7]; 
% covariate = initial_covariate;
data = zeros(3, amount_of_new_data);

initial_classical_state = [0;1;1.05];
classical_state = initial_classical_state;

data = zeros(3, amount_of_new_data);

k=0;
g = draw_y(initial_rho, S, spectral_resolution);
for index=1:amount_of_new_data

new_state = Xi(classical_state, timestep, 1);
new_covariate = new_state(1:2, 1);
intermediate_rho = evolve_rho(rho, phi);
new_rho = update_rho(intermediate_rho, phi, new_covariate, training_data);

covariate = new_covariate ;
rho = new_rho;

if(k<10)
k=k+1; 
else
g = draw_y(rho, S, spectral_resolution);
k=0;
end

classical_state = [covariate; g];
data(:, index) = classical_state;

index
end

% for index=1:amount_of_new_data
% g = draw_y(rho, S, spectral_resolution); 
% classical_state = [covariate; g];
% data(:, index) = classical_state;
% 
% new_state = Xi(classical_state, timestep, 1);
% new_covariate = new_state(1:2, 1);
% intermediate_rho = evolve_rho(rho, phi);
% new_rho = update_rho(intermediate_rho, phi, new_covariate, training_data);
% 
% covariate = new_covariate ;
% rho = new_rho;
% 
% end


end