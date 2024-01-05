function [omega_prime] = Xi(omega,dt, n)
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

for k=1:n  
 fx=2.3*x-6.2*z-0.49*x*y-0.57*y*z;   
 fy=-62-2.7*y+0.49*((x)^2)-0.49*((z)^2)+0.14*x*z;
 fz = -0.63*x - 13*z + 0.43*x*y + 0.49*y*z;
 
 x=x+dt*fx; 
 y=y+dt*fy; 
 z= z+dt*fz;                                 %normrnd(0,4);          %normrnd(12.5,1); 
end       

omega_prime = [x;y;z];
    
end

