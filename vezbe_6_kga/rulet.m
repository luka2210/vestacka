function [newpop] = rulet(oldpop, N, L)
    prob = cumsum(oldpop(:, L+2) ./ sum(oldpop(:, L+2)));
    rns = sort(rand(N, 1));
    
    fitin = 1;
    newin = 1;
    
    while (newin<=N)
        if (rns(newin) < prob(fitin))
            newpop(newin, :) = oldpop(fitin, :);
            newin = newin+1;
        else
            fitin = fitin+1;
        end
    end
end