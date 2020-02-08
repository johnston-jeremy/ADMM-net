function [O, O2] = xmid(m, n, Y, I1, I2, weights, d1, d2, I3)
%% Reconstruction layer in the middle of the network.
%% This layer has two inputs: I1 = z ; I2 = u

if nargin == 6
    %% Compute x-update
    % I1 = z
    % I2 = u
    % O = lasso_admm_x_update(A, Y, I1, I2, Rho);
    M1 = reshape(weights{1},[m+n,m]);
    M2 = reshape(weights{2},[m+n,m+n]);
    O = M1*Y + M2*(I1-I2);
end

if nargin == 9
    %% Compute gradients
    %% Compute dE/dx
    
    % I1 = u_{k-1} ; I2 = x_k ; I3 = z_{k-1}
    
    dEdz = d1;
    dEdu = d2;
    dudx = 1;
    
    dzdx = zeros(n+m,1);
    dzdx(1:n) = shrinkage_derivative_x(I2(1:n) + I1(1:n), weights(1));
    dzdx(n+1:m+n) = shrinkage_derivative_x(I2(n+1:m+n) + I1(n+1:m+n), weights(2));

    dEdx = dEdu.*dudx + dEdz.*dzdx;
    
    O = dEdx;
    
    %% Compute dE/dM1, dE/dM2

%     dEdM1 = zeros(m+n,m);
%     dEdM2 = zeros(m+n,m+n);
% 
%     for i = 1:(m+n)
%         for j = 1:m
%             dEdM1(i,j) = dEdx(i)*Y(j);
%         end
%     end
%     
%     
% 
%     for i = 1:(m+n)
%         for j = 1:(m+n)
%             dEdM2(i,j) = dEdx(i)*(I3(j)-I1(j));
%         end
%     end
  
    dEdM1 = dEdx*transpose(Y);
    dEdM2 = dEdx*transpose(I3-I1);
    
    dEdM1 = dEdM1(:);
    dEdM2 = dEdM2(:);
    
    O2 = [dEdM1; dEdM2];

end
end
