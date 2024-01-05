function [ith_bandwidth_value] = knn_sum(data, index, knn); 
%data is the raw dataset 
%index is the index of the datapoint we are looking at 
%knn is the nearest neighbor resolution 


t_data = transpose(data); 
datapoint = t_data(index, :); 
dist_vec = zeros(knn,1);

knn_indices = knnsearch(t_data, datapoint, 'K', knn); 

for i=1:knn
    dist_vec(i) = norm(datapoint - t_data(knn_indices(1,i), :)); 
end

sum = 0; 

for i=2:knn 
    sum = sum + dist_vec(i); 
end

sum = sqrt(sum/(knn-1)); 

ith_bandwidth_value = sum;

