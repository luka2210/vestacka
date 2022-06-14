clc
clear all

%% ucitavanje podataka
[x,t] = wine_dataset;

size(x)
size(t)

%% kreiranje mreze
net = patternnet(10);
view(net)

[net,tr] = train(net,x,t);

plotperform(tr)
%% testiranje mreze
testX = x(:,tr.testInd);
testT = t(:,tr.testInd);
testY = net(testX);

% tumacenje rezultata
plotconfusion(testT,testY)
[c,cm] = confusion(testT,testY);

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);

plotroc(testT,testY)
%testIndices = vec2ind(testY)