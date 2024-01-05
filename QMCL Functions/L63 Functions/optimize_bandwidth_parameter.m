function [optimized_epsilon, r_vector, m_hat, K_hat_matrix] = optimize_bandwidth_parameter(data, epsilon_pool,  knn, timeshift_amount)
%knn is the chosen nearest-neighbor resolution 
%data is your raw data 

N = length(data(1,:)); 

%epsilon_pool = 1:1:50;
epsilon_pool_size = length(epsilon_pool); 

K_hat_matrix = zeros(N,N);
sigma = zeros(epsilon_pool_size,1); 
sigma_prime = zeros(epsilon_pool_size,1); 
r_vector = zeros(N,1); 

for i=1:N
    r_vector(i) = knn_sum(data, i, knn);
end 

for l=1:epsilon_pool_size
for i=1:N
    for j=1:N
            K_hat_matrix(i,j) = bandwidth_kernel(i,j,data, epsilon_pool(l), r_vector, timeshift_amount); 
    end
end
sigma(l) = sum(sum(K_hat_matrix))/(N^2);
end

for l=1:(epsilon_pool_size-1) 
    sigma_prime(l) = ((log(sigma(l+1)) - log(sigma(l)))/(log(epsilon_pool(l+1))-log(epsilon_pool(l))));
    %fprintf('third loop')
end

m = max(sigma_prime);

m_hat = 2*m;

optimized_epsilon = epsilon_pool(find(sigma_prime == m))
