options = optimoptions('ga','PlotFcn',@gaplot1drange);
x = ga(@two_min,1,[],[],[],[],[],[],[],options)
