eps = 1e-8;
L = length(1:3:length(res));
K = length(x_history);
nn_x = zeros(m+n,L);
admm_x = zeros(m+n,L);

for l = 1:L
    nn_x(:,l) = res(3*(l-1) + 1).x;
end

for l = 1:L
    admm_x(:,l) = x_history(:,l);
end

count = 0;
err_nn = zeros(L,1);
err_admm = zeros(K,1);
for l = 1:L
    err_nn(l) = sum((nn_x(:,l) - d.label).^2)/norm(d.train);
end
for l = 1:K
    err_admm(l) = sum((x_history(:,l) - d.label).^2)/norm(d.train);
end
plot(err_nn)
hold
plot(err_admm(1:99))