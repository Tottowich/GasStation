function [profit] = gasStationProfits...
    (signals,T,n_pumps,buy_price,sell_price)
% GASSTATIONPROFITS Calculate The profits of the gas station.
% 
% CALL SEQUENCE:
%
%   [ profit ] = gasStationProfits(signals,T,n_pumps,buy_price,sell_price)
%
% INPUT:
%   
%   signals - (struct) Signals and important values generated from the
%                      simulation
%   T - (float) Amount of time the gas station was simulated.
%
%   n_pumps - (int) Number of pumps. Pumps costs money to keep in rotation.
%
%   buy_price - (float) Cost of gas station to buy gas, [currency/L]
%
%   sell_price - (float) Cost of customers to buy gas, [currency/L]
%
% OUTPUT:
%
%   profit - (float) Amount of money made during the simulation.
%
% MWE:
%
%   [ signals ] = gasStationSimulation(...)
%   [ profit ] = gasStationProfits(signals,T,n_pumps,buy_price,sell_price)

gas_left = signals.gas_left;
tank_size = gas_left.Values.Data(1);
gas_over_time = gas_left.Values.Data;
gas_left_in_tank = gas_over_time(end);
gas_used= tank_size-gas_left_in_tank;
% How much did the full tank cost.
gas_costs = tank_size*buy_price;
% How much did the pumps cost.
pump_costs = 100*T*n_pumps;
% How much did the station sell.
revenue = gas_used*sell_price;
profit = revenue-(pump_costs+gas_costs);
end

