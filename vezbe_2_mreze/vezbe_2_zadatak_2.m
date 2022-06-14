x = [0 0 1 1; 0 1 0 1];
t = [0 1 1 1];

net = perceptron;
net = train(net,x,t);

view(net)
y = net(x);

plot (x(1,1),x(2,1),'bo')
hold on
plot (x(1,2:4),x(2,2:4),'rx')
hold off
xlim([-0.5 1.5])
ylim([-0.5 1.5])

%% weights and biases

weights_i = net.IW
weights_l = net.LW
biases = net.b

% weight and bias values:
   % IW: {2x1 cell} containing 1 input weight matrix
   % LW: {2x2 cell} containing 1 layer weight matrix
   % b: {2x1 cell} containing 2 bias vectors
