function [data] = QMDA_given_eigenfunctions_2(amount_of_new_data, timestep, phi, training_timestep, training_data)
%amount_of_training_data = 15;
%amount_of_new_data = 8;
size_phi = size(phi);
spectral_resolution = size_phi(2); 
%timestep = .01;
amount_of_training_data = 6400;
%initial_covariate = [5;5];
initial_classical_state = [8;-12;-1];

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
x(1)=training_data(1,1); y(1)=training_data(2,1); z(1)=training_data(3,1);   
  
%NOTE: Come back and reduce to EOFs so the choice of Y is better 
% sig=10.0; b=8/3; r=28;
% for k=1:(amount_of_training_data-1)  
%  fx=sig*(y(k)-x(k));   
%  fy=-x(k)*z(k)+r*x(k)-y(k);
%  fz=x(k)*y(k)-b*z(k);
%  x(k+1)=x(k)+training_timestep*fx; 
%  y(k+1)=y(k)+training_timestep*fy; 
%  z(k+1)=z(k)+training_timestep*fz;
%  t(k+1)=t(k)+training_timestep; 
% end 

% for k=1:(amount_of_training_data-1)  
%  fx=2.3*x(k)-6.2*z(k)-0.49*x(k)*y(k)-0.57*y(k)*z(k);   
%  fy=-62-2.7*y(k)+0.49*((x(k))^2)-0.49*((z(k))^2)+0.14*x(k)*z(k);
%  fz = -0.63*x(k) - 13*z(k) + 0.43*x(k)*y(k) + 0.49*y(k)*z(k);
%  
%  x(k+1)=x(k)+training_timestep*fx; 
%  y(k+1)=y(k)+training_timestep*fy; 
%  z(k+1)= z(k)+training_timestep*fz;                                 %normrnd(0,4);          %normrnd(12.5,1);
%  t(k+1)=t(k)+training_timestep; 
% end   
% 
% training_data = transpose([x, y, z]); 



%in our case, Y is just the third dimension of the state
Y = training_data(3,:); 
S = generate_S(phi, Y); 

%Now we generate our new data
rho = initial_rho;


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

if(k<9)
k=k+1; 
else
g = draw_y(rho, S, spectral_resolution);
k=0;
end

classical_state = [covariate; g];
data(:, index) = classical_state;

index
end


end