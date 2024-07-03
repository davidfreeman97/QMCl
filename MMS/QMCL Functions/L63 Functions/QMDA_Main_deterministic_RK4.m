function [data] = QMDA_Main_deterministic_RK4(amount_of_new_data, timestep, amount_of_training_data, initial_classical_state, initial_training_state, measurement_epsilon, training_epsilon, spectral_res, generate_eig_fns, eig_fns, generate_training_data, training_data_input, embed_initial)

spectral_resolution = spectral_res; 
N = amount_of_training_data;
training_timestep = timestep;

%generates the initial quantum pdf
if embed_initial == true
embed_epsilon = 2;
initial_rho = embed_classical_state_as_quantum_state(initial_classical_state, eig_fns, training_data_input, embed_epsilon);
else
A = zeros(spectral_resolution,spectral_resolution); 
A(1,1) = 1; 
initial_rho = A; 
end



x = zeros(amount_of_training_data, 1);
y = zeros(amount_of_training_data, 1);
z = zeros(amount_of_training_data, 1);

%generates training data on L63 system 
t(1)=0.0;
if generate_training_data ==true; 
x(1)=initial_training_state(1); y(1)=initial_training_state(2); z(1)=initial_training_state(3); 
[t,training_data] = ode45(@l63_for_ode_solvers,[.01:timestep:amount_of_training_data*timestep],initial_training_state);
training_data = transpose(training_data);
else 
training_data = training_data_input; 
end

%generates eigenfunction basis of space of classical observables (up to L
%dimensions)
if generate_eig_fns == true
phi = generate_eigenfunction_basis(training_data, spectral_resolution, training_epsilon);
else
phi = eig_fns;
end

%Approximates Koopman operator represented in Phi basis
phi_1 = phi(1:(N-1), :);
phi_2 = phi(2:N, :);
U = ((phi_1).')*phi_2;

Y = transpose(training_data(3,:)); 
S = generate_S(phi, Y); 

%Now we generate our new data
rho = initial_rho;

classical_state = initial_classical_state;
data = zeros(3, amount_of_new_data);

k=0;
g = classical_state(3);

for index=1:amount_of_new_data
tic
data(:, index) = classical_state;

covariate = RK4_Step(classical_state, timestep);
rho = evolve_rho_fast(rho, U);

if(k<0)
k=k+1; 
else
rho = update_rho(rho, phi, covariate, training_data, measurement_epsilon);
g = trace(rho*S);

k=0;
end

classical_state = [covariate; g];
toc
end


end
