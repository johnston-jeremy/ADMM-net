function [ loss, real_x ] = loss_with_gradient_single_before( data, net )
train = data.train;
label = data.label;
LL = double(-1:0.02:1);
N = numel(net.layers);

res = struct(...
    'x',cell(1,N+1),...
    'dzdx',cell(1,N+1),...
    'dzdw',cell(1,N+1));
y = train;

%% forword propagation 
for n = 1:N
    l = net.layers{n};
    switch l.type
        case 'X_org'
            res(n).x = xorg (A, y , Rho, z_init, u_init);
        case 'Non_linorg'
            res(n).x = zorg(res(n-1).x , u_init , l.weights{1}, Rho);
        case 'Multi_org'
            res(n).x = betaorg(res(n-1).x , res(n-2).x , u_init);
        case 'X_mid'
            res(n).x = xmid( A, y, Rho, res(n-2).x , res(n-1).x);
        case 'Non_linmid'
            res(n).x = zmid(res(n-1).x , res(n-2).x , l.weights{1}, Rho );
        case 'Multi_mid'
            res(n).x = betamid(res(n-1).x , res(n-2).x , res(n-3).x);
        case 'Multi_final'
            res(n).x = betafinal(res(n-1).x , res(n-2).x , res(n-3).x);
        case 'X_final'
            res(n).x = xmid( A, y, Rho, res(n-2).x , res(n-1).x);
        case 'loss'
            res(n).x = rnnloss(res(n-1).x, label);
        otherwise
            error('No such layers type.');
    end
    
end;
    loss = res(N).x;
    loss = double(loss);
    real_x = res(N-1).x;      
end

    
            










