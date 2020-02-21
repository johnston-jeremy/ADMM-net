config;
n = nnconfig.PartitionSize; % width of A matrix
m = nnconfig.ImageSize;     % data vector size
A = gen_A(m,m+n);
% p1 = 1;                     % sparsity density  
% p2 = 1;
% x1 = zeros(n,1);
% x2 = zeros(m,1);
% x1(randperm(n,p1)) = 1;
% x2(randperm(m,p2)) = 1;
% x = [x1;x2];
p = round(0.05*m);
x = zeros(m+n,1);
x(randperm(m+n,p)) = 1;
noise = sqrt(.1)*randn(m,1);
bb = A*x;
b = bb + noise;
% stem(x)