%% Initialization file for selecting Powertrain Components
%% EM Data
        if EM_MC_Selection == 1
            load Electric_Machine_Data/emrax268_PM150DZR;
        end
            
%% Cell Data
        if CELL_Selection == 1
            load Cell_Data/LiFePo4_generic_2pt5Ah;
        elseif CELL_Selection == 2
            load Cell_Data/A123_ANR26650;
        elseif CELL_Selection == 3
            load Cell_Data/LMO_26650_generic_4pt2Ah;
        end
        
