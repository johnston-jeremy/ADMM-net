% L1-regularized least-squares example

%% Generate problem data

% randn('seed', 0);
% rand('seed',0);

% m = 1500;       % number of examples
% n = 5000;       % number of features
% p = 100/n;      % sparsity density  
% 
% x0 = sprandn(n,1,p);
% A = randn(m,n);
% A = A*spdiags(1./sqrt(sum(A.^2))',0,n,n); % normalize columns
% b = A*x0 + sqrt(0.001)*randn(m,1);


% m = 100;       % number of examples
% n = 200;       % number of features
% p = 3;      % sparsity density  
% 
% % x1 = sprandn(n,1,p);
% x1 = zeros(n,1);
% x1(randperm(n,5)) = 1;
% omega = [linspace(0,1,n)];
% mm = [0:m-1];
% A = [exp(-1j*2*pi*mm'*omega)];
% % A = randn(m,n);
% % A = A*spdiags(1./sqrt(sum(A.^2))',0,n,n); % normalize columns
% b = A*x1; %+ sqrt(0.00001)*randn(m,1); %+ j*sqrt(0.00001)*randn(m,1);
% 
% % lambda_max = norm( A'*b, 'inf' );
% % lambda = 0.1*lambda_max;
%figure;stem(x1);hold on;

config;
n = nnconfig.PartitionSize; % width of A matrix
m = 50;%nnconfig.ImageSize;     % data vector size
A = gen_A(m,n);
%A = [exp(-1j*2*pi*mm'*omega)];
p1 = 5;                     % sparsity density  
x1 = zeros(n,1);
x1(randperm(n,p1)) = 1;
noise = sqrt(.1)*randn(m,1);
b = A*x1 + noise;

lambda = 1;

%% Solve problem

[x history] = lasso_original(A, b, lambda, 1.0, 1.0);

figure
stem(x1)%hold on;
figure
stem(x)
err = sum((A*x - b).^2)/norm(b)

% %% Reporting
% K = length(history.objval);                                                                                                        
% 
% h = figure;
% plot(1:K, history.objval, 'k', 'MarkerSize', 10, 'LineWidth', 2); 
% ylabel('f(x^k) + g(z^k)'); xlabel('iter (k)');
% 
% g = figure;
% subplot(2,1,1);                                                                                                                    
% semilogy(1:K, max(1e-8, history.r_norm), 'k', ...
%     1:K, history.eps_pri, 'k--',  'LineWidth', 2); 
% ylabel('||r||_2'); 
% 
% subplot(2,1,2);                                                                                                                    
% semilogy(1:K, max(1e-8, history.s_norm), 'k', ...
%     1:K, history.eps_dual, 'k--', 'LineWidth', 2);   
% ylabel('||s||_2'); xlabel('iter (k)'); 
% 
% norm(x,1)