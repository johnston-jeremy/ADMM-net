function [ O, O2 ] = zorg(m, n, I1, I2, weights, d1, d2, M2)
%% The first Nonlinear transform layer
%% z_{l} = S_PLF(c_{l})
%% The parameters are q related to the the predefined positions p;

if nargin == 5
    %% Compute z-update
    % I1 = x^1
    % I2 = u^0
    
    z = zeros(m+n,1);
    z(1:n) = shrinkage(I1(1:n) + I2(1:n), weights(1));
    z(n+1:m+n) = shrinkage(I1(n+1:m+n) + I2(n+1:m+n), weights(2));
  
    O = z;
end


if nargin == 8
    %% Compute dE/dz
    
    dEdu = d1;
    dEdx = d2;
    
    dudz = -1;
    % dxdz =  eye(m+n)/Rho - AULA/Rho^2;
    dxdz = reshape(M2,[m+n,m+n]);
    dEdz = dEdu.*dudz + transpose(transpose(dEdx)*dxdz);
    
    O = dEdz;
    
    % I1 = x^1
    % I2 = u^0

    dzdlambda1 = shrinkage_derivative_kappa(I1(1:n) + I2(1:n), weights(1));
    dzdlambda2 = shrinkage_derivative_kappa(I1(n+1:m+n) + I2(n+1:m+n), weights(2));
    dEdlambda1 = dEdz(1:n)'*dzdlambda1;
    dEdlambda2 = dEdz(n+1:n+m)'*dzdlambda2;
    O2 = [dEdlambda1 ; dEdlambda2];
    
end
end