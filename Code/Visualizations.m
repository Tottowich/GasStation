function Visualizations(signals)
    % VISUALIZATIONS Visualizes the results from gasStation Simulation.
    % 
    % CALL SEQUENCE:
    % 
    %   Visualizations(signals)
    % 
    % INPUT:
    %   
    %   signals - Simulink signal datatype, containing signals from gasStation.
    % 
    % OUTPUT:
    % 
    %   None
    % 
    %  MWE
    %
    %  [signals] = gasStationSimulation(...)
    %   Visualizations(signals)
    %
    
    simulated_time = signals.gas_left.Values.Time(end);
    % In our simulation we consider pre 4am to be night and post 21pm to be
    % night hours
    days = ceil(simulated_time/24);
    morning_hour = 4;
    night_hour = 21;
    mornings = morning_hour+(0:days)*24;
    mornings(end+1) = max(simulated_time);
    nights = night_hour+(0:days)*24;
    plot_id = 1;
    function nice_plot(x,y,title_,style)
        % H for hist, P for plot.
        plot(x,y,style)
        title(title_)
        grid on;
    end
    function plot_day_times()
        patch([0 morning_hour morning_hour 0],[max(ylim) max(ylim) 0 0],'k','DisplayName','')
        for i = 1:days
            morning = mornings(i);
            night = nights(i);
            next_morning = mornings(i+1);
            patch([morning night night morning],[max(ylim) max(ylim) 0 0],'y','DisplayName','')
            patch([night next_morning next_morning night],[max(ylim) max(ylim) 0 0],'k','DisplayName','')
        end
        alpha(0.5)
    end
    gas_left = signals.gas_left;
    customers = signals.customers;
    index_to_empty = find(gas_left.Values.Data==0,1);
    % Plot tank status over time:
    figure(plot_id)
    nice_plot(gas_left.Values.Time,gas_left.Values.Data,"Gas left in Tank",...
        ".-k")
    hold on;
    plot_day_times()
    nice_plot(gas_left.Values.Time,gas_left.Values.Data,"Gas left in Tank",...
        ".-k")
    if ~isempty(index_to_empty)
        empty_time = gas_left.Values.Time(index_to_empty);
        xline(empty_time,"-.r")
        legend(["Tank Status","Time to empty tank: "+empty_time],'Location','best')
    else
        legend('Location','best')
    end
    xlim([0,simulated_time])
    hold off
    %
    % Plot the different attributes of the customers as histograms.
    %
    fn = fieldnames(customers);
    plot_id = plot_id + 1;
    figure(plot_id)
    sgtitle('Distribution of all attributes at simulation.')
    set(gcf,'Position',[100 100 800 800])
    for k=1:numel(fn)
        d = customers.(fn{k}).Data;
        subplot(ceil(numel(fn)/2),2,k);
        histogram(d,Normalization="probability");
        title(fn{k})
        grid on;
    end
    hold off
    %
    % Plot arrival distribution:
    %
    plot_id = plot_id+1;
    clock_arrivals = mod(customers.Vehicle.Time,24);
    figure(plot_id);
    histogram(clock_arrivals,"Normalization","probability");
    xlabel("Time 0->24")
    xlim([0,24])
    grid on

end



