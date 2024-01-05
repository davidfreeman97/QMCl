function [data] = generate_palmer_data(amount_of_data, timestep)

t(1)=0.0;
%x(1)=1.95; y(1)=1.95; z(1)=1.95;   
x(1)=1; y(1)=1; z(1)=1;
dt = timestep;                               %dt=0.01;
nn = amount_of_data;                                 %nn=1000;  
%These values seem correct - (variance of a_3 axis is about 9)
index = 0;
z(1) = 1.95;
for k=1:(nn-1)  
 fx=2.3*x(k)-6.2*z(k)-0.49*x(k)*y(k)-0.57*y(k)*z(k);   
 fy=-62-2.7*y(k)+0.49*((x(k))^2)-0.49*((z(k))^2)+0.14*x(k)*z(k);
 x(k+1)=x(k)+dt*fx; 
 y(k+1)=y(k)+dt*fy; 
 
 %next step makes it so the third component stays constant for some number of
 %steps (so that it isn't bouncing around too fast)
 if(index<10)
     z(k+1)=z(k);
     index = index + 1;
 elseif (index == 10)
     index = 0;
     z(k+1) = normrnd(0, 3);
 end
 %normrnd(0,4);          %normrnd(12.5,1);
 
 t(k+1)=t(k)+dt; 
end      

data = [x;y;z]
end