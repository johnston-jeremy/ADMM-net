function [O, O2] = xfinal(A, Y, Rho, I1, I2, d1, I3)
%% Reconstruction layer in the middle of the network.
%% This layer has no parameters
%% This layer has two inputs: I1 = z ; I2 = u

%% network setting
config;
n = nnconfig.PartitionSize;
m = nnconfig.ImageSize;

dEdx = d1;
O = dEdx;
% O = (I2 - label)/(norm(Y)*norm(A*I2 - Y));

%% Compute dE/dM1, dE/dM2

dEdM1 = zeros(m+n,m);
dEdM2 = zeros(m+n,m+n);

for i = 1:(m+n)
    for j = 1:m
        dEdM1(i,j) = dEdx(i)*Y(j);
    end
end

for i = 1:(m+n)
    for j = 1:(m+n)
        dEdM2(i,j) = dEdx(i)*(I3(j)-I1(j));
    end
end

dEdM1 = reshape(dEdM1,[numel(dEdM1),1]);
dEdM2 = reshape(dEdM2,[numel(dEdM2),1]);

O2 = [dEdM1; dEdM2];

end
