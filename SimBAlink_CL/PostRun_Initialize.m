%Post processing script run after simulation end/termination

%% Autoplotting Functions
    %compare_race_data


%% SOC Depleted Error 
    %Message alert is displayed if simulation terminated due to no energy
    if SOC_Batt(end) <0.1
      msgbox('You are out of energy dumbass!');
    end
    
%% Unknown Error
    %put something here that says something when something happens
