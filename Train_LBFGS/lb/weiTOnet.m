function net = weiTOnet(wei)
%% This operation transforms the weight vector to the network.
net = InitNet(0); % create blank network
if ~isreal(wei)
    % extract real and imag parts
    L = length(wei);
    wei = reshape(wei,L/2,2);
    wei = wei(:,1) + 1i*wei(:,2);
end
N = length(net.layers);
id = 0;
for n = 1:N
    l = net.layers{n};
    if isfield(l, 'weights')
        for i = 1:length(l.weights)
            idp = id + numel(l.weights{i});
            weitemp = wei(id+1:idp);
            net.layers{n}.weights{i} = reshape(weitemp, size(l.weights{i}));
            id = idp;
        end
    end
end
end