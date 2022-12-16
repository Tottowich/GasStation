function profit = gasStation(T,n_pumps,buy_price,sell_price,tank_size,customer_rate,pump_que_cap)
% GASSTATION Simulate an arbritary Gas station set up.
%
%
% CALL SEQUENCE:
%
%   [ cash ] = gasStation(T, n_pumps, tank_size)
% INPUT:
%
%   T - Amount of time to run the simulation, represents number of hours.
%       T=inf Simulates indefinitly
%   
%   n_pumps - Number of active pumps at the gas station.
%
%   tank_size - Number of liters the gas station can hold, refilled on
%               specified interval.
%
% OUTPUT:
%
% profit - amount of profit eared by the gas station.
%
% MWE:
% 
% T = 10;
% n_pumps = 4;
% tank_size = 10000;
% cash = gasStation(T,n_pumps,tank_size)

load_system("StartBlock.slx") % Load the gas station model.
set_param('StartBlock', 'StopTime', num2str(T))
set_param('StartBlock/GasPumps','n_pumps',num2str(n_pumps));
set_param('StartBlock/CustomerCreation','mu_customers',num2str(customer_rate));
set_param('StartBlock/GasPumps','que_cap',num2str(pump_que_cap));
set_param('StartBlock/GasPumps','tank_size',num2str(tank_size));
sim("StartBlock.slx");
customers = yout.getElement('CustomersOut');
gas_left = yout.getElement('GasLeft');

gas_over_time = gas_left.Values.Data;
gas_left_in_tank = gas_over_time(end);
gas_used= tank_size-gas_left_in_tank;
plot(gas_over_time,DisplayName="Gas left")
time_arrivals = customers.Values.Time;
gas_costs = tank_size*buy_price;
revenue = gas_used*sell_price;
% Fixed costs.

% Pump prices.
pump_costs = 100*T*n_pumps;

profit = revenue-(pump_costs+gas_costs);
end