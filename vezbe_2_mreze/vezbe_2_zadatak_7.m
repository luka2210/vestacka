% classification slide 21
%% input prepare network
P = [ -0.5 -0.5 +0.3 -0.1; -0.5 +0.5 -0.5 +1.0];
T = [1 1 0 0];

figure
plotpv(P,T);
net = newp(P,T);

% plot perceptron line - zero because it is not trained yet
plotpc(net.IW{1},net.b{1});

%% training
net.adaptParam.passes = 3;

% % jedno od sledeca dva
%net = adapt(net,P,T);
net = train(net,P,T);

%plot perceptron line - now it is possible
plotpc(net.IW{1},net.b{1});

%% simulation
p = [0.7; 1.2];
a = sim(net,p);

figure
plotpv(p,a);
point = findobj(gca,'type','line');
set(point,'Color','red');
hold on;
plotpv(P,T);
plotpc(net.IW{1},net.b{1});
hold off;