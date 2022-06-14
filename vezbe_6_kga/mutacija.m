function [potomak] = mutacija(roditelj, pm, L, a, b)
    if (rand < pm)
        tm = round(rand*(L-1)) + 1;
        potomak = roditelj;
        potomak(tm) = abs(potomak(tm) - 1);
        potomak(:, L+1) = potomak(:, 1:L) * 2.^(L-1:-1:0)' * (b-a) / (2^L - 1) + a;
        potomak(:, L+2) = function1(potomak(:, L+1));
    else
        potomak = roditelj;
    end
end