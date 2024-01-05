function [omega_prime] = Xi(omega,dt)
%The classical dyanmics operator we use to evolve our classical state
%forward in time. Here, it is the L63 system. Evolves by a timestep we
%choose. 
%Inputs:
    %omega - an element of R^3 (representing the current state of the
        %system)
    %dt - the length of the timestep
    %n - the number of timesteps we want to go over 
%Outputs:
    %omega_prime - the new state (a vector in R^3)

%sig=10.0; b=8/3; r=20;
sig=10.0; b=8/3; r=28;
t(1)=0.0;
x=omega(1); y=omega(2); z=omega(3);   
  
%for k=1:n  
 %fx=sig*(y-x);   
 %fy=-x*z+r*x-y;
 %fz=x*y-b*z;
 %x=x+dt*fx; 
 %y=y+dt*fy; 
 %z=z+dt*fz;
 %t=t+dt; 
%end   

%for k=1:n  
 %fx=2.3*x-6.2*z-0.49*x*y-0.57*y*z;   
 %fy=-62-2.7*y+0.49*((x)^2)-0.49*((z)^2)+0.14*x*z;
 %fz = -0.63*x - 13*z + 0.43*x*y + 0.49*y*z;
 

 %z= z+dt*fz;                                 %normrnd(0,4);          %normrnd(12.5,1); 
%end   

kx_1 = 2.3*x-6.2*z-0.49*x*y-0.57*y*z; 
ky_1=-62-2.7*y+0.49*((x)^2)-0.49*((z)^2)+0.14*x*z;
kx_2 = 2.3*(x+ (dt/2)*kx_1)-6.2*z-0.49*(x+ (dt/2)*kx_1)*(y+ (dt/2)*ky_1)-0.57*(y+ (dt/2)*ky_1)*z;
ky_2=-62-2.7*(y+ (dt/2)*ky_1)+0.49*((x+ (dt/2)*kx_1)^2)-0.49*((z)^2)+0.14*(x+ (dt/2)*kx_1)*z;
kx_3 = 2.3*(x+ (dt/2)*kx_2)-6.2*z-0.49*(x+ (dt/2)*kx_2)*(y+ (dt/2)*ky_2)-0.57*(y+ (dt/2)*ky_2)*z;
ky_3=-62-2.7*(y+ (dt/2)*ky_2)+0.49*((x+ (dt/2)*kx_2)^2)-0.49*((z)^2)+0.14*(x+ (dt/2)*kx_2)*z;
kx_4 = 2.3*(x+ (dt)*kx_3)-6.2*z-0.49*(x+ (dt)*kx_3)*(y+ (dt)*ky_3)-0.57*(y+ (dt)*ky_3)*z;
ky_4=-62-2.7*(y+ (dt)*ky_3)+0.49*((x+ (dt)*kx_3)^2)-0.49*((z)^2)+0.14*(x+ (dt)*kx_3)*z;

 x=x+dt*(1/6)*(kx_1 + 2*kx_2 + 2*kx_3 + kx_4); 
 y=y+dt*(1/6)*(ky_1 + 2*ky_2 + 2*ky_3 + ky_4); 
%omega_prime = [x;y;z];
omega_prime = [x;y];
    
end

