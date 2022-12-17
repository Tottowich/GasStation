%% OLD Does not work after refactoring for more modular approach.
% buy_price = 15.0;
% sell_price = 20.0;
% n_pumps = 4;
% T = 100;
% tank_size = 100000;
% customer_rate = 20;
% pump_que_cap = 2;
% profit = gasStation(T,n_pumps,tank_size,customer_rate,pump_que_cap)
% %%
% N = 100;
% profits = zeros(N,1);
% for i=1:N
%     fprintf("Simulation: %d",i)
%     profits(i) = gasStation(T,n_pumps,buy_price,sell_price,tank_size,customer_rate,pump_que_cap);
end
%%
mean(profits)
%% Testing hungry probabilities
N = 100000; % Arriving cars.
Ps = 1:6;
p = 0.4;
for P = Ps
    prob = sum(binornd(P,p,N,1)>=ceil(P/2))/N;
    fprintf("Passengers: \'%d\' Probability to attempt to buy = %f\n\n",P,prob)
end