dbstop if error

dt = .01;
training_timestep = .01;
 
%parametrized_variable =  1; 
%timestep = .01;
nx = 9; 
ny=8;
hx = -0.8;
hy = 1;
%F = 5;
epsilon =1/128;
ntot   = (ny+1)*nx;

%timestep of modeled system


%ad hoc choice 
%also ad-hocly switched position of ntot and 1 
x0      = zeros( ntot, 1 );
x0(1) = 1;
x0(nx+1) = 1;




 
%raw_training_data_10 = generate_l96_training_data(x0, 10, hx, hy, epsilon, nx, ny, training_timestep);  
 

QMDA_F10_data = L96_QMDA_Main(15000, 10, "no", raw_training_data(:,1:30000))

save('QMDA_F10_data_archive', 'QMDA_F10_data')