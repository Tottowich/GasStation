%% Sweeping should occure here.
buy_price = 18.0;
sell_price = 20.0;
n_pumps = 8:20;
T = 7*24;
tank_size = (5:0.25:6)*10^5;
customer_rate = 150;
pump_que_cap = 2;
pump_hourly_cost = 50;%2250W => 
pump_rate = 1200; % liter/hour
np = length(n_pumps);
nt = length(tank_size);
profits = zeros(nt,np);
iters = 4;
f = waitbar(0,'Please wait...');
pos = get(f,'Position');
pos(4) = 80;
set(f,'Position', pos);
total_iter = iters*nt*np;
count = 0;
times = [];
for t = 1:nt
    for n = 1:np
        temps = zeros(iters,1);
        for i = 1:iters
            count = count+1;
            tic;
            signals = gasStationSimulation ...
                (T,n_pumps(n),tank_size(t),customer_rate,pump_que_cap,pump_rate);
            temps(i) = gasStationProfits(signals,T,n_pumps(n),buy_price,sell_price,pump_hourly_cost,pump_rate);
            time = toc;
            times = [times;time];
            process_time = mean(times);
            left = total_iter-count;
            time_left = process_time*left;
            waitbar(round(count/total_iter,3),f,"Time remaining: "+round(time_left,3)+newline+"Tank Size: ("+t+"/"+nt+")."+newline+"Number pumps: ("+n+"/"+np+")."+newline+"Iteration: ("+i+"/"+iters+")")
            if isnan(temps(i))
                temps(i:end) = NaN;
                count = count + np-i;
                break
            end
        end
        profits(t,n)=mean(temps(~isnan(temps)));
    end
end
waitbar(1,f,'Finishing');
close(f)
%% 3D Plotting
[X,Y] = meshgrid(tank_size,n_pumps);
surf(X,Y,profits');

xlabel('Tank size')
ylabel('Number of pumps')
zlabel('Profit')

title("Tank/Pump Sweep")
% scatter(n_pumps,profits)
% grid on
% hold on
% yline(0,'r')
% hold off 

