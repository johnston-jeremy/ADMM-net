
1. Set training data and network parameters in config.m

2. Run Gen_traindata.m to generate the training data

3. Run main_netTrain.m to train the network.

Notes:

- The overall function call sequence for training is:
lgfbs.m -> loss_with_gradient_total.m -> loss_with_gradient_single.m

- lgfbs is the optimization algorithm used for network training. It takes as inputs
the average loss and the average loss gradient.

- The initial lambda1, lambda2 values are set in InitNet.m, which is called by main_netTrain.

- The folder layersfunction contains all of the layer operations.

- InitNet.m creates the network architecture.