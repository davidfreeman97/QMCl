function [data] = QMDA_Main(amount_of_new_data, timestep, amount_of_training_data, initial_classical_state, initial_training_state, generate_eigs, phi)
%amount_of_training_data = 15;
%amount_of_new_data = 8;
spectral_resolution = 1050; 
%timestep = .01;
training_timestep = .01;

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

[t,training_data] = ode45(@l63_for_ode_solvers,[.01:timestep:amount_of_training_data*timestep],initial_training_state);
training_data = transpose(training_data);

%generates eigenfunction basis of space of classical observables (up to L
%dimensions)
if(generate_eigs == true)
phi = generate_eigenfunction_basis(training_data, spectral_resolution);
else 
phi = phi; 
end

Y = training_data(3,:);
S = generate_S(phi, Y); 

%Now we generate our new data
rho = initial_rho;

classical_state = initial_classical_state;
data = zeros(3, amount_of_new_data);

k=0;
g = draw_y(initial_rho, S, spectral_resolution);
for index=1:amount_of_new_data

new_covariate = RK4_Step(classical_state, timestep);
rho = evolve_rho(rho, phi);

covariate = new_covariate ;

if(k<6)
k=k+1; 
else
g = draw_y(rho, S, spectral_resolution);
new_rho = update_rho(rho, phi, new_covariate, training_data, 35);


rho = new_rho;
k=0;
end

classical_state = [covariate; g];
data(:, index) = classical_state;

index
end


end