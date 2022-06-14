function [potomak1, potomak2] = ukrstanje(roditelj1, roditelj2, pu, L, a, b)
    if (rand < pu)
        %tu = round(rand*(L-2)) + 1;
        tu = 3;
        
        potomak1 = [roditelj1(:, 1:tu), roditelj2(:, tu+1:L)];
        potomak2 = [roditelj2(:, 1:tu), roditelj1(:, tu+1:L)];
        
        potomak1(:, L+1) = potomak1(:, 1:L) * 2.^(L-1:-1:0)' * (b-a) / (2^L - 1) + a;
        potomak2(:, L+1) = potomak2(:, 1:L) * 2.^(L-1:-1:0)' * (b-a) / (2^L - 1) + a;
        potomak1(:, L+2) = function1(potomak1(:, L+1));
        potomak2(:, L+2) = function1(potomak2(:, L+1));
    else
        potomak1 = roditelj1;
        potomak2 = roditelj2;
    end
end