clc;
clear all;

x = [0, 0, 1, 1; 
     0, 1, 0, 1];
t = [0, 0, 0, 1];

net = perceptron;
net = configure(net, x, t);
net = train(net, x, t);

view(net);
y = net(x);

W = net.IW{1, 1};
b = net.b{1, 1};

plot(x(1, 1:3), x(2, 1:3), 'o');
hold on;
plot(x(1, 4), x(2, 4), 'x');
hold off;
xlim([-0.5, 1.5]);
ylim([-0.5, 1.5]);