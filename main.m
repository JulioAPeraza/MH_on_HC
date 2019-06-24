%% Metropolis-Hastings MH algorithm for brain connectome 
%
% Newman, E. M. J., & Barkema, G. T. (2001). The Ising model and the Metropolis 
% algorithm. In Monte Carlo Methods in Statistical Physics (pp. 45–87). Oxford, 
% UK: Oxford University Press.
%
% Running over the structure of the remapped Human Brain Connectome described in:
%
% Hagmann, P., Cammoun, L., Gigandet, X., Meuli, R., Honey, C. J., Wedeen, V. J., 
% & Sporns, O. (2008). Mapping the Structural Core of Human Cerebral Cortex. 
% PLoS Biology, 6(7), e159. https://doi.org/10.1371/journal.pbio.0060159.
%
% (File 'DSI_release2_2011.mat' provided by O. Sporns)
%
% The dynamics of the model as a function of the control parameter T was explored 
% by Peraza-Goicolea et al, Modeling functional resting-state brain networks
% through neural message-passing on the human connectome (2019).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all; clc

% data 
pathData = 'data\';
addpath('functions\');

% optional 
ncut = Inf; % Inf, 100 % reduce size of the connectome (for testing the code)

%% Step 0: Load data

data = load([pathData 'DSI_release2_2011.mat']);

J = sparse(data.CIJ_fbden_average);
if ~isinf(ncut)
    J = J(1:ncut,1:ncut); 
end

neigs = J'~=0;
N = size(J,1); % number of rigions of the Connectome
% We defined the message as i (sender), j (reseiver) and k (influencer): i->j,k 
[jIdx,iIdx,~] = find(neigs);
idx = sub2ind([N,N],jIdx,iIdx);
J = full(J(idx));

h = [];% external field
if isempty(h) 
    h = zeros(N,1); 
end

%% Step 1: Initialize all states randomly s_{i} +1 or -1
p = 0.5;% proportion [0 1], 0: all Negative, 1: all Positive, 0.5: half & half
s = sign(p-rand(N,1));
clear p

%% Step 1': Loop for temperatures 
% The values of temperatures are defined around the analitical value of the
% critical temperature (N_Tc) for an Erd?s–Rényi graph with J = average of the
% connectome, with N = size of the connectome and c = mean connectivity of
% the connectome
N_TC = N_critical_T(J, N); 
% Then, we define 100 values of temperatures: 50 values < N_TC and 50 > N_TC
temperature = (round(N_TC,1)/50):(round(N_TC,1)/50):(round(N_TC,1)*2);% values of temperature 
Ntemp = length(temperature);% number of temperature values 

figure;% figure to evaluate the equilibrium, checking m of the system for each mcs
m_mean = nan(Ntemp,1);
sus = nan(Ntemp,1);
iter = 1;
for T = temperature 
    B = 1/T;
    
    % We define the number of Monte Carlo steps acording to the equilibrium
    % of the system. In this case we will take 
    mcs = 100000;% Monte carlo steps for T<<Tc and T>>(Tc = temperature(50))
    if T>temperature(45) && T<temperature(55)
        mcs = mcs*10;% Monte carlo steps for values around Tc
    end
    % We take the last prom values to determine the observable m and sus assuming
    % the equilibration time is already reach at mcs-prom.
    prom = mcs/10;
    %% Step 2: Metropolis Steps
    m = nan(mcs,1);
    for j=1:mcs
        [s, m(j)] = one_metropolis_step(B, h, N, iIdx,jIdx,J,s);
    end
    
    %% Step 3: Checking the equilibrium
    plot((1:mcs), m);
    hold on
    
    %% Step 3: Mean Magnetization for each T
    interval = m(end-prom:end);% interval of the equilibrium state
    m_mean(iter) = mean(interval);
    disp([T m_mean(iter)]);%checking the m: m=1 for T<<T_C, m=0 for T>>T_C
    
    %% Step 4: System Susceptibility for each T
    sus(iter) = B*N*var(interval,1);
    
    iter = iter+1;
end
sus_max = max(sus);
T_C = temperature(sus==sus_max);

%% In case you want to visualize the results
visualization(temperature, m_mean, sus, sus_max, T_C);

%% Save the results
save ('results\m.txt', 'm_mean','-ascii');
save ('results\sus.txt', 'sus','-ascii');

