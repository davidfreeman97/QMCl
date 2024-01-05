function  [output] = bandwidth_kernel_2( x_index,y_index,data,epsilon, bandwidth_values, m_hat) 
%Once you know the bandwidth values ( r_i in the paper) you can define the
%kernel K_epsilon 

%x_index and y_index are the indices of the datapoints x and y in the
%dataset 

x = data(:, x_index); 
y = data(:, y_index); 

output = exp(-((norm(x-y))^2)/(epsilon*((bandwidth_values(x_index))^(-1/m_hat))*((bandwidth_values(y_index))^(-1/m_hat))));
