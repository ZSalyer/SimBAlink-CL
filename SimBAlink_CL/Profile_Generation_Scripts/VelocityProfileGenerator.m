%Velocity Profile from Corner-Radius Profile - Buckeye Current
%Created by Zach Salyer - 7/11/2018

clearvars;
clc;
close all;

%% Load Corner-Radius Profile Script
[file, path] = uigetfile();
filename = fullfile(path, file);
CornerRadius = importdata(filename); %Assumes Corner-Radius is in array with distance in first column and radius in second

%% Find Apexes of Track
%Find troughs of corner radius profile to find smallest radii aka the apex
InverseRadii = 1./CornerRadius(:,2);
[apex_radius, locs] = findpeaks(InverseRadii,CornerRadius(:,1));
for n = 1:length(locs) %Change from inverse radius back to actual radius
    apex_radius(n) = CornerRadius(locs(n),2);
end
%% Create acceleration limits

% Establish friction elipse acceleration limits - values chosen based on common racebike values found
longlim = 9.81; %Acceleration and braking limit (m/s^2)
latlim = 9.81*1.28; %Lateral acceleration at 52 deg lean angle (m/s^2) - 2017 spec was 55 deg true and 49.5 effective, but this didn't account for rider changing position and changing CG so 52 deg effective should be achievable

% At any time the acceleration must be less than sqrt(longacc^2 + latacc^2) - this is  the friction elipse

%% Calculate maximum possible Speed at all apexes
apex_velocity = zeros(length(apex_radius),1);

for n = 1:length(apex_radius)
    apex_velocity(n) = sqrt(latlim*apex_radius(n));
end

%% Use apex velocities as initial conditions/limits to calc velocity profile
velocity_profile = zeros(length(CornerRadius(:,1)),1); %Should be a velocity for each distance point

%Set velocities of each apex
velocity_profile(locs) = apex_velocity';

%% Use apex velocities and intial velocity of zero to populate velocity profile
velocity_profile_braking = velocity_profile;
velocity_profile_acceleration = velocity_profile;

for n = 1:length(locs)
   if n == 1 
       %Sets velocities based on braking into apex ------------------------
       for j = locs(n):-1:2
           
           %Calculate lateral acceleration of point before apex
           lat_g(j) = (velocity_profile_braking(j)^2)/CornerRadius(j,2);
           %Calculate longitudinal acceleration available at previous point
           long_g(j) = sqrt((1-(lat_g(j)^2)/(latlim^2))*(longlim^2));
           %Apply acceleration for distance until previous point
           velocity_profile_braking(j-1) = sqrt(velocity_profile_braking(j)^2 + 2*long_g(j)*abs((CornerRadius(j-1,1)-CornerRadius(j,1))));
       end
       
       %Find Velocities based on accelerating towards apex ----------------
       for j = 1:locs(n)
           if velocity_profile_acceleration(j) < velocity_profile_braking(j) %if this is false then we need to start braking and if we keep accelerating we will get imaginary numbers speed is too fast for radius
           %Calculate lateral acceleration of point before apex
           lat_g(j) = (velocity_profile_acceleration(j)^2)/CornerRadius(j,2);
           %Calculate longitudinal acceleration available at previous point
           long_g(j) = sqrt((1-lat_g(j)^2/latlim^2)*longlim^2);
           %Apply acceleration for distance until previous point
           velocity_profile_acceleration(j+1) = sqrt(velocity_profile_acceleration(j)^2 + 2*long_g(j)*abs((CornerRadius(j,1)-CornerRadius(j+1,1))));
           else
           velocity_profile_acceleration(j+1) = velocity_profile_acceleration(j);
           end
       end
       
%Determine velocity profile between these points  
        %Find smallest difference between acc and braking profiles
        velocity_dif = abs(velocity_profile_acceleration - velocity_profile_braking);
        velocity_dif = velocity_dif(1:locs(n));
        %Find index of smallest difference
        [~,change_index] = (min(velocity_dif));
        %Check if velocity of acc of this point is greater than next apex velocity
        if velocity_profile(locs(n)) > velocity_profile_acceleration(change_index)
           %This means we cannot accelerate to the maximum speed the corner can be taken at in time
           velocity_profile(1:locs(n)) = velocity_profile_acceleration(1:locs(n));
        else
           if velocity_profile_acceleration(change_index) < velocity_profile_braking(change_index)
            velocity_profile(1:change_index) = velocity_profile_acceleration(1:change_index);
            velocity_profile(change_index:locs(n)) = velocity_profile_braking(change_index:locs(n));
           else
            velocity_profile(1:change_index-1) = velocity_profile_acceleration(1:change_index-1);
            velocity_profile(change_index-1:locs(n)) = velocity_profile_braking(change_index-1:locs(n));
           end
        end

        
       
   else  %Need to correct this based on previous section corrections
       velocity_profile_acceleration = velocity_profile; %reset to correct velocity profiles
       velocity_profile_braking = velocity_profile;
       
       %Sets velocities based on braking into apex ------------------------
       for j = locs(n):-1:locs(n-1)+1
           %Calculate lateral acceleration of point before apex
           lat_g(j) = (velocity_profile_braking(j)^2)/CornerRadius(j,2);
           %Calculate longitudinal acceleration available at previous point
           long_g(j) = sqrt((1-(lat_g(j)^2)/(latlim^2))*(longlim^2));
           %Apply acceleration for distance until previous point
           velocity_profile_braking(j-1) = sqrt(velocity_profile_braking(j)^2 + 2*long_g(j)*abs((CornerRadius(j-1,1)-CornerRadius(j,1))));
           %Check if we are going too fast as we enter the previous apex
           if ~isreal(velocity_profile_braking(j-1))
               velocity_profile_braking(j-1) = velocity_profile_braking(j);
           end
       end
       
       for j = locs(n-1):locs(n)
           if velocity_profile_acceleration(j) < velocity_profile_braking(j) %if this is false then we need to start braking and if we keep accelerating we will get imaginary numbers speed is too fast for radius
           %Calculate lateral acceleration of point before apex
           lat_g(j) = (velocity_profile_acceleration(j)^2)/CornerRadius(j,2);
           %Calculate longitudinal acceleration available at previous point
           long_g(j) = sqrt((1-lat_g(j)^2/latlim^2)*longlim^2);
           %Apply acceleration for distance until previous point
           velocity_profile_acceleration(j+1) = sqrt(velocity_profile_acceleration(j)^2 + 2*long_g(j)*abs((CornerRadius(j,1)-CornerRadius(j+1,1))));
           else
           velocity_profile_acceleration(j+1) = velocity_profile_acceleration(j);
           end
       end
       
%Determine velocity profile between these points  
        %Find smallest difference between acc and braking profiles
        velocity_dif = abs(velocity_profile_acceleration - velocity_profile_braking);
        velocity_dif = velocity_dif(locs(n-1):locs(n));
        %Find index of smallest difference
        [~,change_index] = (min(velocity_dif));
        change_index = change_index + locs(n-1); %Need to set to correct index in velocity_profile
        %Check if velocity of acc of this point is greater than next apex velocity
        if velocity_profile(locs(n)) > velocity_profile_acceleration(change_index)
           %This means we cannot accelerate to the maximum speed the corner can be taken at in time
           velocity_profile(locs(n-1)+1:locs(n)) = velocity_profile_acceleration(locs(n-1)+1:locs(n));
        else
           if velocity_profile_acceleration(change_index) < velocity_profile_braking(change_index)
            velocity_profile(locs(n-1)+1:change_index) = velocity_profile_acceleration(locs(n-1)+1:change_index);
            velocity_profile(change_index:locs(n)) = velocity_profile_braking(change_index:locs(n));
           else
            velocity_profile(locs(n-1)+1:change_index-1) = velocity_profile_acceleration(locs(n-1)+1:change_index-1);
            velocity_profile(change_index-1:locs(n)) = velocity_profile_braking(change_index-1:locs(n));
           end
        end
     
        
   end
end

%% Accelerating from final apex to finish line
velocity_profile_acceleration = velocity_profile; %reset to correct velocity profiles
for j = locs(end):1:(length(CornerRadius(:,1))-1)
      lat_g(j) = (velocity_profile_acceleration(j)^2)/CornerRadius(j,2);
      %Calculate longitudinal acceleration available at previous point
      long_g(j) = sqrt((1-lat_g(j)^2/latlim^2)*longlim^2);
      %Apply acceleration for distance until previous point
      velocity_profile_acceleration(j+1) = sqrt(velocity_profile_acceleration(j)^2 + 2*long_g(j)*abs((CornerRadius(j,1)-CornerRadius(j+1,1))));
    
end

%Set velocity profile to end
velocity_profile(locs(end):length(CornerRadius(:,1))) = velocity_profile_acceleration(locs(end):length(CornerRadius(:,1)));

%% Plot Friction Ellipse
scatter(lat_g,long_g);
ylabel('Longitudinal Acceleration');
xlabel('Lateral Acceleration');
title('Friction Ellipse');

%% Plot Velocity Profile
figure()
plot(velocity_profile);
xlabel('Distance (m)');
ylabel('Velocity (m/s)');

