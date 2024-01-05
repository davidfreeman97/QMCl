%This function will take a current classical state and evolve it over one 
%time step to get a new state. 
%NOTE: Here, we are choosing the evolution operator to be the Lorenz 63
%system. For other applications, this would obviously be different
%The function will accept the inputs 
    %x - the current classical covariate (in the L63 case, will be a vector
        %in R^2)
    %y - the response(?) variable we randomly drew from our current quantum PDF. 
        %Will be such that (x,y) is an element of the state space Omega. In
        %the L63 case, y will be an element of R. 
    %timestep - the time step we are evolving over (a positive value in R)
    %Note - we will hard code the function Xi, which will represent our
    %classical dynamics operator (in this case, the L63 system)
%Outputs:
    %new_x - the covariate of the the updated state, represented in this case by a vector in
    %R^2.
    %Note: this outputs the covariate of the new state after a single timestep
function [new_x] = evolve_x(x,y,timestep)
    initial_omega = [x;y];
    new_omega = Xi(initial_omega, timestep, 1);
    new_x = new_omega(1:2, 1);
    