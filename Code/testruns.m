%% Messy testrun to easily keep in workspace.
buy_price = 15.0;
sell_price = 20.0;
n_pumps = 4;
T = 100;
tank_size = 100000;
customer_rate = 20;
pump_que_cap = 2;
[signals] = gasStationSimulation ...
    (T,n_pumps,tank_size,customer_rate,pump_que_cap);
[profit] = gasStationProfits(signals,T,n_pumps,buy_price,sell_price);
Visualizations(signals)

