% for i = -4:2:4
%     %figure
%     plot(1:8,abs(fftshift(fft(ula(i*pi/5,8)))))
%     hold on
% end

N = 8;
Ntx = 2;
Nrx = 2;
% sampling grid
M = N*Ntx*Nrx;
Ng = round(M/2);
g = linspace(-0.5,0.5,Ng)'*ones(1,3);
A = zeros(M,Ng^2);

for l = 0:Ng-1
    for k = 0:Ng-1
        v = exp(-1j*2*pi*((l/Ng)*(0:N-1)'));
        H = ula(2*pi*(k/Ng),Nrx)*ula(2*pi*(k/Ng),Ntx)';
        h = H(:);
        A(:, l*Ng + (k+1)) = kron(v,h);
    end
end

% % target locations
L = 4;round(0.1*M);
x = zeros(Ng^2,1);
i = randperm(Ng^2,L);
for n = 1:L
    x(i(n)) = randn(1,1) + 1i*randn(1,1);
end
xx = [real(x);imag(x)];

y = A*x;
% yy = AA*xx;

%stem([real(y); imag(y)] - yy)

[z, history1] = lasso_original(A,y,1,1,1);
% [z, history2] = lasso_original(A,y,1,1,1);
% stem(zz)
% title('estimate')
% hold
% stem(xx)
% %stem([real(z); imag(z)])
% title('true')
% norm(abs(z)-abs(x))/norm(x);
e_z = norm(z-x)/norm(z);
% e_z = norm(z-x)/norm(z);
