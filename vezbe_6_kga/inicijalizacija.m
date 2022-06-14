function [pop] = inicijalizacija(N, L, a, b)
    pop = round(rand(N, L));
    pop(:, L+1) = pop(:, 1:L) * 2.^(L-1:-1:0)' * (b-a) / (2^L - 1) + a;
    pop(:, L+2) = sin(10.*pop(:, L+1)).^2 ./ (1 + pop(:, L+1));
end