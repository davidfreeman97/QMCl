function [data] = QMDA_Main_L63_averaged_var(amount_of_new_data, timestep, amount_of_training_data, initial_classical_state, initial_training_state,F)
%amount_of_training_data = 15;
%amount_of_new_data = 8;
dbstop if error

dt = .015;
training_timestep = .15;

spectral_resolution = 225; 
%parametrized_variable = 1; 
%timestep = .01;
nx = 9; 
ny=8;
hx = -0.8;
hy = 1;
%F = 10;
epsilon =1/128;
ntot   = (ny+1)*nx;

%timestep of modeled system


%ad hoc choice 
%also ad-hocly switched position of ntot and 1 
x0      = zeros( ntot, 1 );
x0(1) = 1;
x0(nx+1) = 1;


%generates the initial quantum pdf
A = zeros(spectral_resolution,spectral_resolution);
A(1,1) = 1; 
initial_rho = A;

raw_training_data = generate_l96_training_data(x0, F, hx, hy, epsilon, nx, ny, training_timestep); 

%The state space we're actually using to train the system is not the full
%one with (ny+1)*nx dimensions...we are treating the averages of the
%resective sets of fast variables as their own parametrizable variables. So
%the state space is just 2*nx dimensional 
%generates eigenfunction basis of space of classical observables (up to L
%dimensions)
avg_fast_vars = zeros(nx, length(raw_training_data(1,:))); 
for j=1:(length(raw_training_data(1,:)))
for i=1:nx
    avg_fast_vars(i,j) = mean(raw_training_data((nx+(i-1)*ny+1):(nx+(i)*ny), j));
end
end

training_data = [raw_training_data(1:nx, :); avg_fast_vars]; 

phi = generate_eigenfunction_basis(training_data, spectral_resolution);

%we have to create observable matrices for every variable we're
%parametrizing 
%In this case, we can just write thme out one by one (poor coding
%technique)

%%%Y = training_data(parametrized_variable,:); 
S_1 = generate_S(phi, training_data(nx+1, :)); 
S_2 = generate_S(phi, training_data(nx+2, :)); 
S_3 = generate_S(phi, training_data(nx+3, :)); 
S_4 = generate_S(phi, training_data(nx+4, :)); 
S_5 = generate_S(phi, training_data(nx+5, :)); 
S_6 = generate_S(phi, training_data(nx+6, :)); 
S_7 = generate_S(phi, training_data(nx+7, :)); 
S_8 = generate_S(phi, training_data(nx+8, :)); 
S_9 = generate_S(phi, training_data(nx+9, :));
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

initial_classical_state      = zeros( 2*nx, 1 );
initial_classical_state(1) = 1;
initial_classical_state(nx+1) = 1;

classical_state = initial_classical_state;
data = zeros(dims(1), amount_of_new_data);

k=0;
g_1 = draw_y(initial_rho, S_1, spectral_resolution);
g_2 = draw_y(initial_rho, S_2, spectral_resolution);
g_3 = draw_y(initial_rho, S_3, spectral_resolution);
g_4 = draw_y(initial_rho, S_4, spectral_resolution);
g_5 = draw_y(initial_rho, S_5, spectral_resolution);
g_6 = draw_y(initial_rho, S_6, spectral_resolution);
g_7 = draw_y(initial_rho, S_7, spectral_resolution);
g_8 = draw_y(initial_rho, S_8, spectral_resolution);
g_9 = draw_y(initial_rho, S_9, spectral_resolution);

for index=1:amount_of_new_data

    %added the 1 in arg just as placeholder 
new_state = classical_state + dt*l96_update_step(classical_state, F, hx, nx);

%note: first coord here is ad hoc for using the first slow variable as the
%parameter
new_covariate = new_state(1:nx, 1);
intermediate_rho = evolve_rho(rho, phi);
new_rho = update_rho(intermediate_rho, phi, new_covariate, training_data, nx);

covariate = new_covariate ;
rho = new_rho;

if(k<6)
k=k+1; 
else

g_1 = draw_y(rho, S_1, spectral_resolution);
g_2 = draw_y(initial_rho, S_2, spectral_resolution);
g_3 = draw_y(initial_rho, S_3, spectral_resolution);
g_4 = draw_y(initial_rho, S_4, spectral_resolution);
g_5 = draw_y(initial_rho, S_5, spectral_resolution);
g_6 = draw_y(initial_rho, S_6, spectral_resolution);
g_7 = draw_y(initial_rho, S_7, spectral_resolution);
g_8 = draw_y(initial_rho, S_8, spectral_resolution);
g_9 = draw_y(initial_rho, S_9, spectral_resolution);

k=0;
end

%ad hoc - fix for general use 
classical_state = [covariate; g_1;g_2;g_3;g_4;g_5;g_6;g_7;g_8;g_9];
data(:, index) = classical_state;

index
end


end