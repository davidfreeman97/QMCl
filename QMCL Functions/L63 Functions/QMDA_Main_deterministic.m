function [data] = QMDA_Main_deterministic(amount_of_new_data, timestep, amount_of_training_data, initial_classical_state, initial_training_state, measurement_epsilon, spectral_res, number_of_timesteps)
%amount_of_training_data = 15;
%amount_of_new_data = 8;
%spectral_resolution = 1500; 

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
%generates training data on L63 system 
%sig=10.0; b=8/3; r=20;
t(1)=0.0;
%x(1)=1.95; y(1)=1.95; z(1)=1.95;   
x(1)=initial_training_state(1); y(1)=initial_training_state(2); z(1)=initial_training_state(3); 
 
%NOTE: Come back and reduce to EOFs so the choice of Y is better 
% 
% sig=10.0; b=8/3; r=20;
% for k=1:(amount_of_training_data-1)  
%  fx=sig*(y(k)-x(k));   
%  fy=-x(k)*z(k)+r*x(k)-y(k);
%  fz=x(k)*y(k)-b*z(k);
%  x(k+1)=x(k)+training_timestep*fx; 
%  y(k+1)=y(k)+training_timestep*fy; 
%  z(k+1)=z(k)+training_timestep*fz;
%  t(k+1)=t(k)+training_timestep; 
% end 

% % for k=1:(amount_of_training_data-1)  
% %  fx=2.3*x(k)-6.2*z(k)-0.49*x(k)*y(k)-0.57*y(k)*z(k);   
% %  fy=-62-2.7*y(k)+0.49*((x(k))^2)-0.49*((z(k))^2)+0.14*x(k)*z(k);
% %  fz = -0.63*x(k) - 13*z(k) + 0.43*x(k)*y(k) + 0.49*y(k)*z(k);
% %  
% %  x(k+1)=x(k)+training_timestep*fx; 
% %  y(k+1)=y(k)+training_timestep*fy; 
% %  z(k+1)= z(k)+training_timestep*fz;                                 
% %  t(k+1)=t(k)+training_timestep; 
% % end   
% % 
% % training_data = transpose([x, y, z]); 

[t,training_data] = ode45(@l63_for_ode_solvers,[.01:timestep:amount_of_training_data*timestep],initial_training_state);
training_data = transpose(training_data);
%generates eigenfunction basis of space of classical observables (up to L
%dimensions)
phi = generate_eigenfunction_basis(training_data, spectral_resolution);
%save('l63_eigenfunction_basis_50kpoints_1250spec', 'phi')

%in our case, Y is just the third dimension of the state

%initial_rho = embed_classical_state_as_quantum_state(initial_classical_state, phi, training_data, 1);

%Had Y=z, which was the error!!
Y = transpose(training_data(3,:)); 
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

covariate = Xi(classical_state, timestep, 1);
rho = evolve_rho(rho, phi);

if(k<(number_of_timesteps - 1))
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