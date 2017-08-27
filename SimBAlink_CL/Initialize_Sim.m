%% Initialization_Ideal_Powertrain.m in Ideal Powertrain Folder
%==========================================================================
%==========================================================================
%% Constant vehicle Parameters
% clear all
% close all
% clc





%% Initialization file for selecting driving cycles (velocity and time)


        if DRIV_Cycle == 1
           load Velocity_Profiles/FHDS;

        elseif DRIV_Cycle == 2
             load Velocity_Profiles/FUDS;

        elseif DRIV_Cycle == 3
            load Velocity_Profiles/FUDS_fast;

        elseif DRIV_Cycle == 4
            load Velocity_Profiles/WLTP;

        elseif DRIV_Cycle == 5
            load Velocity_Profiles/US06;
            
        elseif DRIV_Cycle == 6
            load Velocity_Profiles/US06_City_Cycle;
            
        elseif DRIV_Cycle == 7
            load Velocity_Profiles/US06_Highway_Cycle;
        
        elseif DRIV_Cycle == 8
           load Velocity_Profiles/Artemis_urban;
           
        elseif DRIV_Cycle == 9
           load Velocity_Profiles/Artemis_extra_urban;
           
        elseif DRIV_Cycle == 10
           load Velocity_Profiles/Artemis_highway;
        
        elseif DRIV_Cycle == 11
           load Velocity_Profiles/NEDC;
        
        elseif DRIV_Cycle == 12
           load Velocity_Profiles/PPIHC_CDTS;
           
        end
        
%         Stoptime = length(v_cyc);
        if DRIV_acc_flag ==0
           Stoptime = length(v_cyc)*iteration;
        else
           Stoptime = 60;
        end
        
%% Initialization for Selecting Vehicles (Mass, Effective Mass, Frontal Area)
  
          if VEH_Selection == 1 
            load Vehicle_Data/sportbike_generic;

        elseif VEH_Selection == 2 
            load Vehicle_Data/EXR100;
            
        elseif VEH_Selection == 3 
              load Vehicle_Data/RW-3x;
              
          end
%% Initialization for Selecting Road Grade Conditions (Alpha)
%grade angle in degrees (positive angle correponds to ascend)
 
    Road_Grade = Grade_Value;

%% Enviormental and road Conditions
          if ENV_Selection == 1 
            load Environment_Data/PikesPeak.mat;

        elseif ENV_Selection == 2 
            load Environment_Data/TRC_VDA.mat;
            
        end
          
            
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
