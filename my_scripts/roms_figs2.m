%
% === ver 2015/04/02   Copyright (c) 2014-2015 Takashi NAKAMURA  =====
%                for MATLAB R2015a  

%grd='C:\cygwin64\home\Takashi\ROMS\Projects\Shiraho_reef_offline\Data\shiraho_reef_grid11.nc'; his='C:\cygwin64\home\Takashi\ROMS\Projects\Shiraho_reef_offline\ocean_his.nc';
grd='D:\ROMS\Shiraho_reef\OA5_Ctrl\Data\shiraho_reef_grid11.nc'; his='D:\ROMS\Shiraho_reef\OA5_Ctrl\ocean_his.nc';

i=100;
id = 1;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

starting_date=datenum(2009,8,25,0,0,0); % for Shiraho
%starting_date=datenum(2014,4,1,0,0,0);

Nz=8; % for Shiraho
%Nz=15; %30-1
%Nz=30; %30-1

%LOCAL_TIME='(UTC)';
%LOCAL_TIME='(JST)';
%LOCAL_TIME='(UTC+9)';
LOCAL_TIME='';

wet_dry = 1;  % Dry mask OFF: 0, ON: 1


h          = ncread(grd,'h');
p_coral    = ncread(grd,'p_coral');
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

xmin=0;   xmax=max(max(x_rho));  ymin=0;   ymax=max(max(y_rho));

%xsize=Im*2+100; ysize=Jm*2+100;  % for YAEYAM1
xsize=290; ysize=680; % for SHIRAHO
%xsize=500; ysize=650; % for SHIRAHO zoom


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

mask_rho = mask_rho ./mask_rho;


if id == 1
    tmp = ncread(his,'temp',[1 1 Nz i],[Inf Inf 1 1]);
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
    tmp = ncread(his,'mud_01',[1 1 1 i],[Inf Inf 1 1]);  % ��ʂ�mud
elseif id == 12
    tmp =  ncread(his,'coral_Pg',[1 1 i],[Inf Inf 1]) .*coral_mask;
elseif id == 13
    tmp = ncread(his,'coral_Pn',[1 1 i],[Inf Inf 1]) .*coral_mask;
elseif id == 14
    tmp = ncread(his,'coral_R',[1 1 i],[Inf Inf 1]) .*coral_mask;
elseif id == 15
    tmp = ncread(his,'coral_G',[1 1 i],[Inf Inf 1]) .*coral_mask;
elseif id == 16
    tmp = ncread(his,'coral_orgC',[1 1 i],[Inf Inf 1]) .*coral_mask;
elseif id == 17
    tmp = ncread(his,'coral_d13Ctissue',[1 1 i],[Inf Inf 1]) .*coral_mask;
elseif id == 18
    tmp = ncread(his,'bed_thickness',[1 1 1 i],[Inf Inf 1 1]);
elseif id == 19
    tmp = ncread(his,'coral_densZoox',[1 1 i],[Inf Inf 1]) .*coral_mask;
elseif id == 20
    tmp = ncread(his,'coral_growth',[1 1 i],[Inf Inf 1]) .*coral_mask;
elseif id == 21
    tmp = ncread(his,'coral_mort',[1 1 i],[Inf Inf 1]) .*coral_mask;
elseif id == 22
    tmp = ncread(his,'zeta',[1 1 i],[Inf Inf 1]).*mask_rho;
      
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
%    tmp = ncread(his,'zeta',[i,0 0],[1,Jm,Im]);
%    tmp = ncread(his,'Dwave',[i,0 0],[1,Jm,Im]); 
%    tmp = ncread(his,'TI13C',[i,7,0 0],[1,1,Jm,Im]);

%depth =squeeze(zeta(i,:,:))+h;
%depth =zeta+h;
%date=datenum(2009,8,25,0,0,0)+time/24/60/60;
if wet_dry == 1
    wetdry_mask_rho = ncread(his,'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
    wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
    tmp = tmp .* wetdry_mask_rho;
end

% My color map
load('MyColormaps')

if id <100
    date=starting_date+time(i+1)/24/60/60;
else
    date=starting_date+time(i+1);
end

date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

if id == 1
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Temperature (^oC)',28,34,jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 2
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Salinity (psu)', 30, 34.7, flipud(colmap1),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 3
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'DIC (umol kg^-^1)',1600,2050,jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 4
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'TA (umol kg^-^1)',2050,2280,jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 5
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'DO (umol L^-^1)',100,300,jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 6
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'d^1^3C_D_I_C (permil VPDB)',-1,2.5,jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 7
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Hs (m)',0,2.5,jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 8 
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'pH (total scale)', 7.8, 8.2 ,jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 9
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Aragonite saturation state', 2.5, 4.5, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 10
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'pCO_2 (uatm)', 150, 700, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 11
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Soil (kg m^-^3)', 0, 0.05, colmap1,xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 12
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral Pg (nmol cm^-^2 s^-^1)',0, 0.7,jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 13
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral Pn (nmol cm^-^2 s^-^1)', -0.4, 0.4,jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 14
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral R (nmol cm^-^2 s^-^1)', 0, 0.4, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 15
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral G (nmol cm^-^2 s^-^1)', 0, 0.12, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 16
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral organic C (umol cm^-^2)', 0, 20, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 17
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral d^1^3C_o_r_g_C (permil VPDB)', -20, -16, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 18
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Sediment thickness (m)', 0, 0.0025, colmap1,xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 19
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral zoox. density (cell cm^-^2)', 0, 1200000, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 20
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral growth rate (s^-^1)', 0, 0.000000012, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 21
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral mortality (s^-^1)', 0, 0.00000002, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 22
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Sea surface elevation (m)', -1.0, 1.0, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);

elseif id == 101
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Air temperature (^oC)', 25, 33, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 102
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Air pressure (hPa)', 950, 1020, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 103
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Humidity (%)', 60, 100, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 104
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Rain fall rate (kg m^-^2 s^-^1)', 0, 0.005, jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 105
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Cloud fraction', 0, 1, gray(256),xsize,ysize,xmin,xmax,ymin,ymax);
end
drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]%[0 0 290 620]

%for i=24:6:imax
%for i=2303:1:2519
%for i=1:1:imax
%for i=1:1:imax

drawnow
hgexport(figure(1), strcat('output/figs_png\t01_',num2str(i,'%0.4u'),'.png'),hgexport('factorystyle'),'Format','png');
hgexport(figure(1), strcat('output/figs_eps\t01_',num2str(i,'%0.4u'),'.eps'),hgexport('factorystyle'),'Format','eps');





