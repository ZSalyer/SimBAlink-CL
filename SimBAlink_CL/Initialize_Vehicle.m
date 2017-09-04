%% Initialization file for selecting Powertrain Components
%% EM Data
        if EM_MC_Selection == 1
            load Electric_Machine_Data/emrax268_PM150DZR;
        end
            
%% Cell Data
        if CELL_Selection == 1
            load Cell_Data/LiFePo4_generic_2pt5Ah;
        
        end
        
