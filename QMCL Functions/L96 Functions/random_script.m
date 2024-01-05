spectral_resolution = 100; 
%timestep = .01;
training_timestep = .01;
nx = 9; 
ny=8;
hx = -0.8;
hy = 1;
F = 10;
epsilon =1/128;
ntot   = (ny+1)*nx;

%ad hoc choice 
%also ad-hocly switched position of ntot and 1 
x0      = zeros( ntot, 1 );
x0(1) = 1;
x0(nx+1) = 1;


%data = generate_l96_training_data(  x0, F, hx, hy, epsilon, nx, ny, dt );

%bandwidth = optimize_bandwidth_parameter(data, 3)
start = 5000;
amount = 2000;
hold on 
plot(0:.01:amount/100, data(1,start:(start+amount)))
plot(0:.01:amount/100, F10_data_updated(1,start:(start+amount)))
hold off