function [z, history, x_history] = lasso(A, b, lambda1, lambda2, rho, alpha, n1, n2)
% lasso  Solve lasso problem via ADMM
%
% [z, history] = lasso(A, b, lambda, rho, alpha);
% 
% Solves the following problem via ADMM:
%
%   minimize 1/2*|| Ax - b ||_2^2 + \lambda || x ||_1
%
% The solution is returned in the vector x.
%
% history is a structure that contains the objective value, the primal and 
% dual residual norms, and the tolerances for the primal and dual residual 
% norms at each iteration.
% 
% rho is the augmented Lagrangian parameter. 
%
% alpha is the over-relaxation parameter (typical values for alpha are 
% between 1.0 and 1.8).
%
%
% More information can be found in the paper linked at:
% http://www.stanford.edu/~boyd/papers/distr_opt_stat_learning_admm.html
%

t_start = tic;

%% Global constants and defaults

QUIET    = 0;
MAX_ITER = 1000;
ABSTOL   = 1e-4;
RELTOL   = 1e-2;

%% Data preprocessing

[m, n] = size(A);

assert(n1 + n2 == n)

% save a matrix-vector multiply
Atb = A'*b;

%% ADMM solver

x = zeros(n,1);
z = zeros(n,1);
u = zeros(n,1);

% cache the factorization
[L U] = factor(A, rho);

if ~QUIET
    fprintf('%3s\t%10s\t%10s\t%10s\t%10s\t%10s\n', 'iter', ...
      'r norm', 'eps pri', 's norm', 'eps dual', 'objective');
end

x_history = zeros(n, MAX_ITER);

for k = 1:MAX_ITER
    
    % x-update
    q = Atb + rho*(z - u);    % temporary value
    if( m >= n )    % if skinny
       x = U \ (L \ q);
    else            % if fat
       x = q/rho - (A'*(U \ ( L \ (A*q) )))/rho^2;
    end

    % z-update with relaxation
    zold = z;
    x_hat = alpha*x + (1 - alpha)*zold;
    z(1:n1) = shrinkage_complex(x_hat(1:n1) + u(1:n1), lambda1/rho);
    z(n1+1:n1+n2) = shrinkage_complex(x_hat(n1+1:n1+n2) + u(n1+1:n1+n2), lambda2/rho);

    % u-update
    u = u + (x_hat - z);
    
    % diagnostics, reporting, termination checks
    history.objval(k)  = objective(A, b, lambda1, lambda2, x, z, n1, n2);
    
    history.r_norm(k)  = norm(x - z);
    history.s_norm(k)  = norm(-rho*(z - zold));
    
    history.eps_pri(k) = sqrt(n)*ABSTOL + RELTOL*max(norm(x), norm(-z));
    history.eps_dual(k)= sqrt(n)*ABSTOL + RELTOL*norm(rho*u);
    
    x_history(:,k) = z;
    
    
    if ~QUIET
        fprintf('%3d\t%10.4f\t%10.4f\t%10.4f\t%10.4f\t%10.2f\n', k, ...
            history.r_norm(k), history.eps_pri(k), ...
            history.s_norm(k), history.eps_dual(k), history.objval(k));
    end

    if (history.r_norm(k) < history.eps_pri(k) && ...
       history.s_norm(k) < history.eps_dual(k))
         break;
    end
    
end

[z1_norm, z2_norm] = z_norms(x, n1, n2);
err = error_norm(A, b, x);

    
if ~QUIET
    toc(t_start);
    fprintf('\tMSE\t||x1||_1\t||x2||_1\n%10.2f\t%10.2f\t%10.2f\n', err, z1_norm, z2_norm)
end

end

function p = objective(A, b, lambda1, lambda2, x, z, n1, n2)
    p = ( 1/2*sum((A*x - b).^2) + lambda1*norm(z(1:n1),1) + lambda2*norm(z(n1+1:n1+n2),1) );
end

function e = error_norm(A, b, x)
    e = sum((A*x - b).^2)/norm(b);
end

function [z1_l1, z2_l1] = z_norms(z, n1, n2)
    z1_l1 = norm(z(1:n1),1);
    z2_l1 = norm(z(n1+1:n1+n2),1);
end

function z = shrinkage(x, kappa)
    z = max( 0, x - kappa ) - max( 0, -x - kappa );
end

function z = shrinkage_complex(x,kappa)
    z = sign(x).*max(abs(x) - kappa,0);
%     if (abs(x) > kappa)
%         z = x - kappa*x/abs(x);
%     else
%         z = 0;
%     end
end

function [L U] = factor(A, rho)
    [m, n] = size(A);
    if ( m >= n )    % if skinny
       L = chol( A'*A + rho*speye(n), 'lower' );
    else            % if fat
       L = chol( speye(m) + 1/rho*(A*A'), 'lower' );
    end
    
    % force matlab to recognize the upper / lower triangular structure
    L = sparse(L);
    U = sparse(L');
end
