%% Generate training data
clear data

config;
ND = nnconfig.DataNmber;
TN = nnconfig.TrainNumber;

m = nnconfig.ImageSize;
n = m;
A = gen_A(m,n+m);

for i = 1:1:ND 

% % target locations
L = 3;
x = zeros(m+n,1);
p = randperm(m+n,L);
for k = 1:L
    x(p(k)) = randn(1,1) + 1i*randn(1,1);
end
y = A*x;

% store training pair
data.train = y;
data.label = x;
save(strcat('./data/ChestTrain_sampling/', saveName(i, 2)), 'data');
end

% for i = 1:TN
%     gen_signal;
%     data(i).train = bb;
%     data(i).label = x;
% end