% L1-regularized least-squares example

%% Generate problem data

randn('seed', 0);
rand('seed',0);

m = 100;       % number of examples
n = 200;       % number of features
n1 = n;
n2 = m;
p1 = 5;      % sparsity density  
p2 = 5;

x1 = zeros(n,1);
x1(randperm(n,p1)) = 1;
x2 = zeros(m,1);
x2(randperm(m,p2)) = 1;
%M = 500;
%N = 100;
omega = [linspace(0,1,n)];
mm = [0:m-1];
A = [exp(1j*mm'*omega*2*pi) eye(m)];
% A = randn(m,n);
% A = A*spdiags(1./sqrt(sum(A.^2))',0,n,n); % normalize columns
b = A*[x1;x2] + sqrt(.1)*randn(m,1);

lambda_max = norm( A'*b, 'inf' );
lambda = 0.1*lambda_max; 
lambda1 = .6;
lambda2 = .1;

%% Solve problem

[x history] = lasso(A, b, lambda1, lambda2, 1.0, 1.0, n, m);

figure;stem(abs(x(1:n)));hold on;
stem(abs(x1));
figure;stem(abs(x(n+1:n+m)));hold on;
stem(abs(x2));

%% Reporting
K = length(history.objval);                                                                                                        

h = figure;
plot(1:K, history.objval, 'k', 'MarkerSize', 10, 'LineWidth', 2); 
ylabel('f(x^k) + g(z^k)'); xlabel('iter (k)');

g = figure;
subplot(2,1,1);                                                                                                                    
semilogy(1:K, max(1e-8, history.r_norm), 'k', ...
    1:K, history.eps_pri, 'k--',  'LineWidth', 2); 
ylabel('||r||_2'); 

subplot(2,1,2);                                                                                                                    
semilogy(1:K, max(1e-8, history.s_norm), 'k', ...
    1:K, history.eps_dual, 'k--', 'LineWidth', 2);   
ylabel('||s||_2'); xlabel('iter (k)'); 

