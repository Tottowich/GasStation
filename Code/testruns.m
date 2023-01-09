%% Messy testrun to easily keep in workspace.
buy_price = 18.0;
sell_price = 20.0;
n_pumps = 8;
T = 7*24;
tank_size = 1e5;
customer_rate = 60;
pump_que_cap = 2;
pump_hourly_cost = 50;%2250W => 
pump_rate = 1200; % liter/hour
[signals] = gasStationSimulation ...
    (T,n_pumps,tank_size,customer_rate,pump_que_cap,pump_rate);
[profit] = gasStationProfits(signals,T,n_pumps,buy_price,sell_price,pump_hourly_cost,pump_rate);
% t = timeit(@()gasStationSimulation ...
%      (T,n_pumps,tank_size,customer_rate,pump_que_cap,pump_rate))
% %%
%Visualizations(signals)