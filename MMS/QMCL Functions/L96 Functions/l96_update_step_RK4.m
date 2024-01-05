function dz = l96_update_step_RK4(z, F, hX, nX, dt )
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
k_1 = - circshift( x, -1 ) .* ( circshift( x, -2 ) - circshift( x, 1 ) ) ...
   - x + F + hX * y;

s_1 = x + (dt/2)*k_1;

k_2 = - circshift( s_1, -1 ) .* ( circshift( s_1, -2 ) - circshift( s_1, 1 ) ) ...
   - s_1 + F + hX * y;

s_2 = x + (dt/2)*k_2;

k_3 = - circshift( s_2, -1 ) .* ( circshift( s_2, -2 ) - circshift( s_2, 1 ) ) ...
   - s_2 + F + hX * y;

s_3 = x + dt*k_3;

k_4 = - circshift( s_3, -1 ) .* ( circshift( s_3, -2 ) - circshift( s_3, 1 ) ) ...
   - s_3 + F + hX * y;

dx = (1/6)*(k_1 + 2*k_2 + 2*k_3 + k_4);
%browser()


% Assemble into full vector field
dz = [dx zeros(1, nX)] ;
dz = dz'; %  return a column vector