
close all;

%%%Load old race data first
load('\PPIHC2017_RW3x2_RaceData_allVarStruct_raceOnly.mat')

%% Motor Controller
%Controller Temp
figure;
plot(data.time, data.D1_Module_AC);
hold on;
plot(data.time, data.D2_Module_BC);
hold on;
plot(data.time, data.D3_Module_CC);
hold on;
plot(T_simulation, MC_Temp);
title('Controller Temperature (C)','Fontsize',16);
legend('Real_A','Real_B','Real_C','Simulation','AutoUpdate','off');

%% Motor
%Motor Current
figure;
plot(data.time, data.D1_Phase_A_CurrentA);
hold on;
EM_rms_phase_current = 0.714*EM_phase_current;
plot(T_simulation, EM_rms_phase_current);
title('Motor Current (A)','Fontsize',16);
legend('Real','Simulation','AutoUpdate','off');

%Motor Temp
figure;
plot(data.time, data.D3_Motor_TemperatureC);
hold on;
plot(T_simulation, EM_Temp);
title('Motor Temperature (C)','Fontsize',16);
legend('Real','Simulation','AutoUpdate','off');


%% Battery Pack
%Batt Temp
figure;
plot(data.time, data.CellTemp1C)
hold on
plot(data.time, data.CellTemp2C)
hold on
plot(data.time, data.CellTemp10none)
hold on
plot(data.time, data.CellTemp30none)
hold on
plot(data.time, data.CellTemp40none)
hold on
plot(T_simulation, T_Batt);
legend('Real_1','Real_2','Real_3','Real_4','Real_5','Simulation','AutoUpdate','off');

%Batt Current
figure;
plot(data.time, data.D4_DC_Bus_CurrentA1);
hold on;
plot(T_simulation, I_Batt);
title('DC Bus Current (A)','Fontsize',16);
legend('Real','Simulation','AutoUpdate','off');

%Batt Voltage
figure;
plot(data.time, data.D1_DC_Bus_VoltageV1);
hold on;
plot(T_simulation, V_Batt);
title('DC Bus Voltage (V)','Fontsize',16);
legend('Real','Simulation','AutoUpdate','off');
