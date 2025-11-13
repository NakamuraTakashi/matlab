%
% === ver 2025/04/14   Copyright (c) 2014-2016 Takashi NAKAMURA  2023-2025 Yuta A Takagi =====
%                for MATLAB R2023a  

clear
clc
close all

addpath('/Users/yuta/Documents/TiTech/Nakamura_Lab/Simulation/matlab/') 
% cd '/Users/yuta/Documents/TiTech/Nakamura_Lab/Simulation/matlab/'

% grd='../Data/Shiraho_reef/shiraho_reef_grid16.3.nc'; 
% 
% his='../Projects/Shiraho_reef/shiraho_sediment_his';
% his='/Users/yuta/COAWST_20240307_sediment_production_stable_with_data/Projects/Shiraho_reef/shiraho_sediment_his.nc';
% 
% his_qck='/Users/yuta/COAWST/Results/Shiraho_reef/ocean_seagrass_test_qck.nc';
% his_his='/Users/yuta/COAWST/Results/Shiraho_reef/ocean_seagrass_test_his.nc';
% 
% his='/Users/yuta/COAWST/Results/Shiraho_reef/ocean_seagrass_test2_his.nc';

% % -------------- Unconstrained seagrass_straight_roots seagrass ------------------------------
% grd='/Users/yuta/COAWST/Data/Shiraho_reef/shiraho_reef_grid16_unconstrained_seagrass.nc'; 
% his_his='/Users/yuta/mount/takagi/SeagrassData/seagrass_straight_roots/ocean_seagrass_unconstrained_01_his.nc';
% his_qck='/Users/yuta/mount/takagi/SeagrassData/seagrass_straight_roots/ocean_seagrass_unconstrained_01_qck.nc';
% his_dia='/Users/yuta/mount/takagi/SeagrassData/seagrass_straight_roots/ocean_seagrass_unconstrained_01_dia.nc';

% % -------------- Unconstrained seagrass with SGD ------------------------------
% grd='/Users/yuta/COAWST/Data/Shiraho_reef/shiraho_reef_grid16_unconstrained_seagrass.nc'; 
% grd2='/Users/yuta/COAWST/Data/Shiraho_reef/shiraho_reef_grid16.3.nc'; 
% his_his='/Users/yuta/mount/takagi/SeagrassData/Shiraho_reef_seagrass_unconstrained_low_SGD/ocean_seagrass_unconstrained_low_SGD_01_his.nc';
% his_qck='/Users/yuta/mount/takagi/SeagrassData/Shiraho_reef_seagrass_unconstrained_low_SGD/ocean_seagrass_unconstrained_low_SGD_01_qck.nc';
% his_dia='/Users/yuta/mount/takagi/SeagrassData/Shiraho_reef_seagrass_unconstrained_low_SGD/ocean_seagrass_unconstrained_low_SGD_01_dia.nc';

% % -------------- Seagrass 2025/04/14 ------------------------------
grd='/Volumes/syn1/yuta/COAWST_DATA/Yaeyama/Shiraho_reef2/Grid/shiraho_roms_grd_JCOPET_v18.1.nc'; 
his_his='/Volumes/syn1/yuta/COAWST_OUTPUT/Yaeyama/Shiraho_reef2_eco/SR_veg_eco2_sg_his_20231001_test_17.nc';
his_qck='/Volumes/syn1/yuta/COAWST_OUTPUT/Yaeyama/Shiraho_reef2_eco/SR_veg_eco2_sg_qck_20231001_test_17.nc';
his_dia='/Volumes/syn1/yuta/COAWST_OUTPUT/Yaeyama/Shiraho_reef2_eco/SR_veg_eco2_sg_dia_20231001_test_17.nc';

% ncdisp(grd)
% ncdisp(his_his)


% My color map
load('MyColormaps')

% set default flags
fix_bottom = false;
time_annot = true;


    % id = 8; his=his_dia; Cbounds=[7 12];     color=colmap6;    % pH
    % id = 12; % Coral Pg
    % id = 13; % Coral Pn
    % id = 14; % Coral R
    % id = 15; % Coral G
    % id = 16; % Coral org-C
    % id = 19; % Coral1 zoox. density 
    % id = 20; % Coral growth rate
    % id = 21; % Coral mortality
    % id = 22; % Sea surface elevation
    % id = 33; % Coral2 zoox. density
    % id = 34; % Coral2 zoox. density
    % id = 36; % Coral mortality rate
% id = 40; his=grd; Cbounds=[0 1];     color=colmap7; time_annot=false;    % SGD map
% id = 41; his=grd; Cbounds=[0 1];     color=colmap7; time_annot=false;    % coral map
% id = 42; his=grd; Cbounds=[0 1];     color=colmap7; time_annot=false;    % seagrass map
    % id = 201; his=his_his; Cbounds=[400000 600000];   color=colmap6; fix_bottom = true;     % seagrass_SgCBm    400000, 600000, colmap7,
    % id = 202; his=his_dia; Cbounds=[0 1000000];       color=colmap6; fix_bottom = true;     % seagrass_LfCBm    0, 1000000, colmap7
    % id = 203; his=his_dia; Cbounds=[0 1000000];       color=colmap6; fix_bottom = true;     % seagrass_RtCBm    0, 1000000, colmap7
    % id = 204; his=his_dia; Cbounds=[0 1000000];       color=colmap6; fix_bottom = true;     % seagrass_ELAP     0, 1000000
% id = 205; his=his_his; Cbounds=[0 100];             color=colmap7; fix_bottom = true;     % seagrass_TotSgCBm
    % id = 206; his=his_qck; Cbounds=[0 10];            color=colmap7; fix_bottom = true;     % seagrass_TotLfCBm
    % id = 207; his=his_qck; Cbounds=[0 10];            color=colmap7; fix_bottom = true;     % seagrass_TotRtCBm
    % id = 208; his=his_qck; Cbounds=[0 100];           color=colmap7; fix_bottom = true;     % seagrass_LA
    % id = 221; his=his_his; Cbounds=[0 2];             color=colmap7; fix_bottom = true;     % seagrass_Phot
% id = 222; his=his_his; Cbounds=[0 4]; alphaMax = 0.1;  color=colmap6; fix_bottom = true;     % seagrass_Phot_Limiting
    % id = 223; his=his_his; Cbounds=[0 1];             color=colmap7; fix_bottom = true;     % seagrass_Resp
% id = 224; his=his_his; Cbounds=[-15 15];        color=colmap10;fix_bottom = true;     % seagrass_Net_Phot
    % id = 225; his=his_his; Cbounds=[0 0.01];           color=colmap7; fix_bottom = true;     % seagrass_Dieoff
id = 230; his=his_his; Cbounds=[-15 15];        color=colmap10;fix_bottom = true;     % seagrass_Net_Phot
    % id = 1001; % Air temperature
    % id = 1002; % Air pressure
    % id = 1003; % Humidity
    % id = 1004; % Rain fall rate
    % id = 1005; % Cloud fraction



starting_date=datenum(2000,1,1,0,0,0);


Nz=8; % for Shiraho
% Nz=15; %30-1
% Nz=30; %30-1

SedLayer=1;

% LOCAL_TIME='(UTC)';
LOCAL_TIME=' (JST)';
%LOCAL_TIME='(UTC+9)';
% LOCAL_TIME='';
UTC_offset = 9;

wet_dry = 0;  % Dry mask OFF: 0, ON: 1


unit = 'km'; % 'm', 'latlon'
% LevelList = [0 0.2 0.5 3 20];
% LevelList = [-1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
LevelList = [-2 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30];


h          = ncread(grd,'h');
p_coral_01  = ncread(grd,'p_coral_01');
p_coral_02  = ncread(grd,'p_coral_02');
%p_sgrass_01 = ncread(grd,'p_sgrass_01');
%lat_rho    = ncread(grd,'lat_rho');
%lon_rho    = ncread(grd,'lon_rho');
x_rho      = ncread(grd,'x_rho');
y_rho      = ncread(grd,'y_rho');
mask_rho   = ncread(grd,'mask_rho');

[Im,Jm] = size(h);

c(1:Im,1:Jm)=0;
x_rho=(x_rho-min(min(x_rho)))/1000; % m->km
y_rho=(y_rho-min(min(y_rho)))/1000; % m->km

k=0;
i=1;

xmin=0;   xmax=max(max(x_rho));  ymin=0;   ymax=max(max(y_rho));
% xmin=0;   xmax=2.3;  ymin=0;   ymax=max(max(y_rho));

%xsize=500; ysize=650; % for SHIRAHO zoom
% size=250; ysize=500; % for SHIRAHO for Publish
% xsize=240; ysize=490; % for SHIRAHO for Animation
xsize=270; ysize=629; % for SHIRAHO for Animation


output_folder = strcat('figs_png','_',num2str(id,'%0.4u'));
if (exist(strcat('output/', output_folder),'dir'))
    % error(strcat('Output directory /output/',output_folder,' already exists. Program terminated to prevent overwrite.'))
else
    mkdir(strcat('output/',output_folder)); 
end


close all

if 40 <= id && id <= 50
    imax = 1;
elseif id <1000
%time = ncread(his,'ocean_time',[i],[1]);
    time = ncread(his,'ocean_time');
    imax=length(time);
    time = time + (UTC_offset * 60 * 60);
else
    time = ncread(his,'time');
    imax=length(time);
    time = time + (UTC_offset * 60 * 60);
end

% coral masking
coral_mask = (p_coral_01==0).*0+(p_coral_01>0).*1;
coral_mask = coral_mask ./coral_mask;
coral2_mask = (p_coral_02==0).*0+(p_coral_02>0).*1;
coral2_mask = coral2_mask ./coral2_mask;

mask_rho = mask_rho ./mask_rho;


if 40 <= id && id <= 50
elseif id <1000
    date=starting_date+time(i+1)/24/60/60;
else
    date=starting_date+time(i+1);
end

% date_str=strcat(datestr(date,'yyyy-mm-dd HH:MM'),' ',LOCAL_TIME);
date_str='';

tmp = zeros(size(x_rho));
tmp_alpha = tmp;


if id == 1
    [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Temperature (^oC)',27,36,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 2
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Salinity (psu)', 33, 36.0, flipud(colmap7),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Salinity (psu)', 33, 36.0, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Salinity (psu)', 32, 36, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 3
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'DIC (\mumol kg^-^1)',1500,2200,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%     % [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'DIC (\mumol kg^-^1)',1600,1950,gray(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 4
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'TA (\mumol kg^-^1)',2050,2350,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 5
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'DO (\mumol L^-^1)',0,400,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 6
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'\delta^{13}C_{DIC} (permil)',-1,2.5,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 7
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Hs (m)',0,2.5,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 8 
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        'pH',"pH", ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 9
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'\Omega_{arg}', 2.5, 6, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 10
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'pCO_2 (\muatm)', 100, 700, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 11
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'SS \phi=5um (kg m^-^3)', 0, 0.15, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 12
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral Pg (nmol cm^-^2 s^-^1)',0, 0.6,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 13
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral Pn (nmol cm^-^2 s^-^1)', -0.4, 0.4,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 14
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral R (nmol cm^-^2 s^-^1)', 0, 0.35, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 15
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral G (nmol cm^-^2 s^-^1)', -0.04, 0.12, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 16
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral org-C (\mumol cm^-^2)', 0, 20, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 17
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral \delta^{13}C_{org-C} (permil)', -21, -15, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 18
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment thickness (m)', 0, 0.0025, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 19
%     str = "Coral1 zoox." + newline + "density (cell cm^-^2)";
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, mycmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 20
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Coral growth rate (s^-^1)', 0, 0.000000012, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 21
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Coral mortality (s^-^1)', 0, 0.00000002, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 22
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sea surface elevation (m)', -1.0, 1.0, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 23
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Phytoplankton1 (umolC L^-^1) ', 0, 4, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 24
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Phytoplankton2 (umolC L^-^1) ', 0, 3, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 25
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Phytoplankton (umolC L^-^1) ', 0, 5, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 26
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'NO3 (umolN L^-^1) ', 0, 1, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 27
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'NO2 (umolN L^-^1) ', 0, 0.1, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id   == 28
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'NH4 (umolN L^-^1) ', 0, 1, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 29
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'PO4 (umolP L^-^1) ', 0, 0.1, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 35
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'DOC (umol L^-^1) ', 65, 300, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 30
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'SS \phi=200um (kg m^-^3)', 0, 0.15, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 31
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Chl-a (ug L^-^1) ', 0, 1.5, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 32
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Chl-a (ug L^-^1) ', 0, 1, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 33
%     str = "Coral2 zoox." + newline + "density (cell cm^-^2)";
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, colmap5,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 34
%     str = "Coral zoox." + newline + "density (cell cm^-^2)";
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1.9e6, colmap5,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 2.5e6, flipud(colmap6),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 36
%     str = "Coral mortality rate (d^-^1)";
% %     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 5e-3, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 3e-3, colmap4, xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 40
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        "Submarine Groundwater"+newline+"Discharge Map","", ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 41
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        "Coral Coverage Map","", ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 42
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        "Seagrass Coverage Map","", ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 51
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment Temperature (^oC)',27,36,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 52
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment Salinity (psu)', 32, 36, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 53
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment TA (umol kg^-^1)',2050,2350,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 54
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DO (umol L^-^1)',0,350,colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 55
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DIC (umol L^-^1)', 1600, 2100, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 56
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment N2 (umol L^-^1)', 0, 10, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 57
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DOC Labile (umol L^-^1)', 0, 1, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 58
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DOC Refractory (umol L^-^1)', 0, 2100, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 59
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment POC Labile (nmol g^-^1)', 0, 100, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 60
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment POC Refractory (nmol g^-^1)', 0, 1000000, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 61
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment POC Non-degradable (nmol g^-^1)', 0, 1000000, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 62
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment NO3 (umol L^-^1)', 0, 10, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 63
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment NH4 (umol L^-^1)', 0, 100, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 64
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment PO4 (umol L^-^1)', 0, 100, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 65
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DON Labile (umol L^-^1)', 0, 1, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 66
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DON Refractory (umol L^-^1)', 0, 200, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 67
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment PON Labile (nmol g^-^1)', 0, 100, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 68
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment PON Refractory (nmol g^-^1)', 0, 100000, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 69
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment PON Non-degradable (nmol g^-^1)', 0, 1000000, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 70
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DOP Labile (umol L^-^1)', 0, 0.01, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 71
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DOP Refractory (umol L^-^1)', 0, 30, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 72
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment POP Labile (nmol g^-^1)', 0, 5, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 73
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment POP Refractory (nmol g^-^1)', 0, 10000, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 74
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment POP Non-degradable (nmol g^-^1)', 0, 10000, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 75
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment Mn2 (umol L^-^1) ', 0, 500, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 76
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment MnO2 (nmol g^-^1) ', 0, 20000, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 77
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment Fe2 (umol L^-^1) ', 0, 5, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 78
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment FeS (nmol g^-^1) ', 0, 1, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 79
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment FeS2 (nmol g^-^1) ', 7000, 10000, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 80
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment FeOOH (nmol g^-^1) ', 0, 200000, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 81
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment FeOOH_PO4 (nmol g^-^1) ', 0, 0.2, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 82
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment H2S (umol L^-^1) ', 0, 0.01, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 83
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment SO4 (umol L^-^1) ', 0, 30000, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 84
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment S0 (umol L^-^1) ', 0, 30, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 101
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'DOC (umol L^-^1) ', 0, 100, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 102
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'DON (umol L^-^1) ', 0, 100, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 103
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'DOP (umol L^-^1) ', 0, 100, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 104
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'POC (umol L^-^1) ', 0, 1, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 105
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'PON (umol L^-^1) ', 0, 1, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 106
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'POP (umol L^-^1) ', 0, 1, colmap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 201
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        "Seagrass Carbon-biomass",["umol" "m^2"], ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 202
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        'Seagrass Leaf Carbon-biomass',["umol" "m^2"], ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 203
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        'Seagrass Root Carbon-biomass',["umol" "m^2"], ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 204
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        'Seagrass Effective Leaf Area Projection',["m^2" "m^2"], ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 205
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        'Seagrass Carbon-biomass',["g" "m^2"], ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 206
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        'Seagrass Leaf Carbon-biomass',["g" "m^2"], ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 207
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        'Seagrass Root Carbon-biomass',["g" "m^2"], ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 208
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        'Seagrass Leaf Area',"m^2", ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 221
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        'Seagrass Photosynthesis',["umol" "m^2 s"], ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 222
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure6(x_rho,y_rho,tmp,tmp_alpha,h,date_str, ...
        "Seagrass Photosynthesis"+newline+"Limiting Factor", NaN, ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 223
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        'Seagrass Respiration',["umol" "m^2 s"], ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 224
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        "Seagrass Net Photosynthesis",["umol","m^{2} s"], ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 225
    [h_surf,h_contour,axes1,h_annot,h_annot2]=createfigure5(x_rho,y_rho,tmp,h,date_str, ...
        'Seagrass Dieoff',["umol" "m^2 s"], ...
        Cbounds(1),Cbounds(2),color,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 1001
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Air temperature (^oC)', 25, 33, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 1002
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Air pressure (hPa)', 950, 1020, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 1003
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Humidity (%)', 60, 100, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 1004
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Rain fall rate (kg m^-^2 s^-^1)', 0, 0.005, colmap6,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% elseif id == 1005
%     [h_surf,h_contour,axes1,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Cloud fraction', 0, 1, gray(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
end
drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]%[0 0 290 620]

pm = ncread(grd,'pm',[1 1],[Inf Inf]) ;
pn = ncread(grd,'pm',[1 1],[Inf Inf]) ;

% for i=1100:3:1100
% for i=imax:1:imax
% for i=1:1:1
% for i=1:1:imax   
for i=imax:1:imax
% for i=1:1:imax   

    if id == 1
        tmp = ncread(his,'temp',[1 1 Nz i],[Inf Inf 1 1]);  % Surface
        % tmp = ncread(his,'temp',[1 1 1 i],[Inf Inf 1 1]);  % bottom
    % elseif id == 2
    %     tmp =  ncread(his,'salt',[1 1 Nz i],[Inf Inf 1 1]);
    % elseif id == 3
    %     tmp = ncread(his,'TIC',[1 1 Nz i],[Inf Inf 1 1]);
    % elseif id == 4
    %     tmp = ncread(his,'alkalinity',[1 1 Nz i],[Inf Inf 1 1]) ;
    % elseif id == 5
    %     % tmp = ncread(his,'oxygen',[1 1 Nz i],[Inf Inf 1 1]);
    %     tmp = ncread(his,'oxygen',[1 1 1 i],[Inf Inf 1 1]);
    % elseif id == 6
    %     tmp = ncread(his,'d13C_DIC',[1 1 Nz i],[Inf Inf 1 1]);
    % elseif id == 7
    %     tmp = ncread(his,'Hwave',[1 1 i],[Inf Inf 1]);
    elseif id == 8 
        tmp = ncread(his,'pH',[1 1 i],[Inf Inf 1]);
%     elseif id == 9
%     %    tmp = ncread(his,'Warg',[i,0 0],[1,Jm,Im]);
%         tmp = ncread(his,'Omega_arg',[1 1 i],[Inf Inf 1]);
%     elseif id == 10
%         tmp = ncread(his,'pCO2',[1 1 i],[Inf Inf 1]);
%     elseif id == 11
%         tmp = ncread(his,'mud_01',[1 1 Nz i],[Inf Inf 1 1]);
%     elseif id == 12
%         tmp =  ncread(his,'coral1_Pg',[1 1 i],[Inf Inf 1]) .*coral_mask;
%     elseif id == 13
%         tmp = ncread(his,'coral1_Pn',[1 1 i],[Inf Inf 1]) .*coral_mask;
%     elseif id == 14
%         tmp = ncread(his,'coral1_R',[1 1 i],[Inf Inf 1]) .*coral_mask;
%     elseif id == 15
%         tmp = ncread(his,'coral1_G',[1 1 i],[Inf Inf 1]) .*coral_mask;
%     elseif id == 16
%         tmp = ncread(his,'coral1_orgC',[1 1 i],[Inf Inf 1]) .*coral_mask;
%     elseif id == 17
%         tmp = ncread(his,'coral1_d13Ctissue',[1 1 i],[Inf Inf 1]) .*coral_mask;
%     elseif id == 18
%         tmp = ncread(his,'bed_thickness',[1 1 1 i],[Inf Inf 1 1]);
%     elseif id == 19
%         tmp = ncread(his,'coral1_densZoox',[1 1 i],[Inf Inf 1]) .*coral_mask;
%     elseif id == 20
%         tmp = ncread(his,'coral_growth',[1 1 i],[Inf Inf 1]) .*coral_mask;
%     elseif id == 21
%         tmp = ncread(his,'coral_mort',[1 1 i],[Inf Inf 1]) .*coral_mask;
%     elseif id == 22
%         tmp = ncread(his,'zeta',[1 1 i],[Inf Inf 1]).*mask_rho;
%     elseif id == 23
%         tmp = ncread(his,'phytoplankton1',[1 1 Nz i],[Inf Inf 1 1]) ;
%     elseif id == 24
%         tmp = ncread(his,'phytoplankton2',[1 1 Nz i],[Inf Inf 1 1]) ;
%     elseif id == 25
%         tmp = ncread(his,'phytoplankton1',[1 1 Nz i],[Inf Inf 1 1]) ;
%         tmp = tmp+ncread(his,'phytoplankton2',[1 1 Nz i],[Inf Inf 1 1]) ;
%     elseif id == 26
%         tmp = ncread(his,'NO3',[1 1 Nz i],[Inf Inf 1 1]) ;
%     elseif id == 27
%         tmp = ncread(his,'NO2',[1 1 Nz i],[Inf Inf 1 1]) ;
%     elseif id == 28
%         tmp = ncread(his,'NH4',[1 1 Nz i],[Inf Inf 1 1]) ;
%     elseif id == 29
%         tmp = ncread(his,'PO4',[1 1 Nz i],[Inf Inf 1 1]) ;
%     elseif id == 35
%         tmp = ncread(his,'DOC',[1 1 Nz i],[Inf Inf 1 1]) ;
%     elseif id == 30
%         tmp = ncread(his,'mud_02',[1 1 Nz i],[Inf Inf 1 1]);
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
% 
    elseif id == 40
        tmp = ncread(his,'sgd_src',[1 1],[Inf Inf]);
    elseif id == 41
        tmp = ncread(his,'p_coral_01',[1 1],[Inf Inf]) + ncread(his,'p_coral_02',[1 1],[Inf Inf]);
    elseif id == 42
        tmp = ncread(his,'p_sgrass_01',[1 1],[Inf Inf]);
%     elseif id == 51
%         tmp =  ncread(his,'sediment_Tmp',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 52
%         tmp =  ncread(his,'sediment_Sal',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 53
%         tmp =  ncread(his,'sediment_TA',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 54
%         tmp =  ncread(his,'sediment_O2',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 55
%         tmp =  ncread(his,'sediment_CO2',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 56
%         tmp =  ncread(his,'sediment_N2',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 57
%         tmp =  ncread(his,'sediment_DOCf',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 58
%         tmp =  ncread(his,'sediment_DOCs',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 59
%         tmp =  ncread(his,'sediment_POCf',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 60
%         tmp =  ncread(his,'sediment_POCs',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 61
%         tmp =  ncread(his,'sediment_POCn',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 62
%         tmp =  ncread(his,'sediment_NO3',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 63
%         tmp =  ncread(his,'sediment_NH4',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 64
%         tmp =  ncread(his,'sediment_PO4',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 65
%         tmp =  ncread(his,'sediment_DONf',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 66
%         tmp =  ncread(his,'sediment_DONs',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 67
%         tmp =  ncread(his,'sediment_PONf',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 68
%         tmp =  ncread(his,'sediment_PONs',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 69
%         tmp =  ncread(his,'sediment_PONn',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 70
%         tmp =  ncread(his,'sediment_DOPf',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 71
%         tmp =  ncread(his,'sediment_DOPs',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 72
%         tmp =  ncread(his,'sediment_POPf',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 73
%         tmp =  ncread(his,'sediment_POPs',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 74
%         tmp =  ncread(his,'sediment_POPn',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 75
%         tmp =  ncread(his,'sediment_Mn2',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 76
%         tmp =  ncread(his,'sediment_MnO2',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 77
%         tmp =  ncread(his,'sediment_Fe2',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 78
%         tmp =  ncread(his,'sediment_FeS',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 79
%         tmp =  ncread(his,'sediment_FeS2',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 80
%         tmp =  ncread(his,'sediment_FeOOH',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 81
%         tmp =  ncread(his,'sediment_FeOOH_PO4',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 82
%         tmp =  ncread(his,'sediment_H2S',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 83
%         tmp =  ncread(his,'sediment_SO4',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 84
%         tmp =  ncread(his,'sediment_S0',[1 1 SedLayer i],[Inf Inf 1 1]);
%     elseif id == 101
%         tmp = ncread(his,'DOC_01',[1 1 1 i],[Inf Inf 1 1])+ncread(his,'DOC_02',[1 1 1 i],[Inf Inf 1 1]) ; % bottom layer
%     elseif id == 102
%         tmp = ncread(his,'DON_01',[1 1 1 i],[Inf Inf 1 1])+ncread(his,'DON_02',[1 1 1 i],[Inf Inf 1 1]) ; % bottom layer
%     elseif id == 103
%         tmp = ncread(his,'DOP_01',[1 1 1 i],[Inf Inf 1 1])+ncread(his,'DOP_02',[1 1 1 i],[Inf Inf 1 1]) ; % bottom layer
%     elseif id == 104
%         tmp = ncread(his,'POC_01',[1 1 1 i],[Inf Inf 1 1])+ncread(his,'POC_02',[1 1 1 i],[Inf Inf 1 1]) ; % bottom layer
%     elseif id == 105
%         tmp = ncread(his,'PON_01',[1 1 1 i],[Inf Inf 1 1])+ncread(his,'PON_02',[1 1 1 i],[Inf Inf 1 1]) ; % bottom layer
%     elseif id == 106
%         tmp = ncread(his,'POP_01',[1 1 1 i],[Inf Inf 1 1])+ncread(his,'POP_02',[1 1 1 i],[Inf Inf 1 1]) ; % bottom layer
    elseif id == 201
        tmp = ncread(his,'seagrass_SgCBm_01',[1 1 i],[Inf Inf 1]) ; 
    elseif id == 202
        tmp = ncread(his,'seagrass_LfCBm_01',[1 1 i],[Inf Inf 1]) ; 
    elseif id == 203
        tmp = ncread(his,'seagrass_RtCBm_01',[1 1 i],[Inf Inf 1]) ; 
    elseif id == 204
        tmp = ncread(his,'seagrass_ELAP_01',[1 1 i],[Inf Inf 1]) ; 
    elseif id == 205
        tmp = ncread(his,'seagrass_TotSgCBm01',[1 1 i],[Inf Inf 1]) ; 
        tons_C = sum(tmp,'all','omitnan')*12.011/1000000; % mol.C * 12.011 g/mol * ton/1000000g
        set(h_annot2,'String',strcat("Total carbon: ",num2str(tons_C,'%0.2f'),' tons'))
        tmp = tmp .* 12.011 .*pm.*pn; % convert to g C per m2
    elseif id == 206
        tmp = ncread(his,'seagrass_TotLfCBm_01',[1 1 i],[Inf Inf 1]) ; 
                tons_C = sum(tmp,'all','omitnan')*12.011/1000000; % mol.C * 12.011 g/mol * ton/1000000g
        set(h_annot2,'String',strcat("Total leaf carbon: ",num2str(tons_C,'%0.2f'),' tons'))
        tmp = tmp .* 12.011 .*pm.*pn; % convert to g C per m2
    elseif id == 207
        tmp = ncread(his,'seagrass_TotRtCBm_01',[1 1 i],[Inf Inf 1]) ; 
                tons_C = sum(tmp,'all','omitnan')*12.011/1000000; % mol.C * 12.011 g/mol * ton/1000000g
        set(h_annot2,'String',strcat("Total root carbon: ",num2str(tons_C,'%0.2f'),' tons'))
        tmp = tmp .* 12.011 .*pm.*pn; % convert to g C per m2
    elseif id == 208
        tmp = ncread(his,'seagrass_LA_01',[1 1 i],[Inf Inf 1]) ; 
    elseif id == 221
        tmp = ncread(his,'seagrass_Phot_01',[1 1 i],[Inf Inf 1]) ; 
    elseif id == 222
        tmp1 = ncread(his,'seagrass_Phot_Limiting01',[1 1 i],[Inf Inf 1]) ; 
        tmp2 = ncread(his,'seagrass_Grow_Limiting01',[1 1 i],[Inf Inf 1]) ;
        % tmp = tmp2 .* (tmp2 > 1) + (tmp2 > 1) + tmp1 .* (tmp2 <= 1);
        tmp = tmp1 .* (tmp1 == 1) + tmp2 .* (tmp1 == 2) + (tmp1 == 2);
        tmp_alpha = ncread(his,'seagrass_TotSgCBm01',[1 1 i],[Inf Inf 1]) ; 
        tmp_alpha = tmp_alpha ./ (alphaMax./ 12.011 ./pm./pn);
    elseif id == 223
        tmp = ncread(his,'seagrass_Resp_01',[1 1 i],[Inf Inf 1]) ; 
    elseif id == 224
        tmp = ncread(his,'seagrass_Net_Phot01',[1 1 i],[Inf Inf 1]) ; 
    elseif id == 225
        tmp = ncread(his,'seagrass_Dieoff_01',[1 1 i],[Inf Inf 1]) ; 
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

    if fix_bottom
        tmp(:, 1) = tmp(:, 2); % fix bottom
    end

    if wet_dry == 1
        wetdry_mask_rho = ncread(his,'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
        wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
        tmp = tmp .* wetdry_mask_rho;
    end

    %depth =squeeze(zeta(i,:,:))+h;
    %depth =zeta+h;
    %date=datenum(2009,8,25,0,0,0)+time/24/60/60;
    if 40 <= id && id <= 50
        date_str=""
    elseif id <1000
        date=starting_date+time(i)/24/60/60;
        date_str=strcat(datestr(date,'yyyy-mm-dd HH:MM'),' ',LOCAL_TIME);
    else
        date=starting_date+time(i);
        date_str=strcat(datestr(date,'yyyy-mm-dd HH:MM'),' ',LOCAL_TIME);
    end

    set(h_surf,'CData',tmp)

    if id == 222
        set(h_surf,'alphadata',tmp_alpha)
    end

    % if time_annot
    if time_annot
        set(h_annot,'String',date_str)
    end

    set(axes1 ,'Layer', 'Top')

    drawnow

    date_str2 = erase(date_str, ["-", " ", ":"]);
    
    hgexport(figure(1), strcat('output/',output_folder,'/t01_',date_str2,'.png'),hgexport('factorystyle'),'Format','png');

end



