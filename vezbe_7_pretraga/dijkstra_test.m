% dijkstra_test

%G = [0 3 9 0 0 0 0;
%     0 0 0 7 1 0 0;
%     0 2 0 7 0 0 0;
%     0 0 0 0 0 2 8;
%     0 0 4 5 0 9 0;
%     0 0 0 0 0 0 4;
%     0 0 0 0 0 0 0;
%     ];

%[e L] = dijkstra(G,1,7)

% drugi nacin​
s = [1 1 2 2 2 3 3 4 4 4 5 6];
t = [2 3 3 4 5 4 5 5 6 7 6 7];
weights = [3 9 2 7 1 7 4 5 2 8 9 4];
G = graph(s,t,weights);
plot(G,'EdgeLabel',G.Edges.Weight)
[P,d] = shortestpath(G,1,7)