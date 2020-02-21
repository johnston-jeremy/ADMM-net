% for i = -4:2:4
%     %figure
%     plot(1:8,abs(fftshift(fft(ula(i*pi/5,8)))))
%     hold on
% end

N = 16;
Ntx = 2;
Nrx = 2;
% sampling grid
M = N*Ntx*Nrx;
Ng = round((2*M)^(1/3));

A = zeros(M,Ng^3);

for l = 0:Ng-1
    for k = 0:Ng-1
        for m = 0:Ng-1
            v = exp(-1j*2*pi*((l/Ng)*(0:N-1)' + (m/Ng)*((0:N-1).^2)'));
            H = ula(2*pi*(k/Ng),Nrx)*ula(2*pi*(k/Ng),Ntx)';
            h = H(:);
            A(:, l*Ng^2 + k*Ng + (m + 1)) = kron(v,h);
        end
    end
end


% % target locations
L = 5;round(0.1*M);
x = zeros(Ng^3,1);
i = randperm(Ng^3,L);
for n = 1:L
    x(i(n)) = randn(1,1) + 1i*randn(1,1);
end
xx = [real(x); imag(x)];

y = A*x;


%stem([real(y); imag(y)] - yy)

[z, history1] = lasso_original(A,y,1,1,1);
% [z, history2] = lasso_original(A,y,1,1,1);
% stem(zz)
% hold
% stem(xx)
% stem(abs(z))
% stem(abs(x))
% stem([real(z); imag(z)])

e_z = norm(z-x)/norm(x);
% e_z = norm(z-x)/norm(z);