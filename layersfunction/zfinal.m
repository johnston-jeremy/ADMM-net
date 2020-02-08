function [ O,  O2 ] = zfinal(m, n, I1, I2, weights, d1)
%% Nonlinear transform layer
%% network setting

%% Compute dE/dz
dEdz = d1;
O = dEdz;

%% Compute dE/dlambda

% I1 = x^k
% I2 = u^{k-1}

dzdlambda1 = shrinkage_derivative_kappa(I1(1:n) + I2(1:n), weights(1));
dzdlambda2 = shrinkage_derivative_kappa(I1(n+1:m+n) + I2(n+1:m+n), weights(2));
dEdlambda1 = dEdz(1:n)'*dzdlambda1;
dEdlambda2 = dEdz(n+1:n+m)'*dzdlambda2;

O2 = [dEdlambda1 ; dEdlambda2];