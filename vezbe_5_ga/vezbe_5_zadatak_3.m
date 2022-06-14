
% Problem
ezsurf('50*x_1^2+x_2^4-50*x_2^2',[-10,10,-10,10])

options = optimoptions('ga', 'PlotFcn', @gaplot1drange, 'InitialPopulationRange', [-0.01, -0.75; 0, -0.65]);

x = ga(@ez_povrsina, 2, [], [], [], [], [], [], [], options)

ez_povrsina(x)