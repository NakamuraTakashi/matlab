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
his='D:\ROMS\output\Shiraho_reef\OAv12_ctrl\ocean_his_10.nc';

% starting_date=datenum(2009,8,25,0,0,0); % for Shiraho
starting_date=datenum(2010,8,20,0,0,0); % for Shiraho
%starting_date=datenum(2013,6,1,0,0,0);
% starting_date=datenum(2000,1,1,0,0,0);

Nz=8; % for Shiraho
% Nz=15; %30-1
% Nz=30; %30-1

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

% id = 32;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
id = 3;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all

if id <100
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

if id <100
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
elseif id == 101
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Air temperature (^oC)', 25, 33, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 102
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Air pressure (hPa)', 950, 1020, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 103
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Humidity (%)', 60, 100, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 104
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Rain fall rate (kg m^-^2 s^-^1)', 0, 0.005, jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 105
    [h_surf,h_contour,h_annot]=createfigure5(x_rho,y_rho,tmp,h,date_str,'Cloud fraction', 0, 1, gray(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
end
drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]%[0 0 290 620]

for i=1100:3:1100
% for i=imax:1:imax
% for i=1:3:imax   

    if id == 1
%         tmp = ncread(his,'temp',[1 1 Nz i],[Inf Inf 1 1]);  % Surface
        tmp = ncread(his,'temp',[1 1 1 i],[Inf Inf 1 1]);  % bottom
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

    elseif id == 101
        tmp = ncread(his,'Tair',[1 1 i],[Inf Inf 1]);
    elseif id == 102
        tmp = ncread(his,'Pair',[1 1 i],[Inf Inf 1]);
    elseif id == 103
        tmp = ncread(his,'Qair',[1 1 i],[Inf Inf 1]);
    elseif id == 104
        tmp = ncread(his,'rain',[1 1 i],[Inf Inf 1]);
    elseif id == 105
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
    if id <100
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



