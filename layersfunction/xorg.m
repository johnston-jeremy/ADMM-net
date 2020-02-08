function [O, O2] = xorg(m, n, Y, I1, I2, weights, I3, d1, d2)
%% The first Reconstruction layer
%% This layer has two parameters: H_{l} = sum_{m=1}^{s} gamma_{l,m}B_{m};  \rho_{l}

%% The forward propagation
if nargin == 6
    %% Compute x-update
    % I1 = z
    % I2 = u
    % O = lasso_admm_x_update(A, Y, I1, I2, Rho);
    M1 = reshape(weights{1},[m+n,m]);
    M2 = reshape(weights{2},[m+n,m+n]);
    O = M1*Y + M2*(I1-I2);
end

%% The backward propagation
if nargin == 9
    %% Compute dE/dx
    
    % Take inputs
    dEdz = d1;
    dEdu = d2;
    dudx = 1;
    
    % I1 = u_{k-1} ; I2 = x_k, I3 = z_{k-1}
    dzdx = zeros(n+m,1);
    dzdx(1:n) = shrinkage_derivative_x(I2(1:n) + I1(1:n), weights(1));
    dzdx(n+1:m+n) = shrinkage_derivative_x(I2(n+1:m+n) + I1(n+1:m+n), weights(2));

    dEdx = dEdu.*dudx + dEdz.*dzdx;
    
    O = dEdx;
    
    %% Compute dE/dM1, dE/dM2

    dEdM1 = zeros(m+n,m);
    dEdM2 = zeros(m+n,m+n);

    for i = 1:(m+n)
        for j = 1:m
            dEdM1(i,j) = dEdx(i)*Y(j);
        end
    end

    for i = 1:(m+n)
        for j = 1:(m+n)
            dEdM2(i,j) = dEdx(i)*(I3(j)-I1(j));
        end
    end

    dEdM1 = reshape(dEdM1,[numel(dEdM1),1]);
    dEdM2 = reshape(dEdM2,[numel(dEdM2),1]);
    
    O2 = [dEdM1; dEdM2];
end
end
