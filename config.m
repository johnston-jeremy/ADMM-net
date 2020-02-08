%% network setting
global nnconfig;

% Number of stages in network
nnconfig.Stage = 10;

% Number of samples to use in training
nnconfig.TrainNumber = 10000;

% Number of samples to generate in Gen_traindata.m
nnconfig.DataNmber = 10000;

% Received signal vector length
nnconfig.ImageSize = 16;

% Number of frequency grid points
nnconfig.PartitionSize = 48;