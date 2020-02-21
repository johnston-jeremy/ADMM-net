% for i = -4:2:4
%     %figure
%     plot(1:8,abs(fftshift(fft(ula(i*pi/5,8)))))
%     hold on
% end

Ntx = 1;
Nrx = 1;
N = 16;
L = 10;

% sampling grid
M = Ntx*Nrx*N;
Ng = M;
g = linspace(-0.5,0.5,Ng)'*ones(1,3);
A = zeros(M,Ng^2);
% for l = 1:Ng
%     H = ula(2*pi*g(l,3),Nrx)*ula(2*pi*g(l,3),Nrx)';
%     h = H(:);
%     v = exp(-1i*2*pi*(g(l,1)*(0:N-1)' + g(l,2)*((0:N-1).^2)'));
%     A(:,l) = kron(v,h);
% end

for l = 1:Ng
    for k = 1:Ng
    %     H = ula(2*pi*g(l,3),Nrx)*ula(2*pi*g(l,3),Nrx)';
    %     h = H(:);
        v = exp(-1j*2*pi*(g(l,1)*(0:N-1)' + g(k,2)*((0:N-1).^2)'));
        A(:,(l-1)*Ng + k) = v;
        % A(:,l) = kron(v,h);
    end
end

AA = [real(A), -imag(A); imag(A), real(A)];

% % target locations
x = zeros(Ng^2,1);
i = randperm(Ng^2,round(0.1*M));
r = randn(0.1*M,1) + 1i*randn(0.1*M,1);
x(i) = [real(r);imag(r)];
% for n = 1:L
%     x(i(n)) = randn(1);
% end

% x = sprandn(Ng,1,.025);

y = A*x;

yy = [real(y); imag(y)];
xx = [real(x); imag(x)];


[z, history] = lasso_original(A,y,1.5,1,1);
stem(abs(z))
% title('estimate')
hold
stem(abs(x))
% title('true')
norm(abs(z)-abs(x))/norm(x);

% l_tau = randperm(Ng,L);
% l_v = randperm(Ng,L);
% l_theta = randperm(Ng,L);
% x = zeros(8,3);
% x(:,1) = rand(L,1) - 0.5; %tau
% x(:,2) = rand(L,1) - 0.5; %v
% x(:,3) = rand(L,1) - 0.5; %theta

% y = zeros(Ntx*Nrx*N,1);
% 
% for l = 1:L
%     H = ula(2*pi*x(l,3),Nrx)*ula(2*pi*x(l,3),Nrx)';
%     h = H(:);
%     v = exp(-1i*2*pi*(x(l,1)*(0:N-1)' + x(l,2)*((0:N-1)'.^2)));
%     phi = kron(v,h);
%     y = y + phi;
% end