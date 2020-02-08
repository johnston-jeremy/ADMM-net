function [x, l] = grad_descent(x0, r, tol, maxiter)
l = inf;
lprev = 0;
iter = 0;
x = x0;
while abs(l - lprev) > tol
    lprev = l;
    [l,g] = loss_with_gradient_total(x);
    x = x - r*g;
    iter = iter + 1;
    % stem(g)
    if mod(iter, 1) == 0
        fprintf('iter = %i \n loss = %2.5f \n', iter, l)
    end
    if iter > maxiter
        break;
    end
end
end