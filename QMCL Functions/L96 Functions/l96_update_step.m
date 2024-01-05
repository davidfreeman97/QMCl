function dz = l96_update_step(z, F, hX, nX )
%%The update step for the multi-parameter, averaged Y version of the L96
%%system

dbstop if error

% Evaluates the right hand side of the 2-level Lorenz 96 system
%
% dx( i ) = ( x( i + 1 ) - x( i - 2 ) ) * x( i - 1 ) - x( i ) + F

z = z'; % make z a row vector

x = z( 1 : nX );       % slow variables 
y = z( nX + 1 : end ); % averaged fast variables

%y = reshape( y, [ nY nX ] );

% Vector field components for slow variables
dx = - circshift( x, -1 ) .* ( circshift( x, -2 ) - circshift( x, 1 ) ) ...
   - x + F + hX * y;


%browser()


% Assemble into full vector field
dz = [dx zeros(1, nX)] ;
dz = dz'; %  return a column vector