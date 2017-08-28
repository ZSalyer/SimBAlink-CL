%% Initialization file for selecting Powertrain Components
%% EM Data
        if EM_MC_Selection == 1
            load Electric_Machine_Data/emrax268_PM150DZR;
        
        elseif EM_MC_Selection == 2
            load Electric_Machine_Data/ME708_KDS48200e;            
            
        end
            
%% Cell Data
        if CELL_Selection == 1
            load Cell_Data/LiFePo4_generic;
        
        elseif CELL_Selection == 2
            load Cell_Data/A123_ANR2660;            
            
        end
        
