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
           
        end
        
%         Stoptime = length(v_cyc);
        if DRIV_acc_flag ==0
           Stoptime = length(v_cyc)*iteration;
        else
           Stoptime = 60;
        end
        
%% Initialization for Selecting Road Grade Conditions (Alpha)
%grade angle in degrees (positive angle correponds to ascend)
 
    Road_Grade = Grade_Value;
    
%% Initialization for Setting Ambient Temperature
%grade angle in degrees (positive angle correponds to ascend)
 
    ambTemp_K = ambTemp_C + 273.5;

