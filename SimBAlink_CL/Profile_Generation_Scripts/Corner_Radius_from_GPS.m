close all
clear
clc

%% Select GPS Data
% Launch data selection prompt
waitfor(msgbox('Press OK then select the GPS data file in MATLAB format.','Import Data File'));
[file_in.name,file_in.path] = uigetfile('.mat');
load(strcat(file_in.path,file_in.name));

% Plot LLA Data
geoshow(GPS_LLA.lat,GPS_LLA.lon)

%% Convert from LLA to Flat Earth
% Input arguments
fun_in.lla = [GPS_LLA.lat GPS_LLA.lon GPS_LLA.alt]; % m-by-3 array of geodetic coordinates (latitude, longitude, and altitude), in [degrees, degrees, meters]
fun_in.llo = [min(GPS_LLA.lat) min(GPS_LLA.lon)]; % reference location, in degrees, of latitude and longitude, for the origin of the estimation and the origin of the flat Earth coordinate system
fun_in.psio = 0; % angular direction of flat Earth x-axis (degrees clockwise from north)
fun_in.href = 0; % reference height from the surface of the Earth to the flat Earth frame with regard to the flat Earth frame, in meters

flat = lla2flat(fun_in.lla,fun_in.llo,fun_in.psio,fun_in.href);
flat = [flat(:,2) flat(:,1) -flat(:,3)];

%% Interpolate Flat Earth Data
cumSum = cat(1,0,cumsum(sqrt(sum(diff(flat).^2,2))));
flat_interp = interp1(cumSum,flat,linspace(0,cumSum(end),10000),'pchip');
cumSum_interp = cat(1,0,cumsum(sqrt(sum(diff(flat_interp).^2,2))));

% Plot interpolated flat earth data
scatter(flat_interp(:,1),flat_interp(:,2),[],flat_interp(:,3),'fill')
grid on
xlabel('X-Pos. [m] (from Lon.)')
ylabel('Y-Pos. [m] (from Lat.)')
cb.handle = colorbar;
cb.titleHandle = get(cb.handle,'Title');
cb.titleString = 'Altitude [m]';
set(cb.titleHandle,'String',cb.titleString);

% Export struct
GPS_Flat_Interp.x = flat_interp(:,1);
GPS_Flat_Interp.y = flat_interp(:,2);
GPS_Flat_Interp.z = flat_interp(:,3);
waitfor(msgbox('Press OK then choose location and name used to save flat eath data file.','Export Data File'));
[file_out.name,file_out.path] = uiputfile('*.mat');
file_out.address = fullfile(file_out.path,file_out.name);
save(file_out.address,'GPS_Flat_Interp')

%% Compute Corner Radius





