%% network setting
global nnconfig;

% Number of stages in network
nnconfig.Stage = 20;

% Number of samples to use in training
nnconfig.TrainNumber = 100;

% Number of samples to generate in Gen_traindata.m
nnconfig.DataNmber = 100;

% Received signal vector length
nnconfig.ImageSize = 32;

% Number of frequency grid points
nnconfig.PartitionSize = 32;