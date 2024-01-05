function [data, phi] = QMDA_Main_deterministic_RK4_Delay_Coord(amount_of_new_data, timestep, amount_of_training_data, initial_classical_state, initial_training_state, measurement_epsilon, spectral_res, timeshift_amount, steps_between_draws, generate_eig_fns, eig_functions)
%amount_of_training_data = 15;
%amount_of_new_data = 8;
%spectral_resolution = 1500; 
dbstop if error 

spectral_resolution = spectral_res; 


%timestep = .01;

training_timestep = timestep;

%initial_covariate = [5;5];

%generates the initial quantum pdf

A = zeros(spectral_resolution,spectral_resolution); 
A(1,1) = 1; 
initial_rho = A; 


x = zeros(amount_of_training_data, 1);
y = zeros(amount_of_training_data, 1);
z = zeros(amount_of_training_data, 1);

[t,training_data] = ode45(@l63_for_ode_solvers,[.01:timestep:amount_of_training_data*timestep],initial_training_state);
full_training =  transpose(training_data);
training_data = full_training(1:2, :);

N = length(full_training(1,:));




%phi = generate_delay_coord_eigenfunction_basis(training_data, spectral_resolution, timeshift_amount);
if generate_eig_fns == true
phi = generate_delay_coord_eigenfunction_basis_variable_bandwidth(training_data, spectral_resolution,timeshift_amount, 100);
else
phi = eig_functions;
end
%Y = calculate_approximate_Y_values(training_data, timeshift_amount, timestep); 
Y = full_training(3,(timeshift_amount+1):(N-(timeshift_amount)));
%training_data_reconstructed = [training_data(:, 2:(amount_of_training_data-1));transpose(Y)];
%phi = generate_eigenfunction_basis(training_data_reconstructed, spectral_resolution);
S = generate_S(phi, Y); 

%Now we generate our new data

%rho = rho_initialization(initial_rho, phi, initial_classical_state, training_data);
rho = initial_rho;

% covariate = initial_covariate;
% data = zeros(3, amount_of_new_data);
% 
% k=0;
% g = draw_y(initial_rho, S, spectral_resolution);
% for index=1:amount_of_new_data
%     
% if(k<9)
% k=k+1; 
% else
% g = draw_y(rho, S, spectral_resolution);
% k=0;
% end
% 
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
% index
% end

classical_state = initial_classical_state;
data = zeros(3, amount_of_new_data);

k=0;
%g = trace(rho*S);
g = classical_state(3);

for index=1:amount_of_new_data
data(:, index) = classical_state;

covariate = RK4_Step(classical_state, timestep);
rho = evolve_rho(rho, phi);

if(k<(steps_between_draws-1))
k=k+1; 
else
rho = update_rho(rho, phi, covariate, training_data, measurement_epsilon);
g = trace(rho*S);

%new_covariate = Xi(classical_state, timestep, 1);
%intermediate_rho = evolve_rho(rho, phi);
%new_rho = update_rho(intermediate_rho, phi, new_covariate, training_data);

%rho = evolve_rho(rho, phi);


%covariate = new_covariate ;
k=0;
end

classical_state = [covariate; g];

index
end


end