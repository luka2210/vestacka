% s = [1 1 1 1 2 2 2 2 2];
% t = [3 5 4 2 6 10 7 9 8];
% 
% G = graph(s,t);
% plot(G)

s = [1 1 1 2 2 3];
t = [2 3 4 5 6 7];
names = {'A', 'B', 'C', 'D', 'E', 'F', 'G'};

G = digraph(s, t);
plot(G)

[searchNodes,iterations] = dfs(s,t,names,'C')
v = dfsearch(G, 3)
