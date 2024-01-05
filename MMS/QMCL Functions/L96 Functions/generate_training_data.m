function [training_data] = generate_training_data(amount_of_training_data, training_timestep)



x = zeros(amount_of_training_data, 1);
y = zeros(amount_of_training_data, 1);
z = zeros(amount_of_training_data, 1);

t(1)=0.0;
x(1)=1.95; y(1)=1.95; z(1)=1.95;   
%x(1)=8.4454; y(1)=-12.7908; z(1)=-1.5863;
%x(1)=10; y(1)=1; z(1)=6; 

% for k=1:((amount_of_training_data+10)-1)  
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
% training_data = transpose([x(11:amount_of_training_data+10), y(11:amount_of_training_data+10), z(11:amount_of_training_data+10)]);
 
for k=1:amount_of_training_data  
 fx=2.3*x(k)-6.2*z(k)-0.49*x(k)*y(k)-0.57*y(k)*z(k);   
 fy=-62-2.7*y(k)+0.49*((x(k))^2)-0.49*((z(k))^2)+0.14*x(k)*z(k);
 fz = -0.63*x(k) - 13*z(k) + 0.43*x(k)*y(k) + 0.49*y(k)*z(k);
 
 x(k+1)=x(k)+training_timestep*fx; 
 y(k+1)=y(k)+training_timestep*fy; 
 z(k+1)= z(k)+training_timestep*fz;                                 %normrnd(0,4);          %normrnd(12.5,1);
 t(k+1)=t(k)+training_timestep; 
end   

training_data = transpose([x, y, z]); 