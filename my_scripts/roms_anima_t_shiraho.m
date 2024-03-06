%
% === ver 2016/03/10   Copyright (c) 2014-2016 Takashi NAKAMURA  =====
%                for MATLAB R2015a,b  

grd='../Data/Shiraho_reef/shiraho_reef_grid16.3.nc'; 
% his='D:\ROMS\output\Shiraho_reef\OAv12_ctrl\ocean_his_10.nc';
% his='K:\ROMS\output\Shiraho_reef\bleaching01\ocean_his_10.nc';
% his='K:\ROMS\output\Shiraho_reef\doc01\ocean_his_10.nc';

% -------------- Bleaching simulation ------------------------------
% his='K:\ROMS\output\Shiraho_reef\bleaching02\ocean_his_10_27.nc';
% his='K:\ROMS\output\Shiraho_reef\bleaching02\ocean_his_10_29.nc';
% his='K:\ROMS\output\Shiraho_reef\bleaching02\ocean_his_10_29.5.nc';
% his='K:\ROMS\output\Shiraho_reef\bleaching02\ocean_his_10_30.nc';
% his='K:\ROMS\output\Shiraho_reef\bleaching02\ocean_his_10_31.nc';
his='../Projects/Shiraho_reef/ocean_his_10_5.nc';


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

unit = 'km'; % 'm', 'latlon'
LevelList = [0 0.2 0.5 3];

h          = ncread(grd,'h');
p_coral    = ncread(grd,'p_coral');
p_coral2    = ncread(grd,'p_coral2');
%p_seagrass = ncread(grd,'p_seagrass');
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
xsize=240; ysize=490; % for SHIRAHO for Animation

% id = 1; % Temperature
% id = 2; % Salinity
% id = 3; % DIC
% id = 4; % TA
% id = 5; % DO
% id = 6; % delta^{13}C_{DIC}
% id = 7; % Hs
% id = 8; % pH
% id = 9; % \Omega_{arg}
% id = 10; % pCO_2
% id = 11; % SS \phi=5um
% id = 12; % Coral Pg
% id = 13; % Coral Pn
% id = 14; % Coral R
% id = 15; % Coral G
% id = 16; % Coral org-C
% id = 17; % Coral \delta^{13}C_{org-C}
% id = 18; % Sediment thickness (m)
% id = 19; % Coral1 zoox. density 
% id = 20; % Coral growth rate
% id = 21; % Coral mortality
% id = 22; % Sea surface elevation
% id = 23; % Phytoplankton1
% id = 24; % Phytoplankton2
% id = 25; % Phytoplankton
% id = 26; % NO3
% id = 27; % NO2
% id = 28; % NH4
% id = 29; % PO4
% id = 35; % DOC
% id = 30; % SS \phi=200um
% id = 31; % Chl-a
% id = 32; % Chl-a
% id = 33; % Coral2 zoox. density
% id = 34; % Coral2 zoox. density
% id = 36; % Coral mortality rate
% id = 51; % Sediment Temperature
% id = 52; % Sediment Salinity
% id = 53; % Sediment TA
id = 54; % Sediment DO
% id = 55; % Sediment DIC
% id = 56; % Sediment N2
% id = 57; % Sediment DOC Labile
% id = 58; % Sediment DOC Refractory
% id = 59; % Sediment POC Labile
% id = 60; % Sediment POC Refractory
% id = 61; % Sediment POC Non-degradable
% id = 62; % Sediment NO3
% id = 63; % Sediment NH4
% id = 64; % Sediment PO4
% id = 65; % Sediment DON Labile
% id = 66; % Sediment DON Refractory
% id = 67; % Sediment PON Labile
% id = 68; % Sediment PON Refractory
% id = 69; % Sediment PON Non-degradable
% id = 70; % Sediment DOP Labile
% id = 71; % Sediment DOP Refractory
% id = 72; % Sediment POP Labile
% id = 73; % Sediment POP Refractory
% id = 74; % Sediment POP Non-degradable
% id = 75; % Sediment Mn2
% id = 76; % Sediment MnO2
% id = 77; % Sediment Fe2
% id = 78; % Sediment FeS
% id = 79; % Sediment FeS2
% id = 80; % Sediment FeOOH
% id = 81; % Sediment FeOOH_PO4
% id = 82; % Sediment H2S
% id = 83; % Sediment SO4
% id = 84; % Sediment S0
% id = 1001; % Air temperature
% id = 1002; % Air pressure
% id = 1003; % Humidity
% id = 1004; % Rain fall rate
% id = 1005; % Cloud fraction


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


% My color map
load('MyColormaps')

if id <1000
    date=starting_date+time(i+1)/24/60/60;
else
    date=starting_date+time(i+1);
end

date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

tmp = zeros(size(x_rho));


if id == 1
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Temperature (^oC)',27,36,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 2
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Salinity (psu)', 33, 36.0, flipud(colmap1),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Salinity (psu)', 33, 36.0, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Salinity (psu)', 32, 36, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 3
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'DIC (\mumol kg^-^1)',1600,2100,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'DIC (\mumol kg^-^1)',1600,1950,gray(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 4
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'TA (\mumol kg^-^1)',2050,2350,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 5
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'DO (\mumol L^-^1)',100,350,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 6
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'\delta^{13}C_{DIC} (permil)',-1,2.5,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 7
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Hs (m)',0,2.5,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 8 
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'pH (total scale)', 7.8, 8.5 ,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 9
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'\Omega_{arg}', 2.5, 6, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 10
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'pCO_2 (\muatm)', 100, 700, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 11
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'SS \phi=5um (kg m^-^3)', 0, 0.15, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 12
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral Pg (nmol cm^-^2 s^-^1)',0, 0.6,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 13
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral Pn (nmol cm^-^2 s^-^1)', -0.4, 0.4,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 14
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral R (nmol cm^-^2 s^-^1)', 0, 0.35, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 15
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral G (nmol cm^-^2 s^-^1)', -0.04, 0.12, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 16
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral org-C (\mumol cm^-^2)', 0, 20, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 17
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'    Coral \delta^{13}C_{org-C} (permil)', -21, -15, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 18
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment thickness (m)', 0, 0.0025, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 19
    str = "Coral1 zoox." + newline + "density (cell cm^-^2)";
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, mycmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 20
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Coral growth rate (s^-^1)', 0, 0.000000012, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 21
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Coral mortality (s^-^1)', 0, 0.00000002, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 22
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sea surface elevation (m)', -1.0, 1.0, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 23
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Phytoplankton1 (umolC L^-^1) ', 0, 4, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 24
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Phytoplankton2 (umolC L^-^1) ', 0, 3, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 25
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Phytoplankton (umolC L^-^1) ', 0, 5, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 26
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'NO3 (umolN L^-^1) ', 0, 1, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 27
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'NO2 (umolN L^-^1) ', 0, 0.1, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 28
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'NH4 (umolN L^-^1) ', 0, 1, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 29
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'PO4 (umolP L^-^1) ', 0, 0.1, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 35
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'DOC (umol L^-^1) ', 65, 300, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 30
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'SS \phi=200um (kg m^-^3)', 0, 0.15, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 31
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Chl-a (ug L^-^1) ', 0, 1.5, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 32
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Chl-a (ug L^-^1) ', 0, 1, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 33
    str = "Coral2 zoox." + newline + "density (cell cm^-^2)";
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, colmap5,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 34
    str = "Coral zoox." + newline + "density (cell cm^-^2)";
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1000000, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 1.9e6, colmap5,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 2.5e6, flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 36
    str = "Coral mortality rate (d^-^1)";
%     [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 5e-3, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,str, 0, 3e-3, colmap4, xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 51
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment Temperature (^oC)',27,36,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 52
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment Salinity (psu)', 32, 36, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 53
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment TA (umol kg^-^1)',2050,2350,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 54
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DO (umol L^-^1)',0,350,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 55
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DIC (umol L^-^1)', 1600, 2100, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 56
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment N2 (umol L^-^1)', 0, 10, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 57
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DOC Labile (umol L^-^1)', 0, 1, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 58
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DOC Refractory (umol L^-^1)', 0, 2100, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 59
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment POC Labile (nmol g^-^1)', 0, 100, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 60
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment POC Refractory (nmol g^-^1)', 0, 1000000, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 61
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment POC Non-degradable (nmol g^-^1)', 0, 1000000, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 62
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment NO3 (umol L^-^1)', 0, 10, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 63
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment NH4 (umol L^-^1)', 0, 100, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 64
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment PO4 (umol L^-^1)', 0, 100, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 65
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DON Labile (umol L^-^1)', 0, 1, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 66
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DON Refractory (umol L^-^1)', 0, 200, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 67
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment PON Labile (nmol g^-^1)', 0, 100, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 68
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment PON Refractory (nmol g^-^1)', 0, 100000, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 69
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment PON Non-degradable (nmol g^-^1)', 0, 1000000, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 70
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DOP Labile (umol L^-^1)', 0, 0.01, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 71
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment DOP Refractory (umol L^-^1)', 0, 30, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 72
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment POP Labile (nmol g^-^1)', 0, 5, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 73
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment POP Refractory (nmol g^-^1)', 0, 10000, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 74
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment POP Non-degradable (nmol g^-^1)', 0, 10000, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 75
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment Mn2 (umol L^-^1) ', 0, 500, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 76
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment MnO2 (nmol g^-^1) ', 0, 20000, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 77
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment Fe2 (umol L^-^1) ', 0, 5, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 78
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment FeS (nmol g^-^1) ', 0, 1, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 79
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment FeS2 (nmol g^-^1) ', 7000, 10000, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 80
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment FeOOH (nmol g^-^1) ', 0, 200000, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 81
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment FeOOH_PO4 (nmol g^-^1) ', 0, 0.2, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 82
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment H2S (umol L^-^1) ', 0, 0.01, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 83
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment SO4 (umol L^-^1) ', 0, 30000, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 84
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Sediment S0 (umol L^-^1) ', 0, 30, colmap1,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 1001
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Air temperature (^oC)', 25, 33, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 1002
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Air pressure (hPa)', 950, 1020, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 1003
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Humidity (%)', 60, 100, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 1004
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Rain fall rate (kg m^-^2 s^-^1)', 0, 0.005, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 1005
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Cloud fraction', 0, 1, gray(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
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
    elseif id == 2
        tmp =  ncread(his,'salt',[1 1 Nz i],[Inf Inf 1 1]);
    elseif id == 3
        tmp = ncread(his,'TIC',[1 1 Nz i],[Inf Inf 1 1]);
    elseif id == 4
        tmp = ncread(his,'alkalinity',[1 1 Nz i],[Inf Inf 1 1]) ;
    elseif id == 5
        tmp = ncread(his,'oxygen',[1 1 Nz i],[Inf Inf 1 1]);
    elseif id == 6
        tmp = ncread(his,'d13C_DIC',[1 1 Nz i],[Inf Inf 1 1]);
    elseif id == 7
        tmp = ncread(his,'Hwave',[1 1 i],[Inf Inf 1]);
    elseif id == 8 
        tmp = ncread(his,'pH',[1 1 i],[Inf Inf 1]);
    elseif id == 9
    %    tmp = ncread(his,'Warg',[i,0 0],[1,Jm,Im]);
        tmp = ncread(his,'Omega_arg',[1 1 i],[Inf Inf 1]);
    elseif id == 10
        tmp = ncread(his,'pCO2',[1 1 i],[Inf Inf 1]);
    elseif id == 11
        tmp = ncread(his,'mud_01',[1 1 Nz i],[Inf Inf 1 1]);
    elseif id == 12
        tmp =  ncread(his,'coral1_Pg',[1 1 i],[Inf Inf 1]) .*coral_mask;
    elseif id == 13
        tmp = ncread(his,'coral1_Pn',[1 1 i],[Inf Inf 1]) .*coral_mask;
    elseif id == 14
        tmp = ncread(his,'coral1_R',[1 1 i],[Inf Inf 1]) .*coral_mask;
    elseif id == 15
        tmp = ncread(his,'coral1_G',[1 1 i],[Inf Inf 1]) .*coral_mask;
    elseif id == 16
        tmp = ncread(his,'coral1_orgC',[1 1 i],[Inf Inf 1]) .*coral_mask;
    elseif id == 17
        tmp = ncread(his,'coral1_d13Ctissue',[1 1 i],[Inf Inf 1]) .*coral_mask;
    elseif id == 18
        tmp = ncread(his,'bed_thickness',[1 1 1 i],[Inf Inf 1 1]);
    elseif id == 19
        tmp = ncread(his,'coral1_densZoox',[1 1 i],[Inf Inf 1]) .*coral_mask;
    elseif id == 20
        tmp = ncread(his,'coral_growth',[1 1 i],[Inf Inf 1]) .*coral_mask;
    elseif id == 21
        tmp = ncread(his,'coral_mort',[1 1 i],[Inf Inf 1]) .*coral_mask;
    elseif id == 22
        tmp = ncread(his,'zeta',[1 1 i],[Inf Inf 1]).*mask_rho;
    elseif id == 23
        tmp = ncread(his,'phytoplankton1',[1 1 Nz i],[Inf Inf 1 1]) ;
    elseif id == 24
        tmp = ncread(his,'phytoplankton2',[1 1 Nz i],[Inf Inf 1 1]) ;
    elseif id == 25
        tmp = ncread(his,'phytoplankton1',[1 1 Nz i],[Inf Inf 1 1]) ;
        tmp = tmp+ncread(his,'phytoplankton2',[1 1 Nz i],[Inf Inf 1 1]) ;
    elseif id == 26
        tmp = ncread(his,'NO3',[1 1 Nz i],[Inf Inf 1 1]) ;
    elseif id == 27
        tmp = ncread(his,'NO2',[1 1 Nz i],[Inf Inf 1 1]) ;
    elseif id == 28
        tmp = ncread(his,'NH4',[1 1 Nz i],[Inf Inf 1 1]) ;
    elseif id == 29
        tmp = ncread(his,'PO4',[1 1 Nz i],[Inf Inf 1 1]) ;
    elseif id == 35
        tmp = ncread(his,'DOC',[1 1 Nz i],[Inf Inf 1 1]) ;
    elseif id == 30
        tmp = ncread(his,'mud_02',[1 1 Nz i],[Inf Inf 1 1]);
    elseif id == 31
        tmp = ncread(his,'phytoplankton1',[1 1 Nz i],[Inf Inf 1 1]) ;
        tmp = tmp + ncread(his,'phytoplankton2',[1 1 Nz i],[Inf Inf 1 1]) ;
        tmp = tmp * 0.24;
    elseif id == 32
        tmp = ncread(his,'phytoplankton2',[1 1 Nz i],[Inf Inf 1 1]) ;
        tmp = tmp * 0.24;
    elseif id == 33
        tmp = ncread(his,'coral2_densZoox',[1 1 i],[Inf Inf 1]) .*coral2_mask;
    elseif id == 34
        mask1 = coral_mask;
        mask1(isnan(mask1))=0;
        mask2 = coral2_mask;
        mask2(isnan(mask2))=0;
        tmp = ncread(his,'coral1_densZoox',[1 1 i],[Inf Inf 1]) .*mask1;
        tmp = tmp + ncread(his,'coral2_densZoox',[1 1 i],[Inf Inf 1]) .*mask2;
        mask1=mask1+mask2;
        mask1=mask1./mask1;
        if i==1
            tmp=1.82e6;
        end
        tmp = tmp.*mask1;
    elseif id == 36
        mask1 = coral_mask;
        mask1(isnan(mask1))=0;
        mask2 = coral2_mask;
        mask2(isnan(mask2))=0;
        tmp = ncread(his,'coral1_mort',[1 1 i],[Inf Inf 1]) .*mask1;
        tmp = tmp + ncread(his,'coral2_mort',[1 1 i],[Inf Inf 1]) .*mask2;
        mask1=mask1+mask2;
        mask1=mask1./mask1;
%         if i==1
%             tmp=0;
%         end
        tmp = tmp*24*60*60.*mask1;

    elseif id == 51
        tmp =  ncread(his,'sediment_Tmp',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 52
        tmp =  ncread(his,'sediment_Sal',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 53
        tmp =  ncread(his,'sediment_TA',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 54
        tmp =  ncread(his,'sediment_O2',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 55
        tmp =  ncread(his,'sediment_CO2',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 56
        tmp =  ncread(his,'sediment_N2',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 57
        tmp =  ncread(his,'sediment_DOCf',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 58
        tmp =  ncread(his,'sediment_DOCs',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 59
        tmp =  ncread(his,'sediment_POCf',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 60
        tmp =  ncread(his,'sediment_POCs',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 61
        tmp =  ncread(his,'sediment_POCn',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 62
        tmp =  ncread(his,'sediment_NO3',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 63
        tmp =  ncread(his,'sediment_NH4',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 64
        tmp =  ncread(his,'sediment_PO4',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 65
        tmp =  ncread(his,'sediment_DONf',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 66
        tmp =  ncread(his,'sediment_DONs',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 67
        tmp =  ncread(his,'sediment_PONf',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 68
        tmp =  ncread(his,'sediment_PONs',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 69
        tmp =  ncread(his,'sediment_PONn',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 70
        tmp =  ncread(his,'sediment_DOPf',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 71
        tmp =  ncread(his,'sediment_DOPs',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 72
        tmp =  ncread(his,'sediment_POPf',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 73
        tmp =  ncread(his,'sediment_POPs',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 74
        tmp =  ncread(his,'sediment_POPn',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 75
        tmp =  ncread(his,'sediment_Mn2',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 76
        tmp =  ncread(his,'sediment_MnO2',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 77
        tmp =  ncread(his,'sediment_Fe2',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 78
        tmp =  ncread(his,'sediment_FeS',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 79
        tmp =  ncread(his,'sediment_FeS2',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 80
        tmp =  ncread(his,'sediment_FeOOH',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 81
        tmp =  ncread(his,'sediment_FeOOH_PO4',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 82
        tmp =  ncread(his,'sediment_H2S',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 83
        tmp =  ncread(his,'sediment_SO4',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 84
        tmp =  ncread(his,'sediment_S0',[1 1 SedLayer i],[Inf Inf 1 1]);
    elseif id == 1001
        tmp = ncread(his,'Tair',[1 1 i],[Inf Inf 1]);
    elseif id == 1002
        tmp = ncread(his,'Pair',[1 1 i],[Inf Inf 1]);
    elseif id == 1003
        tmp = ncread(his,'Qair',[1 1 i],[Inf Inf 1]);
    elseif id == 1004
        tmp = ncread(his,'rain',[1 1 i],[Inf Inf 1]);
    elseif id == 1005
        tmp = ncread(his,'cloud',[1 1 i],[Inf Inf 1]);
    end

    if wet_dry == 1
        wetdry_mask_rho = ncread(his,'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
        wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
        tmp = tmp .* wetdry_mask_rho;
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
    set(h_annot,'String',date_str)
    drawnow
    
%     hgexport(figure(1), strcat('output/figs_png\t01_',num2str(i,'%0.4u'),'.png'),hgexport('factorystyle'),'Format','png');
%     hgexport(figure(1), strcat('output/figs_eps\t01_',num2str(i,'%0.4u'),'.eps'),hgexport('factorystyle'),'Format','eps');

end



