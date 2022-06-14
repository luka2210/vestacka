options = optimoptions('ga', 'PlotFcn', @gaplot1drange, 'InitialPopulationRange', [-10;90]);
x = ga(@two_min, 1, [], [], [], [], [], [], [], options)