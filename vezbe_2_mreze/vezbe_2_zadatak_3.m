close all
clear all
clc

% Neuron weights
w = [4 -2];
% Neuron bias
b = -3;

% Activation function
func = 'tansig';
% func = 'purelin'
% func = 'hardlim'
% func = 'logsig'

p = [2 3];
activation_potential = p*w'+b;
neuron_output = feval(func, activation_potential);

[p1,p2] = meshgrid(-10:.25:10);
z = feval(func, [p1(:) p2(:)]*w'+b );
z = reshape(z,length(p1),length(p2));
plot3(p1,p2,z)
grid on
xlabel('Input 1')
ylabel('Input 2')
zlabel('Neuron output')