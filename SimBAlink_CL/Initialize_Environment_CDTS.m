%% Initialization file for selecting driving cycles (velocity and time)


        if CDTS_Profile == 1
           load CDTS_Profiles/PPIHC_CDTS_1g;

        elseif CDTS_Profile == 2
             load CDTS_Profiles/CRP_1g;

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

