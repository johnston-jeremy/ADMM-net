function O = betafinal(m,n, I1, I2, I3, d1, M2 )
%% The final Multiplier update layer

%% network setting
config;

if nargin == 5  
    %% Compute u-update u^{k+1}
    % I1 = z^{k+1}
    % I2 = x^{k+1}
    % I3 = u^k
    u = I3 + I2 - I1;
    O = u;
end

if nargin == 7
    %% Compute dE/du^k
    % I2 = x^{k+1}, I3 = u^k
    
    % AULA = nnconfig.AULA;
    
    dEdx1 = d1;
    
    % dx1du =  -(eye(m+n)/Rho - AULA/Rho^2);   %-Rho*B;
    dx1du = -1*reshape(M2,[m+n,m+n]);
    dEdu = transpose(transpose(dEdx1)*dx1du);
    
    O = dEdu;
end

end

