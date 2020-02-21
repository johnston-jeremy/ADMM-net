% for i = -4:2:4
%     %figure
%     plot(1:8,abs(fftshift(fft(ula(i*pi/5,8)))))
%     hold on
% end

N = 16;
% sampling grid
M = N;
Ng = 2*M;
g = linspace(-0.5,0.5,Ng)'*ones(1,3);
A = zeros(M,Ng);

for l = 0:Ng-1
    v = exp(-1i*2*pi*((l/Ng)*(0:N-1)'));
    A(:,l+1) = v;
end

% AA = [real(A), -imag(A); imag(A), real(A)];

% % target locations
L = round(0.1*M);
x = zeros(Ng,1);
i = randperm(Ng,L);
for n = 1:L
    x(i(n)) = randn(1,1) + 1i*randn(1,1);
end
xx = [real(x);imag(x)];

y = A*x;
% yy = AA*xx;

%stem([real(y); imag(y)] - yy)

[z, history] = lasso_original(A,y,1,1,1);
% zz = pinv(A)*y;%A\y;
% stem([real(z);imag(z)])
% hold
% stem([real(zz);imag(zz)])
% title('estimate')
% hold
% stem(xx)
% title('true')
% norm(abs(z)-abs(x))/norm(x);
e_z = norm(z-x)/norm(x);
% e_zz = norm(zz-x)/norm(x);