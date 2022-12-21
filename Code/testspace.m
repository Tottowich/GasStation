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
% end
% %%
% mean(profits)
% %% Testing hungry probabilities
% N = 100000; % Arriving cars.
% Ps = 1:6;
% p = 0.4;
% for P = Ps
%     prob = sum(binornd(P,p,N,1)>=ceil(P/2))/N;
%     fprintf("Passengers: \'%d\' Probability to attempt to buy = %f\n\n",P,prob)
% end

load TrafficFlow.mat

tf = mean(traffic_flow(:,7:14),2);
tf = tf/max(tf);
t = (0:23)';
t2s = [0.2,23.6];

plot(t,tf,"-k","DisplayName","Original");
title("Traffic distribution per hour")
hold on
p = polyfit(t,tf,8);
plot(t,polyval(p,t),"-.b","DisplayName","Interpolated")
v = polyval(p,t2s);
scatter(t2s,v,"blue","filled")
% Splines
pp = spline(t,tf);
plot(t,ppval(pp,t),"-.r","DisplayName","Spline")
scatter(t2s,ppval(pp,t2s),"magenta")
% Repeat last point for peridicity
t = [t;t(1)+24];
tf = [tf;tf(1)];
pp = spline(t,tf);
plot(t,ppval(pp,t),"-.g","DisplayName","Spline 2")
scatter(t2s,ppval(pp,t2s),"green","filled")
grid on;
legend("Location","best")
hold off
% rep_points = 5;
% tf = [tf;tf(1:rep_points)];
% t = [t;t(1:rep_points)+23];
% plot(t,tf,"-r","DisplayName","Original");
% title("Traffic distribution per hour")
% p = polyfit(t,tf,9);
% plot(t,polyval(p,t),"-.k","DisplayName","Interpolated + "+rep_points)
% v = polyval(p,t2s);
% scatter(t2s,v,"black","filled")
grid on;
legend("Location","best")
hold off

