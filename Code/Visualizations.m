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
    plot_id = 0;
    function nice_plot(x,y,name,title_,style)
        % H for hist, P for plot.
        plot_id = plot_id + 1;
        plot(x,y,style,DisplayName=name)
        title(title_)
        grid on;
        legend(Location="best")
    end
    gas_left = signals.gas_left;
    customers = signals.customers;
    % Plot tank status over time:
    nice_plot(gas_left.Values.Time,gas_left.Values.Data,"Gas left in Tank",...
              "Gas Tank Status",".-k")


    % Plot the different attributes of the customers as histograms.
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
end



