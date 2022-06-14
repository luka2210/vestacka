s = [1, 1, 2, 2, 3, 3, 5, 6, 7];
t = [2, 5, 3, 5, 4, 5, 6, 7, 8];
w = [3, 10, 4, 5, 2, 6, 2, 4, 3];
names = {'S', 'A', 'B', 'C', 'D', 'E', 'F', 'G'};

G = graph(s, t, w, names);
plot(G)

[searchNodes, iterations] = bfs(s, t, names, 1)