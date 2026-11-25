% Select the variables to compare
variables = {'Y','C','L','I'};

% Read the endogenous variable names
endo_names = cellstr(M_.endo_names);

% Open the comparison figure
figure('Name','IRFs across mu','NumberTitle','off');

% Plot each variable in its own subplot
for v = 1:length(variables)
    subplot(2,2,v);
    hold on;

    % Find this variable's steady-state position
    steady_index = find(strcmp(endo_names,variables{v}),1);

    % Plot the response for each scenario
    for s = 1:length(results)
        irf_field = [variables{v},'_eps_g'];
        irf = results(s).irfs.(irf_field);
        steady_value = results(s).steady_state(steady_index);
        plot(1:length(irf),100*irf/steady_value);
    end

    % Label the subplot and its scenario lines
    title(variables{v});
    xlabel('Periods after shock');
    ylabel('% of steady state');
    legend({results.label},'Location','best');
    hold off;
end

% Create the output folder if it does not exist
if exist('figures','dir') ~= 7
    mkdir('figures');
end

% Save the comparison figure while leaving it open
saveas(gcf,'figures/irfs_all_mu.png');