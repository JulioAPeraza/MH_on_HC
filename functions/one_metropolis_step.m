function [s, m] = one_metropolis_step(B, h, N, iIdx,jIdx,J,s)

    for k=1:N
        sum_j = 0;% in case i does not have neighbours
        i = randi(N);
        %% The change in energy between the two states is: dE = 2*sum_j(J_ij * s_j)*s_i
        sum_j = sum(J(iIdx==i).*s(jIdx(iIdx==i)));% sum_j(J_ij * s_j)
        dE = 2*(sum_j + h(i)).*s(i);% 2 * sum_j * s_i
        
        %% Boltzmann probability of flipping
        prob = exp(-B *dE);
        
        %% Spin flip condition
        if dE <= 0 || rand() < prob
            s(i) = -s(i);
        end
    end

    %% Magnetization of the system
    m = mean(s);

end