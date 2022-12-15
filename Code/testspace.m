%%
gasStation(100,1,1000)

%% Testing hungry probabilities
N = 100000; % Arriving cars.
Ps = 1:6;
p = 0.4;
for P = Ps
    prob = sum(binornd(P,p,N,1)>=ceil(P/2))/N;
    fprintf("Passengers: \'%d\' Probability to attempt to buy = %f\n\n",P,prob)
end