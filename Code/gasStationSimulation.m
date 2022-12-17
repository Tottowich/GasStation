function [signals] = gasStationSimulation ...
    (T,n_pumps,tank_size,customer_rate,pump_que_cap)
% GASSTATION Simulate an arbritary Gas station set up.
%
%
% CALL SEQUENCE:
%
%   [ signals ] = gasStationSimulation(T,n_pumps,tank_size,customer_rate,pump_que_cap)
%
% INPUT:
%
%   T - (float)Amount of time to run the simulation, represents number of hours.
%       T=inf Simulates indefinitly
%   
%   n_pumps - (int) Number of active pumps at the gas station.
%
%   tank_size - (float) Number of liters the gas station can hold.
%
%   customer_rate - (float) Number of customers per time unit.
%
%   pump_que_cap - (int) Numbers of cars allowed to que per pump.
%
% OUTPUT:
%
%   signals - (struct) interesting signals that are produced by simulation.
%
% MWE:
% 
% T = 10;
% n_pumps = 4;
% tank_size = 10000;
% [ signals ] = gasStationSimulation(T,n_pumps,tank_size,customer_rate,pump_que_cap)
%
%

load_system("StartBlock.slx") % Load the gas station model.
% Set the simulation parameters to provided ones.
set_param('StartBlock', 'StopTime', num2str(T))
set_param('StartBlock/GasPumps','n_pumps',num2str(n_pumps));
set_param('StartBlock/CustomerCreation','mu_customers',num2str(customer_rate));
set_param('StartBlock/GasPumps','que_cap',num2str(pump_que_cap));
set_param('StartBlock/GasPumps','tank_size',num2str(tank_size));
% Run simulation:
sim("StartBlock.slx");
% Retrieve signals.
% customers = yout.getElement('CustomersOut');
gas_left = yout.getElement('GasLeft');

% TODO: Make this a function to calculate revenue and profit
% Calculate the amount of gas used.
% gas_over_time = gas_left.Values.Data;
% gas_left_in_tank = gas_over_time(end);
% gas_used= tank_size-gas_left_in_tank;
% % How much did the full tank cost.
% gas_costs = tank_size*buy_price;
% % How much did the pumps cost.
% pump_costs = 100*T*n_pumps;
% % How much did the station sell.
% revenue = gas_used*sell_price;
% 
% 
% profit = revenue-(pump_costs+gas_costs);
% Add output signals.
signals.gas_left = gas_left;
signals.customers = customers;
end