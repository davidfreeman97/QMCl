dt = .01;
nx = 9; 
ny=8;
hx = -0.8;
hy = 1;
%F = 5;
epsilon =1/128;
ntot   = (ny+1)*nx;
F = 10;
%timestep of modeled system


%ad hoc choice 
%also ad-hocly switched position of ntot and 1 

x0      = zeros( ntot, 1 );
x0(1) = 1;
x0(nx+1) = 1.1;

%QM_start = spinup_QM_data(:, 10000);
%x0 = QM_start;

comparison_l96_data = generate_l96_training_data(x0, F, hx, hy, epsilon, nx, ny, .01);