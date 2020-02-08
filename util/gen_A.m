function A = gen_A(m,n)
% A is m by n
mm = [0:m-1];
% real
% omega = [linspace(0,.5,n-m)];
% A = [sin(mm'*omega*2*pi) eye(m)];

omega = [linspace(0,.5,n)];
A = [sin(mm'*omega*2*pi)];

% % complex
% omega = [linspace(0,.5,n-m)];
% A = [exp(1j*mm'*omega*2*pi) eye(m)];
% A = [real(A), -imag(A); imag(A), real(A)];
end