function  [output] = bandwidth_kernel( x_index,y_index,data,epsilon, bandwidth_values, timeshift_amount) 
%Once you know the bandwidth values ( r_i in the paper) you can define the
%kernel K_epsilon 

%x_index and y_index are the indices of the datapoints x and y in the
%dataset 

x = data(:, x_index); 
y = data(:, y_index); 

output = exp(-((norm(x-y))^2)/(epsilon*bandwidth_values(x_index)*bandwidth_values(y_index)));
%output = exp(-((norm(x-y))^2)/((2*timeshift_amount + 1)*epsilon*sqrt(bandwidth_values(x_index))*sqrt(bandwidth_values(y_index))));
