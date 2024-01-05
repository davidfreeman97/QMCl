function [new_rho] = evolve_rho_fast(rho,U)
%Takes  in premade koopman operator to evolve forward 
intermediate = transpose(U)*rho*U;

new_rho = (1/trace(intermediate))*intermediate;

% trace_value = trace(transpose(U)*rho*U);
% 
% new_rho = (1/trace_value)*(transpose(U)*rho*U);
    
end