function A = gen_A(m,n)
% A is m by n
% mm = [0:m-1];
% real
% omega = [linspace(0,.5,n-m)];
% A = [sin(mm'*omega*2*pi) eye(m)];

% omega = pi*(0:n-1)/n;
% mm = [0:m-1];
% A = [sin(mm'*omega)];

% % complex
k = 0:n-1;
mm = 0:m-1;
A = exp(1i*2*pi*mm'*k/n);
% A = [exp(1j*mm'*omega*2*pi) eye(m)];
% A = [real(A), -imag(A); imag(A), real(A)];



end