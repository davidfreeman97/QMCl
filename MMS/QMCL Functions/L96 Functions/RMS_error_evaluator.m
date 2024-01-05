function [data] = RMS_error_evaluator(amount_of_data, amount_of_training_data, number_of_models, timestep)
dbstop if error;

spectral_resolution = 375;
training_timestep = .01;

matrices = zeros(amount_of_data, number_of_models);

initial_points = zeros(number_of_models, 2); 
for i=1:number_of_models
a = rand;
b = rand;
initial_points(i,1) = 20*(.5-a);
initial_points(i,2) = 20*(.5-b);
end

training_data = generate_training_data(amount_of_training_data, training_timestep);
eigenfunction_basis = generate_eigenfunction_basis(training_data, spectral_resolution);

for l=1:number_of_models 
    QMDA_data = QMDA_given_eigenfunctions(amount_of_data, timestep, training_data, eigenfunction_basis, [initial_points(l,1); initial_points(l,2)], spectral_resolution);
    classical_data = L63_EOF(amount_of_data, timestep, QMDA_data(:,1));
    
    %this part basically replicates compare_QMDA_with_classical()
    A = QMDA_data-classical_data; 
    C = transpose(A)*A;
    error_vector = zeros(amount_of_data, 1); 
    for i=1:amount_of_data
        error_vector(i) = sqrt(abs(C(i,i)));
    end
    %
    disp(l)
    matrices(:,l) = error_vector;
    
    %display iteration
    l
end 

RMS_vector = matrices(:,1).*matrices(:,1);
for y=1:(number_of_models-1)
    RMS_vector = RMS_vector + (matrices(:,y+1).*matrices(:,y+1));
end

for y=1:amount_of_data
    RMS_vector(y) = sqrt(RMS_vector(y)/number_of_models);
end

t = zeros(amount_of_data,1); 
t(1) = 0 ;
for j=1:(amount_of_data-1)
    t(j+1) = timestep*j;
end
%str = ['test', 25];
plot(t, RMS_vector)
data = RMS_vector;
%title(str)
