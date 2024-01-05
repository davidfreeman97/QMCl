function [data] = QMDA_Main_L63_general(amount_of_new_data, timestep, amount_of_training_data, initial_classical_state, initial_training_state)
%amount_of_training_data = 15;
%amount_of_new_data = 8;
dbstop if error

spectral_resolution = 500; 
parametrized_variable = 10; 
%timestep = .01;
training_timestep = .05;
nx = 9; 
ny=8;
hx = -0.8;
hy = 1;
F = 5;
epsilon =1/128;
ntot   = (ny+1)*nx;

%timestep of modeled system
dt = .01;

%ad hoc choice 
%also ad-hocly switched position of ntot and 1 
x0      = zeros( ntot, 1 );
x0(1) = 1;
x0(nx+1) = 1;


%generates the initial quantum pdf
A = zeros(spectral_resolution,spectral_resolution);
A(1,1) = 1; 
initial_rho = A;

training_data = generate_l96_training_data(x0, F, hx, hy, epsilon, nx, ny, training_timestep); 

%generates eigenfunction basis of space of classical observables (up to L
%dimensions)
phi = generate_eigenfunction_basis(training_data, spectral_resolution);

%in the l96 case, Y can be chosen as the 1st slow variable 
Y = training_data(parametrized_variable,:); 
S = generate_S(phi, Y); 

%Now we generate our new data
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
dims = size(training_data);

%ad hoc choice for initial classical state

initial_classical_state      = zeros( ntot, 1 );
initial_classical_state(1) = 1;
initial_classical_state(nx+1) = 1;

classical_state = initial_classical_state;
data = zeros(dims(1), amount_of_new_data);

k=0;
g = draw_y(initial_rho, S, spectral_resolution);
for index=1:amount_of_new_data

    %added the 1 in arg just as placeholder 
new_state = classical_state + dt*l96_2level2(1, classical_state, F, hx, hy, epsilon, nx, ny );

%note: first coord here is ad hoc for using the first slow variable as the
%parameter
new_covariate = new_state([1:(parametrized_variable-1) (parametrized_variable+1):ntot], 1);
intermediate_rho = evolve_rho(rho, phi);
new_rho = update_rho(intermediate_rho, phi, new_covariate, training_data, parametrized_variable, ntot);

covariate = new_covariate ;
rho = new_rho;

if(k<1)
k=k+1; 
else

g = draw_y(rho, S, spectral_resolution);
k=0;
end

%ad hoc - fix for general use 
classical_state = [covariate(1:(parametrized_variable-1), 1); g; covariate((parametrized_variable):(ntot-1))];
data(:, index) = classical_state;

index
end


end