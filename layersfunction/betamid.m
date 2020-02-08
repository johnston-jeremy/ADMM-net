function O = betamid( m, n, I1, I2, I3, weights, d1, d2, d3, M2 )
%% The middle Multiplier update layer

if nargin == 5
    %% Compute u-update u^{k+1}
    % I1 = z^{k+1}
    % I2 = x^{k+1}
    % I3 = u^k
    u = I3 + I2 - I1;
    O = u;
end

if nargin == 10
    %% Compute derivative dE/du^k
    % I2 = x^{k+1}, I3 = u^k
    
    %% network setting 
    
    % AULA = nnconfig.AULA;
    
    dEdx1 = d1;
    dEdz1 = d2;
    dEdu1 = d3;
    
    du1du = 1;
    
    dz1du = zeros(n+m,1);
    dz1du(1:n) = shrinkage_derivative_x(I2(1:n) + I3(1:n), weights(1));
    dz1du(n+1:m+n) = shrinkage_derivative_x(I2(n+1:m+n) + I3(n+1:m+n), weights(2));
    
    % dx1du =  -(eye(m+n)/Rho - AULA/Rho^2);
    dx1du = -1*reshape(M2,[m+n,m+n]);
    
    dEdu = dEdu1.*du1du + dEdz1.*dz1du + transpose(transpose(dEdx1)*dx1du);
    
    O = dEdu;
end


end

