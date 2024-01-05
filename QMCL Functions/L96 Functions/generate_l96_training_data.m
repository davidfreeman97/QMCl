function data = generate_l96_training_data(  x0, F, hx, hy, epsilon, nx, ny, dt, nSProd )

%x0 is the initial point 


%% DATASET PARAMETERS
%nx     = 9;  % slow variables
%ny     = 8;  % fast variables
ntot   = (ny+1)*nx;
%F      = 10; %13; %10; %4;5;8;      % forcing parameter
%dt     = 0.05;   % sampling interval 
%nSProd = 20000; % number of "production" samples
nSSpin = 200; %10000;  % spinup samples
nEL    = 2; %100; %50; %25; %0;      % embedding window length (additional samples)
nXB    = 1;      % additional samples before production interval (for FD)
nXA    = 1;      % additional samples after production interval (for FD)
%x0      = zeros( 1, ntot );
%x0(1) = 1;
%x0(nx+1) = 1;
relTol = 1E-5;
absTol = 1E-7;
ifCent = false;        % data centering
idxX   = 1:9; %  state vector components for partial obs 
%hx = -0.8;
%hy = 1;
%epsilon =1/128;

% SCRIPT EXECUTION OPTIONS
ifIntegrate = true;
ifPartialObs = false; 

%% NUMBER OF PRODUCTION SAMPLES AND OUTPUT PATH
nS = nSProd + nEL + nXB + nXA; 
strSrc = [ 'F'       num2str( F, '%1.3g' ) ...
           '_n'      int2str( ntot ) ... 
           '_dt'     num2str( dt, '%1.3g' ) ...
           '_x0'     sprintf( '_%1.3g', x0( 1  ) ) ...
           '_nS'     int2str( nS ) ...
           '_nSSpin' int2str( nSSpin ) ...
           '_relTol' num2str( relTol, '%1.3g' ) ...
           '_ifCent' int2str( ifCent ) ];

pth = fullfile( './data', 'raw', strSrc );
if ~isdir( pth )
    mkdir( pth )
end

%% INTEGRATE THE L96 MODEL
if ifIntegrate
    odeH = @( T, X ) l96_2level2( T, X, F, hx, hy, epsilon, nx, ny);
    t = ( 0 : nS + nSSpin - 1 ) * dt;
    [ tOut, x ] = ode15s( odeH, t, x0, odeset( 'relTol', relTol, ...
                                          'absTol', absTol ) );
    x = x';
    t = tOut';

    t = t( nSSpin + 1 : end ) - t( nSSpin + 1 );
    x = x( :, nSSpin + 1 : end );

    mu = mean( x, 2 );
    if ifCent
        x  = bsxfun( @minus, x, mu );
    end

    data = x;
end
