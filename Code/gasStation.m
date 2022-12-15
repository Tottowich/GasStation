function cash = gasStation(T,n_pumps,tank_size)
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
% cash - amount of money eared by the gas station.
%
% MWE:
% 
% T = 10;
% n_pumps = 4;
% tank_size = 10000;
% cash = gasStation(T,n_pumps,tank_size)
load_system("StartBlock.slx") % Load the gas station model.
set_param('StartBlock/GasPumps','n_pumps',num2str(n_pumps))
sim("StartBlock.slx")
out = yout.getElement('out')
end