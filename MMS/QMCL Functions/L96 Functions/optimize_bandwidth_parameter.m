function [optimized_epsilon] = optimize_bandwidth_parameter(data, knn)
%knn is the chosen nearest-neighbor resolution 
%data is your raw data 

N = length(data(1,:)); 

epsilon_pool = 1:2:100;
epsilon_pool_size = length(epsilon_pool); 

sigma = zeros(epsilon_pool_size,1); 
sigma_prime = zeros(epsilon_pool_size,1); 
bandwidth_values = zeros(N,1); 

for i=1:N
    bandwidth_values(i) = knn_sum(data, i, knn);
end 

for l=1:epsilon_pool_size 
    for i=1:N
        for j=1:N
            sigma(l) = sigma(l) + bandwidth_kernel(i,j,data, epsilon_pool(l), bandwidth_values); 
        end
    end
    l
end
fprintf('second loop start')
for l=1:(epsilon_pool_size-1) 
    sigma_prime(l) = ((log(sigma(l+1)) - log(sigma(l)))/(log(epsilon_pool(l+1))-log(epsilon_pool(l))));
    fprintf('third loop')
    l
end

m = max(sigma_prime);

optimized_epsilon = epsilon_pool(find(sigma_prime == m))
