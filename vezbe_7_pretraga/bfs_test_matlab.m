% s = [1 1 1 1 2 2 2 2 2];
% t = [3 5 4 2 6 10 7 9 8];
% G = graph(s,t);
% plot(G)


s = [1 1 1 2 2 3];
t = [2 3 4 5 6 7];

G = digraph(s,t);
plot(G)

[searchNodes,iterations] = bfs(s,t,1)
v = bfsearch(G, 1)