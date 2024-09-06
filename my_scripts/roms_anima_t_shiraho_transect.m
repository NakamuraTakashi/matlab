%
% === ver 2016/03/10   Copyright (c) 2014-2016 Takashi NAKAMURA  =====
%                for MATLAB R2015a,b  


clear 
clc

% grd='../Data/Shiraho_reef/shiraho_reef_grid16.4.nc'; 

% his='/Users/yuta/mount/takagi/SedimentData/ocean_his_10_5.nc';
% his='/Users/yuta/COAWST_20240307_sediment_production_stable_with_data/Projects/Shiraho_reef/shiraho_sediment_his.nc';

% his='/Users/yuta/COAWST/Results/Shiraho_reef/ocean_seagrass_01_stable_qck.nc';

% his_qck='/Users/yuta/COAWST/Results/Shiraho_reef/ocean_seagrass_test_qck.nc';
% his_his='/Users/yuta/COAWST/Results/Shiraho_reef/ocean_seagrass_test_his.nc';


% % -------------- Unconstrained seagrass_straight_roots seagrass ------------------------------
% grd='/Users/yuta/COAWST/Data/Shiraho_reef/shiraho_reef_grid16_unconstrained_seagrass.nc'; 
% his_his='/Users/yuta/mount/takagi/SeagrassData/seagrass_straight_roots/ocean_seagrass_unconstrained_01_his.nc';
% his_qck='/Users/yuta/mount/takagi/SeagrassData/seagrass_straight_roots/ocean_seagrass_unconstrained_01_qck.nc';
% his_dia='/Users/yuta/mount/takagi/SeagrassData/seagrass_straight_roots/ocean_seagrass_unconstrained_01_dia.nc';

% % -------------- Unconstrained seagrass with SGD ------------------------------
grd='/Users/yuta/COAWST/Data/Shiraho_reef/shiraho_reef_grid16_unconstrained_seagrass.nc'; 
his_his='/Users/yuta/mount/takagi/SeagrassData/Shiraho_reef_seagrass_unconstrained_low_SGD/ocean_seagrass_unconstrained_low_SGD_01_his.nc';
his_qck='/Users/yuta/mount/takagi/SeagrassData/Shiraho_reef_seagrass_unconstrained_low_SGD/ocean_seagrass_unconstrained_low_SGD_01_qck.nc';
his_dia='/Users/yuta/mount/takagi/SeagrassData/Shiraho_reef_seagrass_unconstrained_low_SGD/ocean_seagrass_unconstrained_low_SGD_01_dia.nc';


% My color map
load('MyColormaps')

% set default flags
fix_bottom = false;
time_annot = true;

% set figure settings
marker_color = 'black';
transect_Y_position = 3.2; % Y position to create vertical profile along x-axis at Y (km) 
core_X_position = [0.6 2.5]; % X position along the transect to create vertical concentration plot (like a sediment core)

soil_density = 2.5; % (g/cm3)

% id = 1; his=his_his; Cbounds=[25 40];     color=colmap6;    % Temperature
% id = 2; his=his_his; Cbounds=[20 36];     color=colmap6;    % Salinity
% id = 3; his=his_his; Cbounds=[1700 2300]; color=colmap6;    % DIC
% id = 4; his=his_his; Cbounds=[1600 2800]; color=colmap6;    % TA    Cbounds=[2230 2360]
% id = 5; his=his_his; Cbounds=[0 250];    color=colmap7;    % DO
% id = 8; his=his_dia; Cbounds=[7 9];     color=colmap6;    % pH
    % id = 23; % Phytoplankton1
    % id = 24; % Phytoplankton2
    % id = 25; % Phytoplankton
% id = 26; his=his_his; Cbounds=[0 30]; color=colmap7;    % NO3
% id = 27; his=his_his; Cbounds=[0 30]; color=colmap7;    % NO3+NH4
% id = 28; his=his_his; Cbounds=[0 30]; color=colmap7;    % NH4
% id = 29; his=his_his; Cbounds=[0 5];  color=colmap7;    % PO4
    % id = 35; % DOC
    % id = 51; his=his_qck; Cbounds=[27 36];        color=colmap6; fix_bottom=true;    % Sediment Temperature
    % id = 52; his=his_qck; Cbounds=[32 36];        color=colmap6; fix_bottom=true;    % Sediment Salinity
    % id = 53; his=his_qck; Cbounds=[2050 2350];    color=colmap6; fix_bottom=true;    % Sediment TA
% id = 54; his=his_qck; Cbounds=[0 250]; color=colmap7; fix_bottom=true;    % Sediment DO
% id = 55; his=his_qck; Cbounds=[1000 2200]; color=colmap6; fix_bottom=true;    % Sediment DIC
    % id = 56; his=his_qck; Cbounds=[0 10]; color=colmap7; fix_bottom=true;    % Sediment N2
    % id = 57; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment DOC Labile          0, 1, colmap7, marker_color, ...
    % id = 58; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment DOC Refractory          0, 2100, colmap6, marker_color, ...
    % id = 59; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment POC Labile          0, 4, colmap7, marker_color, ...
    % id = 60; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment POC Refractory          832000, 852000, colmap6, marker_color, ...
    % id = 61; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment POC Non-degradable          832000, 852000, colmap6, marker_color, ...
% id = 62; his=his_qck; Cbounds=[0 30]; color=colmap7; fix_bottom=true;    % Sediment NO3
% id = 63; his=his_qck; Cbounds=[0 30]; color=colmap7; fix_bottom=true;    % Sediment NH4
% id = 64; his=his_qck; Cbounds=[0 5]; color=colmap7; fix_bottom=true;    % Sediment PO4         0, 12, colmap7, marker_color, ...
    % id = 65; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment DON Labile          0, 1, colmap7, marker_color, ...
    % id = 66; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment DON Refractory          0, 200, colmap7, marker_color, ...
    % id = 67; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment PON Labile          0, 100, colmap7, marker_color, ...
    % id = 68; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment PON Refractory          0, 100000, colmap7, marker_color, ...
    % id = 69; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment PON Non-degradable          0, 1000000, colmap7, marker_color, ...
    % id = 70; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment DOP Labile          0, 0.01, colmap7, marker_color, ...
    % id = 71; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment DOP Refractory          0, 30, colmap7, marker_color, ...
    % id = 72; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment POP Labile          0, 5, colmap7, marker_color, ...
    % id = 73; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment POP Refractory          0, 10000, colmap7, marker_color, ...
    % id = 74; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment POP Non-degradable         0, 10000, colmap7, marker_color, ...
    % id = 75; his=his_qck; Cbounds=[0 40]; color=colmap7; fix_bottom=true;    % Sediment Mn2        0, 500, colmap7, marker_color, ...
    % id = 76; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment MnO2       0, 20000, colmap7, marker_color, ...
    % id = 77; his=his_qck; Cbounds=[0 40]; color=colmap7; fix_bottom=true;    % Sediment Fe2        0, 5, colmap7, marker_color, ...
    % id = 78; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment FeS        0, 1, colmap7, marker_color, ...
    % id = 79; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment FeS2       7000, 10000, colmap7, marker_color, ...
    % id = 80; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment FeOOH      0, 200000, colmap7, marker_color, ...
    % id = 81; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment FeOOH_PO4      0, 0.2, colmap7, marker_color, ...
    % id = 82; his=his_qck; Cbounds=[0 40]; color=colmap7; fix_bottom=true;    % Sediment H2S       0, 0.01, colmap7, marker_color, ...
    % id = 83; his=his_qck; Cbounds=[0 40]; color=colmap7; fix_bottom=true;    % Sediment SO4        0, 30000, colmap7, marker_color, ...
    % id = 84; his=his_qck; Cbounds=[25 40]; color=colmap6; fix_bottom=true;    % Sediment S0         0, 30, colmap7, marker_color, ...
% id = 91; his=his_qck; Cbounds=[6500 9000]; color=colmap6; fix_bottom=true;    % Sediment sum of OC
% id = 92; his=his_qck; Cbounds=[550 800]; color=colmap6; fix_bottom=true;    % Sediment sum of ON
% id = 93; his=his_qck; Cbounds=[65 70]; color=colmap6; fix_bottom=true;    % Sediment sum of OP
% id = 401; his=his_his; Cbounds=[44 52];  color=colmap6;    % sum of DOC
% id = 402; his=his_his; Cbounds=[4.2 5.2];  color=colmap6;    % sum of DON
id = 403; his=his_his; Cbounds=[0.5 0.62];  color=colmap6;    % sum of DOP
% id = 404; his=his_his; Cbounds=[0 0.2];  color=colmap7;    % sum of POC
% id = 405; his=his_his; Cbounds=[0 0.02];  color=colmap7;    % sum of PON
% id = 406; his=his_his; Cbounds=[0 0.002];  color=colmap7;    % sum of POP
    % id = 407; his=his_his; Cbounds=[0 100];  color=colmap7;    % sum of OC
    % id = 408; his=his_his; Cbounds=[0 10];  color=colmap7;    % sum of ON
    % id = 409; his=his_his; Cbounds=[0 1];  color=colmap7;    % sum of OP
% id = 410; his=his_his; Cbounds=[0 15];  color=colmap7;    % sum of phytoplankton
% id = 411; his=his_his; Cbounds=[0 0.1];  color=colmap7;    % sum of zooplankton
    % id = 1001; % Air temperature
    % id = 1002; % Air pressure
    % id = 1003; % Humidity
    % id = 1004; % Rain fall rate
    % id = 1005; % Cloud fraction


output_folder = strcat('figs_png','_',num2str(id,'%0.4u'));
if (exist(strcat('output/', output_folder),'dir'))
    % error(strcat('Output directory /output/',output_folder,' already exists. Program terminated to prevent overwrite.'))
else
    mkdir(strcat('output/',output_folder)); 
end

starting_date=datenum(2000,1,1,0,0,0);


Nz=8; % for Shiraho
% Nz=15; %30-1
% Nz=30; %30-1

SedLayer=1;

% LOCAL_TIME='(UTC)';
% LOCAL_TIME='(JST)';
%LOCAL_TIME='(UTC+9)';
LOCAL_TIME='';

wet_dry = 0;  % Dry mask OFF: 0, ON: 1

xunit = 'km'; % 'm', 'latlon'
yunit = 'km'; % 'm', 'latlon'


LevelList = [0 0.2 0.5 3];


if 50 < id && id < 100
    axisratio = 4; % 4 cm:km
    zunit = 'cm'; % 'm', 'mm'
else
    axisratio = 12/6; % 10 m:km
    zunit = 'm'; % 'm', 'mm'
end


h          = ncread(grd,'h');

p_coral    = ncread(grd,'p_coral');
p_coral2   = ncread(grd,'p_coral2');
p_seagrass = ncread(grd,'p_seagrass');
p_algae    = ncread(grd,'p_algae');
p_sand     = ncread(grd,'p_sand');

p_sum = p_coral+p_coral2+p_seagrass+p_algae+p_sand;

% %%
% 
% i_temp = 12 + 1; 
% j_temp = 182 + 1;
% p_sand_temp = ncread(grd,'p_sand',[i_temp, j_temp], [1,1]);
% 
% p_sand_temp
% p_sum_temp = p_sum(i_temp,j_temp);
% over_temp = p_sum_temp - 1
% 
% %%
% 
% ncwrite(grd, 'p_sand', p_sand_temp-over_temp, [i_temp, j_temp])
% 
% %%

%lat_rho    = ncread(grd,'lat_rho');
%lon_rho    = ncread(grd,'lon_rho');
x_rho      = ncread(grd,'x_rho');
y_rho      = ncread(grd,'y_rho');
z_rho      = ncread(his_his,'s_rho');
z_sed      = ncread(his_qck,'sed_eco_layer');
mask_rho   = ncread(grd,'mask_rho');


if 50 < id && id < 100
    x_rho2 = repmat(x_rho(:,1), 1, size(z_sed,1));
    z_sed = repmat(z_sed(:,1), 1, size(x_rho, 1)).';
else
    x_rho2 = repmat(x_rho(:,1), 1, size(z_rho,1));
    z_rho = repmat(z_rho(:,1), 1, size(x_rho, 1)).';
end


[Im,Jm] = size(h);

c(1:Im,1:Jm)=0;
x_rho=(x_rho-min(min(x_rho)))/1000; % m->km
x_rho2=(x_rho2-min(min(x_rho2)))/1000; % m->km
y_rho=(y_rho-min(min(y_rho)))/1000; % m->km

% if 50 < id && id < 100
%     z_sed=(z_sed-min(min(z_sed))); % cm->cm
% else
%     z_rho=(z_rho-min(min(z_rho))); % ???
%     z_rho=h2.*z_rho;
% end

k=0;
i=1;

xmin=0;   xmax=max(max(x_rho));
ymin=0;   ymax=max(max(y_rho)); 
if 50 < id && id < 100
    zmin=0;   zmax=10;
else
    zmin=0;   zmax=30/6;
end

if 50 < id && id < 100
    xsize=315; ysize=780; % for SHIRAHO for Animation
else
    xsize=270; ysize=770; % for SHIRAHO for Animation
end

close all

if id <1000
%time = ncread(his,'ocean_time',[i],[1]);
    time = ncread(his,'ocean_time');
else
    time = ncread(his,'time');
end

imax=length(time);

% coral masking
coral_mask = (p_coral==0).*0+(p_coral>0).*1;
coral_mask = coral_mask ./coral_mask;
coral2_mask = (p_coral2==0).*0+(p_coral2>0).*1;
coral2_mask = coral2_mask ./coral2_mask;

mask_rho = mask_rho ./mask_rho;




if id <1000
    date=starting_date+time(i+1)/24/60/60;
else
    date=starting_date+time(i+1);
end

date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

tmp = zeros(size(x_rho));
tmp2 = zeros(size(x_rho2));

transectYindex = round(size(tmp, 2)*transect_Y_position/ymax);
coreXindex = round(size(tmp2, 1)*core_X_position/xmax);

h2 = ncread(grd,'h',[1 transectYindex],[Inf 1]);

if 50 < id && id < 100
    z_sed=(z_sed-min(min(z_sed))); % cm->cm
else
    z_rho=(z_rho-min(min(z_rho))); % ???
    z_rho=h2.*z_rho;
end


if id == 1
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        'Ocean Temperature',"\circC",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 2
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        'Ocean Salinity',"PSU",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 3
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Ocean Dissolved Inorganic Carbon"+newline+"(CO_3^{2-} + HCO_3^- + CO_2)",["umol" "kg"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 4
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        'Ocean Total Alkalinity',["umol" "kg"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 5
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Ocean Dissolved Oxygen"+newline+"(O_2)",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
% elseif id == 6
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,z_sed,tmp,h,date_str, '\delta^{13}C_{DIC} (permil)',-1,2.5,colmap6, xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 7
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str, 'Hs (m)',0,2.5,colmap6, xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 8 
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        'Ocean pH',"",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
% % elseif id == 9
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str, '\Omega_{arg}', 2.5, 6, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% % elseif id == 10
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'pCO_2 (\muatm)', 100, 700, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% % elseif id == 11
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'SS \phi=5um (kg m^-^3)', 0, 0.15, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% % elseif id == 12
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral Pg (nmol cm^-^2 s^-^1)',0, 0.6,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% % elseif id == 13
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral Pn (nmol cm^-^2 s^-^1)', -0.4, 0.4,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% % elseif id == 14
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral R (nmol cm^-^2 s^-^1)', 0, 0.35, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% % elseif id == 15
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral G (nmol cm^-^2 s^-^1)', -0.04, 0.12, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% % elseif id == 16
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral org-C (\mumol cm^-^2)', 0, 20, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% % elseif id == 17
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral \delta^{13}C_{org-C} (permil)', -21, -15, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 18
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment thickness (m)', 0, 0.0025, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 19
%     str = "Coral1 zoox." + newline + "density (cell cm^-^2)";
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, mycmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 20
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Coral growth rate (s^-^1)', 0, 0.000000012, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 21
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Coral mortality (s^-^1)', 0, 0.00000002, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 22
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sea surface elevation (m)', -1.0, 1.0, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 23
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Phytoplankton1 (umolC L^-^1) ', 0, 4, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 24
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Phytoplankton2 (umolC L^-^1) ', 0, 3, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 25
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Phytoplankton (umolC L^-^1) ', 0, 5, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 26
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Ocean Nitrate"+newline+"(NO_3^-)",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 27
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Ocean Nitrogen"+newline+"(NO_3^- + NH_4^+)",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 28
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Ocean Ammonium"+newline+"(NH_4^+)",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 29
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Ocean Phosphate"+newline+"(PO_4^{3-})",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
% elseif id == 35
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
%         'DOC (umol L^-^1) ', 65, 300, colmap7, ...
%         xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 30
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'SS \phi=200um (kg m^-^3)', 0, 0.15, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 31
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Chl-a (ug L^-^1) ', 0, 1.5, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 32
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Chl-a (ug L^-^1) ', 0, 1, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 33
%     str = "Coral2 zoox." + newline + "density (cell cm^-^2)";
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, colmap5,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 34
%     str = "Coral zoox." + newline + "density (cell cm^-^2)";
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1.9e6, colmap5,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 2.5e6, flipud(colmap6),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 36
%     str = "Coral mortality rate (d^-^1)";
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 5e-3, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 3e-3, colmap4, xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 51
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment Temperature',"\circC",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 52
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment Salinity',"PSU",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 53
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment Total Alkalinity',"umol kg^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 54
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        "Sediment Dissolved Oxygen"+newline+"(O_2)","umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 55
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        "Sediment Dissolved Inorganic Carbon"+newline+"(CO_3^{2-} + HCO_3^- + CO_2)","umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 56
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        "Sediment Nitrogen"+newline+"(N_2)","umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 57
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment DOC Labile',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 58
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment DOC Refractory',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 59
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment POC Labile',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 60
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment POC Refractory',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 61
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment POC Non-degradable',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 62
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        "Sediment Nitrate"+newline+"(NO_3^-)","umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 63
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        "Sediment Ammonium"+newline+"(NH_4^+)","umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 64
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        "Sediment Phosphate"+newline+"(PO_4^{3-})","umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 65
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment DON Labile',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 66
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment DON Refractory',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 67
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment PON Labile',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 68
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment PON Refractory',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 69
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment PON Non-degradable',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 70
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment DOP Labile',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 71
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment DOP Refractory',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 72
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment POP Labile',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 73
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment POP Refractory',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 74
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment POP Non-degradable',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 75
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment Mn2',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 76
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment MnO2',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 77
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment Fe2',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 78
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment FeS',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 79
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment FeS2',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 80
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment FeOOH',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 81
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment FeOOH_PO4',"nmol g^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 82
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment H2S',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 83
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment SO4',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 84
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment S0',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 91
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment Organic Carbon',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 92
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment Organic Nitrogen',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 93
    [h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4]=createfiguresedtransect(x_rho,x_rho2,y_rho,z_sed,tmp,tmp2,h,date_str, ...
        'Sediment Organic Phosphorus',"umol L^{-1}",Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position);
elseif id == 401 % sum of DOC
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Dissolved Organic Carbon",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 402 % sum of DON
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Dissolved Organic Nitrogen",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 403 % sum of DOP
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Dissolved Organic Phosphorus",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 404 % sum of POC
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Particulate Organic Carbon",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 405 % sum of PON
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Particulate Organic Nitrogen",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 406 % sum of POP
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Particulate Organic Phosphorus",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 407 % sum of OC
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "All Organic Carbon",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 408 % sum of ON
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "All Organic Nitrogen",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 409 % sum of OP
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "All Organic Phosphorus",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 410 % sum of phytoplankton
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Phytoplankton"+newline+"Carbon-biomass",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
elseif id == 411 % sum of zooplankton
    [h_surf,h_surf2,h_contour,h_annot,axes1,axes2]=createfiguretransect(x_rho,x_rho2,y_rho,z_rho,tmp,tmp2,h,date_str, ...
        "Zooplankton"+newline+"Carbon-biomass",["umol" "L"],Cbounds(1),Cbounds(2),color,marker_color, ...
        xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position);
% elseif id == 1001
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Air temperature (^oC)', 25, 33, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 1002
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Air pressure (hPa)', 950, 1020, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 1003
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Humidity (%)', 60, 100, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 1004
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Rain fall rate (kg m^-^2 s^-^1)', 0, 0.005, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 1005
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Cloud fraction', 0, 1, gray(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
end
drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]%[0 0 290 620]

% for i=1100:3:1100
% for i=imax:1:imax
% for i=1:1:1
for i=1:1:imax   

    if id == 1
        tmp = ncread(his,'temp',[1 1 Nz i],[Inf Inf 1 1]);  % Surface
        % tmp = ncread(his,'temp',[1 1 1 i],[Inf Inf 1 1]);  % bottom
        tmp2 =  squeeze(ncread(his,'temp',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 2
        tmp =  ncread(his,'salt',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'salt',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 3
        tmp = ncread(his,'TIC',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'TIC',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 4
        tmp = ncread(his,'alkalinity',[1 1 Nz i],[Inf Inf 1 1]) ;
        tmp2 =  squeeze(ncread(his,'alkalinity',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 5
        tmp = ncread(his,'oxygen',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'oxygen',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    % elseif id == 6
    %     tmp = ncread(his,'d13C_DIC',[1 1 Nz i],[Inf Inf 1 1]);
    % elseif id == 7
    %     tmp = ncread(his,'Hwave',[1 1 i],[Inf Inf 1]);
    elseif id == 8 
        tmp = ncread(his,'pH',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'pH',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    % elseif id == 9
    % %    tmp = ncread(his,'Warg',[i,0 0],[1,Jm,Im]);
    %     tmp = ncread(his,'Omega_arg',[1 1 i],[Inf Inf 1]);
    % elseif id == 10
    %     tmp = ncread(his,'pCO2',[1 1 i],[Inf Inf 1]);
    % elseif id == 11
    %     tmp = ncread(his,'mud_01',[1 1 Nz i],[Inf Inf 1 1]);
    % elseif id == 12
    %     tmp =  ncread(his,'coral1_Pg',[1 1 i],[Inf Inf 1]) .*coral_mask;
    % elseif id == 13
    %     tmp = ncread(his,'coral1_Pn',[1 1 i],[Inf Inf 1]) .*coral_mask;
    % elseif id == 14
    %     tmp = ncread(his,'coral1_R',[1 1 i],[Inf Inf 1]) .*coral_mask;
    % elseif id == 15
    %     tmp = ncread(his,'coral1_G',[1 1 i],[Inf Inf 1]) .*coral_mask;
    % elseif id == 16
    %     tmp = ncread(his,'coral1_orgC',[1 1 i],[Inf Inf 1]) .*coral_mask;
    % elseif id == 17
    %     tmp = ncread(his,'coral1_d13Ctissue',[1 1 i],[Inf Inf 1]) .*coral_mask;
    % elseif id == 18
    %     tmp = ncread(his,'bed_thickness',[1 1 1 i],[Inf Inf 1 1]);
    % elseif id == 19
    %     tmp = ncread(his,'coral1_densZoox',[1 1 i],[Inf Inf 1]) .*coral_mask;
    % elseif id == 20
    %     tmp = ncread(his,'coral_growth',[1 1 i],[Inf Inf 1]) .*coral_mask;
    % elseif id == 21
    %     tmp = ncread(his,'coral_mort',[1 1 i],[Inf Inf 1]) .*coral_mask;
    % elseif id == 22
    %     tmp = ncread(his,'zeta',[1 1 i],[Inf Inf 1]).*mask_rho;
    % elseif id == 23
    %     tmp = ncread(his,'phytoplankton1',[1 1 Nz i],[Inf Inf 1 1]) ;
    % elseif id == 24
    %     tmp = ncread(his,'phytoplankton2',[1 1 Nz i],[Inf Inf 1 1]) ;
    % elseif id == 25
    %     tmp = ncread(his,'phytoplankton1',[1 1 Nz i],[Inf Inf 1 1]) ;
    %     tmp = tmp+ncread(his,'phytoplankton2',[1 1 Nz i],[Inf Inf 1 1]) ;
    elseif id == 26
        tmp = ncread(his,'NO3',[1 1 Nz i],[Inf Inf 1 1]) ;
        tmp2 =  squeeze(ncread(his,'NO3',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 27
        tmp = ncread(his,'NO3',[1 1 Nz i],[Inf Inf 1 1]) ...
            + ncread(his,'NH4',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'NO3',[1 transectYindex 1 i],[Inf 1 Inf 1])) ...
             +  squeeze(ncread(his,'NH4',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 28
        tmp = ncread(his,'NH4',[1 1 Nz i],[Inf Inf 1 1]) ;
        tmp2 =  squeeze(ncread(his,'NH4',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 29
        tmp = ncread(his,'PO4',[1 1 Nz i],[Inf Inf 1 1]) ;
        tmp2 =  squeeze(ncread(his,'PO4',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    % elseif id == 35
    %     tmp = ncread(his,'DOC',[1 1 Nz i],[Inf Inf 1 1]) ;
    % elseif id == 30
    %     tmp = ncread(his,'mud_02',[1 1 Nz i],[Inf Inf 1 1]);
%     elseif id == 31
%         tmp = ncread(his,'phytoplankton1',[1 1 Nz i],[Inf Inf 1 1]) ;
%         tmp = tmp + ncread(his,'phytoplankton2',[1 1 Nz i],[Inf Inf 1 1]) ;
%         tmp = tmp * 0.24;
%     elseif id == 32
%         tmp = ncread(his,'phytoplankton2',[1 1 Nz i],[Inf Inf 1 1]) ;
%         tmp = tmp * 0.24;
%     elseif id == 33
%         tmp = ncread(his,'coral2_densZoox',[1 1 i],[Inf Inf 1]) .*coral2_mask;
%     elseif id == 34
%         mask1 = coral_mask;
%         mask1(isnan(mask1))=0;
%         mask2 = coral2_mask;
%         mask2(isnan(mask2))=0;
%         tmp = ncread(his,'coral1_densZoox',[1 1 i],[Inf Inf 1]) .*mask1;
%         tmp = tmp + ncread(his,'coral2_densZoox',[1 1 i],[Inf Inf 1]) .*mask2;
%         mask1=mask1+mask2;
%         mask1=mask1./mask1;
%         if i==1
%             tmp=1.82e6;
%         end
%         tmp = tmp.*mask1;
%     elseif id == 36
%         mask1 = coral_mask;
%         mask1(isnan(mask1))=0;
%         mask2 = coral2_mask;
%         mask2(isnan(mask2))=0;
%         tmp = ncread(his,'coral1_mort',[1 1 i],[Inf Inf 1]) .*mask1;
%         tmp = tmp + ncread(his,'coral2_mort',[1 1 i],[Inf Inf 1]) .*mask2;
%         mask1=mask1+mask2;
%         mask1=mask1./mask1;
% %         if i==1
% %             tmp=0;
% %         end
%         tmp = tmp*24*60*60.*mask1;
    elseif id == 51
        tmp =  ncread(his,'sediment_Tmp',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_Tmp',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 52
        tmp =  ncread(his,'sediment_Sal',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_Sal',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 53
        tmp =  ncread(his,'sediment_TA',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_TA',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 54
        tmp =  ncread(his,'sediment_O2',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_O2',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 55
        tmp =  ncread(his,'sediment_CO2',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_CO2',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 56
        tmp =  ncread(his,'sediment_N2',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_N2',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 57
        tmp =  ncread(his,'sediment_DOCf',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_DOCf',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 58
        tmp =  ncread(his,'sediment_DOCs',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_DOCs',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 59
        tmp =  ncread(his,'sediment_POCf',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_POCf',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 60
        tmp =  ncread(his,'sediment_POCs',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_POCs',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 61
        tmp =  ncread(his,'sediment_POCn',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_POCn',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 62
        tmp =  ncread(his,'sediment_NO3',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_NO3',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 63
        tmp =  ncread(his,'sediment_NH4',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_NH4',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 64
        tmp =  ncread(his,'sediment_PO4',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_PO4',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 65
        tmp =  ncread(his,'sediment_DONf',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_DONf',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 66
        tmp =  ncread(his,'sediment_DONs',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_DONs',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 67
        tmp =  ncread(his,'sediment_PONf',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_PONf',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 68
        tmp =  ncread(his,'sediment_PONs',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_PONs',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 69
        tmp =  ncread(his,'sediment_PONn',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_PONn',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 70
        tmp =  ncread(his,'sediment_DOPf',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_DOPf',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 71
        tmp =  ncread(his,'sediment_DOPs',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_DOPs',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 72
        tmp =  ncread(his,'sediment_POPf',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_POPf',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 73
        tmp =  ncread(his,'sediment_POPs',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_POPs',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 74
        tmp =  ncread(his,'sediment_POPn',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_POPn',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 75
        tmp =  ncread(his,'sediment_Mn2',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_Mn2',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 76
        tmp =  ncread(his,'sediment_MnO2',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_MnO2',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 77
        tmp =  ncread(his,'sediment_Fe2',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_Fe2',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 78
        tmp =  ncread(his,'sediment_FeS',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_FeS',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 79
        tmp =  ncread(his,'sediment_FeS2',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_FeS2',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 80
        tmp =  ncread(his,'sediment_FeOOH',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_FeOOH',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 81
        tmp =  ncread(his,'sediment_FeOOH_PO4',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_FeOOH_PO4',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 82
        tmp =  ncread(his,'sediment_H2S',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_H2S',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 83
        tmp =  ncread(his,'sediment_SO4',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_SO4',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 84
        tmp =  ncread(his,'sediment_S0',[1 1 SedLayer i],[Inf Inf 1 1]);
        tmp2 =  squeeze(ncread(his,'sediment_S0',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 91 % sum sediment of OC
        tmp =  ncread(his,'sediment_DOCf',[1 1 SedLayer i],[Inf Inf 1 1])...
             + ncread(his,'sediment_DOCs',[1 1 SedLayer i],[Inf Inf 1 1])...
             + ncread(his,'sediment_POCf',[1 1 SedLayer i],[Inf Inf 1 1])*soil_density... % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
             + ncread(his,'sediment_POCs',[1 1 SedLayer i],[Inf Inf 1 1])*soil_density... % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
             + ncread(his,'sediment_POCn',[1 1 SedLayer i],[Inf Inf 1 1])*soil_density;   % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L);
        tmp2 =  squeeze(ncread(his,'sediment_DOCf',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
              + squeeze(ncread(his,'sediment_DOCs',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
              + squeeze(ncread(his,'sediment_POCf',[1 transectYindex 1 i],[Inf 1 Inf 1]))*soil_density... % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
              + squeeze(ncread(his,'sediment_POCs',[1 transectYindex 1 i],[Inf 1 Inf 1]))*soil_density... % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
              + squeeze(ncread(his,'sediment_POCn',[1 transectYindex 1 i],[Inf 1 Inf 1]))*soil_density;   % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L);
    elseif id == 92 % sum sediment of OC
        tmp =  ncread(his,'sediment_DONf',[1 1 SedLayer i],[Inf Inf 1 1])...
             + ncread(his,'sediment_DONs',[1 1 SedLayer i],[Inf Inf 1 1])...
             + ncread(his,'sediment_PONf',[1 1 SedLayer i],[Inf Inf 1 1])*soil_density... % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
             + ncread(his,'sediment_PONs',[1 1 SedLayer i],[Inf Inf 1 1])*soil_density... % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
             + ncread(his,'sediment_PONn',[1 1 SedLayer i],[Inf Inf 1 1])*soil_density;   % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
        tmp2 =  squeeze(ncread(his,'sediment_DONf',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
              + squeeze(ncread(his,'sediment_DONs',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
              + squeeze(ncread(his,'sediment_PONf',[1 transectYindex 1 i],[Inf 1 Inf 1]))*soil_density... % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
              + squeeze(ncread(his,'sediment_PONs',[1 transectYindex 1 i],[Inf 1 Inf 1]))*soil_density... % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
              + squeeze(ncread(his,'sediment_PONn',[1 transectYindex 1 i],[Inf 1 Inf 1]))*soil_density;   % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
    elseif id == 93 % sum sediment of OC
        tmp =  ncread(his,'sediment_DOPf',[1 1 SedLayer i],[Inf Inf 1 1])...
             + ncread(his,'sediment_DOPs',[1 1 SedLayer i],[Inf Inf 1 1])...
             + ncread(his,'sediment_POPf',[1 1 SedLayer i],[Inf Inf 1 1])*soil_density... % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
             + ncread(his,'sediment_POPs',[1 1 SedLayer i],[Inf Inf 1 1])*soil_density... % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
             + ncread(his,'sediment_POPn',[1 1 SedLayer i],[Inf Inf 1 1])*soil_density;   % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L);
        tmp2 =  squeeze(ncread(his,'sediment_DOPf',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
              + squeeze(ncread(his,'sediment_DOPs',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
              + squeeze(ncread(his,'sediment_POPf',[1 transectYindex 1 i],[Inf 1 Inf 1]))*soil_density... % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
              + squeeze(ncread(his,'sediment_POPs',[1 transectYindex 1 i],[Inf 1 Inf 1]))*soil_density... % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L)
              + squeeze(ncread(his,'sediment_POPn',[1 transectYindex 1 i],[Inf 1 Inf 1]))*soil_density;   % (nmol/g) (g/cm3) (umol/1000nmol) (1000cm3/L);
    elseif id == 401 % sum of DOC
        tmp = ncread(his,'DOC_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'DOC_02',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 = squeeze(ncread(his,'DOC_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'DOC_02',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 402 % sum of DON
        tmp = ncread(his,'DON_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'DON_02',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 = squeeze(ncread(his,'DON_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'DON_02',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 403 % sum of DOP
        tmp = ncread(his,'DOP_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'DOP_02',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 = squeeze(ncread(his,'DOP_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'DOP_02',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 404 % sum of POC
        tmp = ncread(his,'POC_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'POC_02',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 = squeeze(ncread(his,'POC_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'POC_02',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 405 % sum of PON
        tmp = ncread(his,'PON_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'PON_02',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 = squeeze(ncread(his,'PON_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'PON_02',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 406 % sum of POP
        tmp = ncread(his,'POP_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'POP_02',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 = squeeze(ncread(his,'POP_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'POP_02',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 407 % sum of OC
        tmp = ncread(his,'DOC_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'DOC_02',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'POC_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'POC_02',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 = squeeze(ncread(his,'DOC_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'DOC_02',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'POC_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'POC_02',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 408 % sum of ON
        tmp = ncread(his,'DON_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'DON_02',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'PON_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'PON_02',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 = squeeze(ncread(his,'DON_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'DON_02',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'PON_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'PON_02',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 409 % sum of OP
        tmp = ncread(his,'DOP_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'DOP_02',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'POP_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'POP_02',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 = squeeze(ncread(his,'DOP_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'DOP_02',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'POP_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'POP_02',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 410 % sum of phytoplankton
        tmp = ncread(his,'phytoplankton_01',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'phytoplankton_02',[1 1 Nz i],[Inf Inf 1 1])...
            + ncread(his,'phytoplankton_03',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 = squeeze(ncread(his,'phytoplankton_01',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'phytoplankton_02',[1 transectYindex 1 i],[Inf 1 Inf 1]))...
             + squeeze(ncread(his,'phytoplankton_03',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    elseif id == 411 % sum of zooplankton
        tmp = ncread(his,'zooplankton_01',[1 1 Nz i],[Inf Inf 1 1]);
        tmp2 = squeeze(ncread(his,'zooplankton_01',[1 transectYindex 1 i],[Inf 1 Inf 1]));
    % elseif id == 1001
    %     tmp = ncread(his,'Tair',[1 1 i],[Inf Inf 1]);
    % elseif id == 1002
    %     tmp = ncread(his,'Pair',[1 1 i],[Inf Inf 1]);
    % elseif id == 1003
    %     tmp = ncread(his,'Qair',[1 1 i],[Inf Inf 1]);
    % elseif id == 1004
    %     tmp = ncread(his,'rain',[1 1 i],[Inf Inf 1]);
    % elseif id == 1005
    %     tmp = ncread(his,'cloud',[1 1 i],[Inf Inf 1]);
    end

    if wet_dry == 1
        wetdry_mask_rho = ncread(his,'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
        wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
        tmp = tmp .* wetdry_mask_rho;
    end

    if fix_bottom
        tmp(:, 1) = tmp(:, 2); % fix bottom
    end

    %depth =squeeze(zeta(i,:,:))+h;
    %depth =zeta+h;
    %date=datenum(2009,8,25,0,0,0)+time/24/60/60;
    if id <1000
        date=starting_date+time(i)/24/60/60;
    else
        date=starting_date+time(i);
    end

    date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

    set(h_surf,'CData',tmp)
    set(h_surf2,'CData',tmp2)
    axes(axes2)
    set(gca, 'YDir','reverse')
    set(gca, 'XTickLabel', [])
    if 50 < id && id < 100
        axes(axes3)
        set(gca, 'YDir','reverse')
        % set(gca, 'YTickLabel', [])
        set(h_core1,'XData',tmp2(coreXindex(1), :))
        set(h_core1,'YData',z_sed(coreXindex(1), :))    
        axes(axes4)
        set(gca, 'YDir','reverse')
        % set(gca, 'YTickLabel', [])
        set(h_core2,'XData',tmp2(coreXindex(2), :))
        set(h_core2,'YData',z_sed(coreXindex(2), :))   
    end

    if time_annot
        set(h_annot,'String',date_str)
    end

    set(axes1 ,'Layer', 'Top')
    set(axes2 ,'Layer', 'Top')
    if 50 < id && id < 100
        set(axes3 ,'Layer', 'Top')
    end


    drawnow()

    date_str2 = erase(date_str, ["-", " ", ":"]);
    
    hgexport(figure(1), strcat('output/',output_folder,'/t01_',date_str2,'.png'),hgexport('factorystyle'),'Format','png');

end



