function x = lasso_admm_x_update(Atb, b, z, u, rho)
%% Data preprocessing
config

AULA = nnconfig.AULA;

% x-update
q = (Atb + rho*(z - u));    % temporary value
x = q/rho - AULA*q/rho^2;

end
