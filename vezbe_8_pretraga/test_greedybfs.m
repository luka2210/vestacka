% test greedy best first search

% Example 01:
s = {'A','A','A','B','B','C'};
t = {'B','C','D','E','F','G'};
w = [1 5 3 4 5 9];
h = [5 2 3 6 4 1 0];
G = graph(s,t,w);
plot(G,'EdgeLabel',G.Edges.Weight)
[path,cost,heuristic,iterations] = greedybfs(s,t,w,h,'A','G')

% Example 02:
% s = [1 1 1 2 2 3];
% t = [2 3 4 5 6 7];
% w = [1 5 3 4 5 9];
% h = [5 2 3 6 4 1 0];
% names = {'A','B','C','D','E','F','G'};
% [path,cost,heuristic,iterations] = greedybfs(s,t,w,h,names,'A','G')

% Example 03:
% s = [1 1 1 2 2 3];
% t = [2 3 4 5 6 7];
% w = [1 5 3 4 5 9];
% h = [5 2 3 6 4 1 0];
% [path,cost,heuristic,iterations] = greedybfs(s,t,w,h,1,7)