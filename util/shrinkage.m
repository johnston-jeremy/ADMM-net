function z = shrinkage(x, kappa)
    z = sign(x).*max(abs(x) - kappa,0);
    
    % z = max( 0, x - kappa ) - max( 0, -x - kappa );
end