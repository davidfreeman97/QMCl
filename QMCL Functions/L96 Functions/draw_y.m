% This function will accept the inputs 
       % rho - the current QM state (an LxL matrix)
       % S - the LxL self-adjoint matrix that represents the quantum observable
            %  associated with our classical observable Y. NOTE: right
            %  now, we are letting the quantum observale simply be the
            %  multiplication operator, but this might change
% and yield the output 
       % y - an element of the range of the classical observable Y (in the
            % L63 case, this will be R), drawn from the probability density
            % inhereted from the initial QM state (rho). 

function [y] = draw_y(rho, S, L)

%V is a matrix of the eigenvectors of S, D is the diagonal matrix of
%eigenvalues
[V,D] = eig(S);

%i'th component is probability that i'th eigenvalue is drawn
probability_vector = zeros(L,1); 

%populates the probability_vector with corresponding probabilities
%Could potentially improve speed using the Kronecker product function ?
for i=1:L
    P = transpose(V(i,:))*(V(i,:));
    probability_vector(i, 1) = trace(rho*P);
    
end

%index is the index of the eigenvalue that got randomly chosen according to
%our probaility distribution 
index = randsample(L,1,true,probability_vector);

y = D(index, index); 



