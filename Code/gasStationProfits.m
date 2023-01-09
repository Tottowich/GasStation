function [profit] = gasStationProfits...
    (signals,T,n_pumps,buy_price,sell_price,pump_hourly_cost,pump_rate)
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
%   pump_hourly_cost -(float) Cost of keeping pumps going.
%
%   pump_rate - (float) Number of liters per hour dispenser can pump.
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
simulated_time = gas_left.Values.Time(end);
tank_size = gas_left.Values.Data(1);
gas_over_time = gas_left.Values.Data;
gas_left_in_tank = gas_over_time(end);
gas_used= tank_size-gas_left_in_tank;
% How much did the full tank cost.
gas_costs = tank_size*buy_price;
% How much did the pumps cost.
% 1. Calculate total pumpt TIME
pump_time = gas_used/pump_rate;
pumping_cost = pump_hourly_cost*pump_time*n_pumps; % This is for active use.
idle_cost = (simulated_time-pump_time)*pump_hourly_cost/3;
pump_costs = pumping_cost+idle_cost;
% On idle it consumes 1/3 the amount of power.

% How much did the station sell.
revenue = gas_used*sell_price;
profit = revenue-(pump_costs+gas_costs);
if ~gas_left_in_tank
    profit = NaN;
end
end

