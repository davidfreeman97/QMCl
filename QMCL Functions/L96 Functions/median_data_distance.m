function [output] = median_data_distance(training_data)

distances_squared = dmat(training_data, training_data);
median_squared = median(distances_squared, 'All'); 
output = sqrt(median_squared); 

