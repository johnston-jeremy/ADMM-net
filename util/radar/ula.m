function h = ula(theta, N)
    % -pi/2 < theta < pi/2
    % returns column vector
    
    h = exp(1i*theta*(0:N-1))';
    
    % h = cos(theta*(0:N-1))';
    
end

