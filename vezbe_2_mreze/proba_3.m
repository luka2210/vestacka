p = [1, -1, 0; 2, 2, -1];
t = [1, 0, 0];

net = perceptron;
net = configure(net, p, t);

net.IW{1, 1} = [1, -0.8];
net.b{1, 1} = 0;
net.layers{1}.transferFcn = 'hardlim';

net = train(net, p, t);
view(net);
y = net(p);
