% for i = -4:2:4
%     %figure
%     plot(1:8,abs(fftshift(fft(ula(i*pi/5,8)))))
%     hold on
% end

N = 32;
% sampling grid
M = N;
Ng = round((M));
A = zeros(M,Ng^2);

for l = 0:Ng-1
    for k = 0:Ng-1
        v = exp(-1j*2*pi*((l/Ng)*(0:N-1)' + (k/Ng)*((0:N-1).^2)'));
        A(:, l*Ng + (k+1)) = v;
        % A(:,l) = kron(v,h);
    end
end

% AA = [real(A), -imag(A); imag(A), real(A)];

% % target locations
L = 3;
x = zeros(Ng^2,1);
i = randperm(Ng^2,L);
for n = 1:L
    x(i(n)) = randn(1,1) + 1i*randn(1,1);
end
xx = [real(x);imag(x)];

y = A*x;

% stem([real(y); imag(y)] - yy)

[z, history] = lasso_original(A,y,2,1,1);
% stem([real(z);imag(z)])
% hold
% stem(xx)
% title('true')
% norm(abs(z)-abs(x))/norm(x);
e_z = norm(z-x)/norm(x);
