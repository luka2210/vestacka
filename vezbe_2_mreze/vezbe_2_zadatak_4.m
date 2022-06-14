clear all
clc
%% weights - if we do not define them are 0
% x = [1 -1 0; 2 2 -1];
% t = [1 0 0];
% 
% net = perceptron;
% net = train(net,x,t);
% 
% net.layers{1}.transferFcn = 'hardlim';
% 
% view(net)
% y = net(x);
% 
% plot (x(1,2:3),x(2,2:3),'bo')
% hold on
% plot (x(1,1),x(2,1),'rx')
% hold off
% xlim([-1.5 1.5])
% ylim([-1.5 2.5])
% 
% % weights and biases
% 
% weights_i = net.IW;
% weights_l = net.LW;
% biases = net.b;

%% our weights - if we define them
x = [1 -1 0; 2 2 -1];
t = [1 0 0];

net = perceptron;
net = configure(net,x,t);

net.layers{1}.transferFcn = 'hardlim';

IW = [1 -0.8];
b1 = 0;
net.IW{1,1} = IW;
net.b{1,1} = b1;

net = train(net,x,t);
view(net)
y = net(x);

weights_i = net.IW;
weights_l = net.LW;
biases = net.b;