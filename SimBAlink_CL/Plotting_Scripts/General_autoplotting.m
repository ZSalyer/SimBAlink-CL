
%% Powertrain (AMT) Results
% Date: 1/31/2013
% Qadeer Ahmed @ CAR,OSU
% Date: 6/30/2017
% Tong Zhao @ CAR,OSU
% Date: 09/04/2017
% Brody Ringler @ Buckeye Current,OSU

%%
clc
clf
close all
close all hidden

%% Monitor Position
MonitorSize = get(0, 'MonitorPositions');
MonitorWidth = MonitorSize(1,3) - 150;
MonitorHeight = MonitorSize(1,4) - 150;
MonitorLeft = 1;
MonitorBottom = 50;

% T_Simulation=T_simulation/60; % converting time into minutes
T_Simulation = T_simulation; % using time in seconds

%% Sampling inteval (Acceleration test has smaller sampling interval)
if max(DRIV_acc_flag) == 1
    n=10;
else
    n=100;
end

%% EM Efficiency
EM_eff_Figure = figure;
set(gcf,'position',[0 0 1000 400]);
plot(EM_max_min_RPM, EM_T_max_Peak,'k','LineWidth',1);
hold on
plot(EM_max_min_RPM, EM_T_min_Peak,'k','LineWidth',1);
hold on
[c,h] = contour(EM_max_min_RPM,EM_TorqueLookup,EM_eff_map,[0.8,0.84,0.86,0.88,0.9,0.92,0.94,0.95],'LineWidth',1);
clabel(c,h,[0.84,0.88,0.92,0.95]);
%clabel(c,h)
grid
hold on
plot(EM_RPM(1:n:length(EM_RPM)),EM_output_Torq(1:n:length(EM_output_Torq)),'*b','DisplayName','Electric Motor Torque (Nm)');

title('Electric Motor Torque (Nm)','Fontsize',16);
xlabel('Speed (rpm)','Fontsize',16)
ylabel('Torque (Nm)','Fontsize',16);
set(gca,'Fontsize',14);
axis([0 max(EM_RPM)+250 min(EM_output_Torq)-20 max(EM_output_Torq)+20]);

%% Battery Outputs
Batt_Figure = figure;
axis_link_current = subplot(311);
plot(T_Simulation,I_Batt,'LineWidth',1,'Color','blue');
set(gca,'Fontsize',12);
ylabel('Battery Current (A)','Fontsize',12);
grid
axis([0 max(T_Simulation) min(I_Batt) max(I_Batt+20)]);
set(gca, 'XTickLabel', [])
title('Battery Pack Output','Fontsize',16);
 
axis_link_voltage = subplot(312);
yyaxis left;
plot(T_Simulation,V_Batt,'LineWidth',1,'Color','blue');
set(gca,'Fontsize',12);
ylabel('Battery Voltage (V)','Fontsize',12);
grid
axis([0 max(T_Simulation) min(V_Batt) max(V_Batt)]);
hold on
yyaxis right;
plot(T_Simulation,SOC_Batt,'LineWidth',1,'Color','red');
grid
ylabel('SOC (%)','Fontsize',12);
axis([0 max(T_Simulation) min(SOC_Batt)-2 max(SOC_Batt)]);
set(gca, 'XTickLabel', [])

axis_link_temp = subplot(313);
plot(T_Simulation,T_Batt,'LineWidth',1,'Color','blue');
set(gca,'Fontsize',12);
xlabel('Time (sec)','Fontsize',12)
ylabel('Battery Temp (^{o}C)','Fontsize',12);
grid
axis([0 max(T_Simulation) min(T_Batt) max(T_Batt)]);

linkaxes([axis_link_current,axis_link_voltage,axis_link_temp],'x');

%% Powertrain Temps
Temp_Figure = figure;
axis_link_EMtemp = subplot(211);
plot(T_Simulation,EM_Temp,'LineWidth',1,'Color','blue');
set(gca,'Fontsize',12);
ylabel('Motor Temp (^{o}C)','Fontsize',12);
grid
axis([0 max(T_Simulation) min(EM_Temp)-10 max(EM_Temp)+10]);
set(gca, 'XTickLabel', [])
title('Powertrain Temps','Fontsize',16);
 
axis_link_MCtemp = subplot(212);
plot(T_Simulation,MC_Temp,'LineWidth',1,'Color','blue');
set(gca,'Fontsize',12);
ylabel('Motor Controller Temp (^{o}C)','Fontsize',12);
grid
axis([0 max(T_Simulation) min(MC_Temp)-10 max(MC_Temp)+10]);

linkaxes([axis_link_EMtemp,axis_link_MCtemp],'x');

%% Torque and speeds from EM
EM_Figure = figure;
axes_link_torque = subplot(311);
% yyaxis left;
plot(T_Simulation,EM_output_Torq,'LineWidth',1,'Color','blue');
ylabel('Torque (Nm)','Fontsize',12);
set(gca,'Fontsize',12);
axis([0 max(T_Simulation) min(EM_output_Torq) max(EM_output_Torq+20)]);
grid
%PLOT BRAKING TORQUES------------------------------
% hold on
% yyaxis right;
% plot(T_Simulation,Brake_Torque_Fr,'LineWidth',0.3,'Color','red');
% ylabel('Torque (Nm)','Fontsize',12);
% set(gca,'Fontsize',12);
% grid
% hold on
% yyaxis right;
% plot(T_Simulation,Brake_Torque_Rr,'LineWidth',0.3,'Color','red');
% ylabel('Torque (Nm)','Fontsize',12);
% set(gca,'Fontsize',12);
% axis([0 max(T_Simulation) min(Brake_Torque_Fr) max(Brake_Torque_Fr+20)]);
% grid
% legend('Electric Motor','Front Brake','Rear Brake','Location','southeast','AutoUpdate','off','Orientation','horizontal')
title('Electric Motor Output','Fontsize',16);
set(gca, 'XTickLabel', [])

axes_link_power = subplot(312);
plot(T_Simulation,EM_output_Pwr_kW,'LineWidth',1,'Color','blue');
ylabel('Power (kW)','Fontsize',12);
set(gca,'Fontsize',12);
grid
% legend('Electric Motor','Location','southeast','AutoUpdate','off','Orientation','horizontal')
% title('Electric Motor Outputs');
axis([0 max(T_Simulation) min(EM_output_Pwr_kW) max(EM_output_Pwr_kW+20)]);
set(gca, 'XTickLabel', [])

axes_link_speeds = subplot(313);
plot(T_Simulation,EM_RPM,'LineWidth',1,'Color','blue');
set(gca,'Fontsize',12);
ylabel('RPM','Fontsize',12);
xlabel('Time (sec)','Fontsize',12)
grid
axis([0 max(T_Simulation) 0 max(EM_RPM+500)]);
% legend('EM','Location','southeast','AutoUpdate','off','Orientation','horizontal')
linkaxes([axes_link_torque,axes_link_power,axes_link_speeds],'x');

%% Vehicle Speed and SOC
Position_Figure = figure;
axis_link_speed = subplot(311);
plot(T_Simulation,Desired_Speed_mph,'LineWidth',1,'Color','red');
hold on
plot(T_Simulation,Vehicle_Speed_mph,'LineWidth',1,'Color','blue');
grid
% xlabel('Time (sec)','Fontsize',16)
ylabel('Velocity (mph)','Fontsize',12);
legend('Desired','Actual','AutoUpdate','off')
axis([0 max(T_Simulation) 0 max(Desired_Speed_mph+20)]);
set(gca, 'XTickLabel', [])
title('Course Profile Output','Fontsize',16);

axis_link_SOC = subplot(312);
plot(T_Simulation,SOC_Batt,'LineWidth',1,'Color','blue');
grid
ylabel('SOC (%)','Fontsize',12);
axis([0 max(T_Simulation) min(SOC_Batt)-2 max(SOC_Batt)]);
set(gca, 'XTickLabel', [])

axis_link_dist = subplot(313);
yyaxis left;
plot(T_Simulation,Distance_mi,'LineWidth',1,'Color','blue');
ylabel('Distance (mi)','Fontsize',12);
axis([0 max(T_Simulation) 0 max(Distance_mi+2)]);
hold on

yyaxis right;
plot(T_Simulation,E_from_Battery,'LineWidth',1,'Color','red');
ylabel('Energy Used (kWhr)','Fontsize',12);
axis([0 max(T_Simulation) 0 max(E_from_Battery+1)]);
xlabel('Time (sec)','Fontsize',12);
legend('Distance (mi)','Energy Used (kWhr)','AutoUpdate','off')

linkaxes([axis_link_speed,axis_link_SOC,axis_link_dist],'x');

%% Align all figures
iptwindowalign(Batt_Figure,'bottom',Temp_Figure,'top');
iptwindowalign(Batt_Figure,'right',Temp_Figure,'left');
iptwindowalign(Batt_Figure,'right', EM_Figure,'left');
iptwindowalign(Batt_Figure,'left',Position_Figure,'right');
iptwindowalign(Batt_Figure,'bottom',EM_eff_Figure,'top');
iptwindowalign(Batt_Figure,'left',EM_eff_Figure,'hcenter');


