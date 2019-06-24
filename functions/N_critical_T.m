function N_TC = N_critical_T(J, N)

    c_mean = length(J)/N;% mean connectivity of the system
    J_mean = mean(J);
    syms B u c
    f = atanh(tanh(B*J_mean)*tanh(B*(c-1)*u))/B;
    df = diff(f,u);
    df = subs(df,u,0);
    df = subs(df,c,c_mean);
    
    N_TC = double(1/vpasolve(df==1,B));
end