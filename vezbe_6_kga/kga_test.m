clc
clear all

N = 20;
L = 5;
a = 0;
b = 1;
pu = 1;
pm = 1;

[pop] = inicijalizacija(N, L, a, b);
rulet(pop, N, L)