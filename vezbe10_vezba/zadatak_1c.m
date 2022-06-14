s = [1, 1, 2, 2, 3, 3, 5, 6, 7];
t = [2, 5, 3, 5, 4, 5, 6, 7, 8];
w = [3, 10, 4, 5, 2, 6, 2, 4, 3];
h = [11.5, 10.4, 6.7, 7.0, 8.9, 6.9, 3.0];
names = {'S', 'A', 'B', 'C', 'D', 'E', 'F', 'G'};

[path, cost, heuristic, iterations] = greedybfs(s, t, w, h, names, 1, 7)