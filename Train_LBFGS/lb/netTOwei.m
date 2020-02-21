function  wei = netTOwei(net)
%% This operation transforms the network to a weight vector
wei = [];
N = length(net.layers);
for n = 1:N
    if isfield(net.layers{n}, 'weights')
        for i = 1:length(net.layers{n}.weights)
            weight = net.layers{n}.weights{i};
            wei = [wei;weight(:)];
        end
    end
end

if ~isreal(wei)
    % separat real and imag parts
    wei = [real(wei); imag(wei)];
end

end

