%addpath ('E:\Win7_MainPC\ROMS_results');
grd='D:\output\ROMS\Shiraho_reef\OA3_Ctrl\Data\shiraho_reef_grid10.nc';
his='D:\output\ROMS\Shiraho_reef\OA3_Ctrl\ocean_his.nc';
%grd='for_matlab_testing\shiraho_reef_grid8.nc';
%his='for_matlab_testing\ocean_his.nc';
%dia='E:\Win7_MainPC\ROMS_results\ocean_dia_CTL.nc';

Jm=192;   % Mm+2
Im=64;    % Lm+2
scale=0.8;
s_interval=2;

h          = nc_varget(grd,'h');
p_coral    = nc_varget(grd,'p_coral');
p_seagrass = nc_varget(grd,'p_seagrass');
lat_rho    = nc_varget(grd,'lat_rho');
lon_rho    = nc_varget(grd,'lon_rho');
x_rho      = nc_varget(grd,'x_rho');
y_rho      = nc_varget(grd,'y_rho');
c(1:Jm,1:Im)=0;
x_rho=x_rho/1000; % m->km
y_rho=y_rho/1000; % m->km

i=2076;%954;%864,882,900,918,936

%time = nc_varget(his,'ocean_time',[i],[1]);
time = nc_varget(his,'ocean_time');
ubar = nc_varget(his,'ubar',[i,0 0],[1,Jm,Im-1]);
vbar = nc_varget(his,'vbar',[i,0 0],[1,Jm-1,Im]);
zeta = nc_varget(his,'zeta',[i,0 0],[1,Jm,Im]);
Hwave= nc_varget(his,'Hwave',[i,0 0],[1,Jm,Im]);
%Dwave= nc_varget(his,'Dwave',[i,0 0],[1,Jm,Im]); 
temp = nc_varget(his,'temp',[i,7,0 0],[1,1,Jm,Im]);
salt = nc_varget(his,'salt',[i,7,0 0],[1,1,Jm,Im]);
%mud_01= nc_varget(his,'mud_01',[i,7,0 0],[1,1,Jm,Im]);
DIC  = nc_varget(his,'TIC',[i,7,0 0],[1,1,Jm,Im]);
TA   = nc_varget(his,'alkalinity',[i,7,0 0],[1,1,Jm,Im]) ;
DO   = nc_varget(his,'oxygen',[i,7,0 0],[1,1,Jm,Im]);
%DI13C    = nc_varget(his,'TI13C',[i,7,0 0],[1,1,Jm,Im]);
%d13C_DIC = nc_varget(his,'d13C_DIC',[i,7,0 0],[1,1,Jm,Im]);
pH= nc_varget(his,'pH',[i,0 0],[1,Jm,Im]);
%Warg= nc_varget(his,'Warg',[i,0 0],[1,Jm,Im]);
Warg= nc_varget(his,'Omega_arg',[i,0 0],[1,Jm,Im]);
pCO2= nc_varget(his,'pCO2',[i,0 0],[1,Jm,Im]);
wetdry_mask_rho= nc_varget(his,'wetdry_mask_rho',[i,0 0],[1,Jm,Im]);

% coral masking
coral_mask = (p_coral==0).*0+(p_coral>0).*1;
coral_mask = coral_mask ./coral_mask;

% wet/dry masking
wetdry_mask_rho = wetdry_mask_rho ./ wetdry_mask_rho;
zeta = zeta ./ wetdry_mask_rho;

coral_Pg= nc_varget(his,'coral_Pg',[i,0 0],[1,Jm,Im]) .*coral_mask;
coral_Pn= nc_varget(his,'coral_Pn',[i,0 0],[1,Jm,Im]) .*coral_mask;
coral_R= nc_varget(his,'coral_R',[i,0 0],[1,Jm,Im]) .*coral_mask;
coral_G= nc_varget(his,'coral_G',[i,0 0],[1,Jm,Im]) .*coral_mask;
coral_orgC= nc_varget(his,'coral_orgC',[i,0 0],[1,Jm,Im]) .*coral_mask;
%coral_d13Ctissue= nc_varget(his,'coral_d13Ctissue',[i,0 0],[1,Jm,Im]) .*coral_mask;

%depth =squeeze(zeta(i,:,:))+h;
depth =zeta+h;
%date=datenum(2009,8,25,0,0,0)+time/24/60/60;
date=datenum(2009,8,25,0,0,0)+time(i+1)/24/60/60;
date_str=datestr(date,31);
date_str2=datestr(datenum(2009,8,25,0,0,0),31);

ubar2(1:Jm,1:Im)=NaN;
ubar2(1:Jm,2:Im)=ubar;
vbar2(1:Jm,1:Im)=NaN;
vbar2(2:Jm,1:Im)=vbar;
x_rho2=x_rho(1:s_interval:Jm,1:s_interval:Im);
y_rho2=y_rho(1:s_interval:Jm,1:s_interval:Im);
ubar3=ubar2(1:s_interval:Jm,1:s_interval:Im);
vbar3=vbar2(1:s_interval:Jm,1:s_interval:Im);

% My color map
load('MyColormaps')

% Bathymetry
createfigure(x_rho,y_rho,h,h,date_str2,'Depth (m)',0,40,colmap2)
% Draw coral and seagrass coverage
createfigure(x_rho,y_rho,p_coral,h,date_str2,'Coral coverage',0,1,colmap3)
createfigure(x_rho,y_rho,p_seagrass,h,date_str2,'Seagrass coverage',0,1,colmap3)



createvplot2(x_rho,y_rho,x_rho2,y_rho2,ubar3,vbar3,h,date_str,'Velocity (m s^-^1)',0,0.6,colmap1);
% 1 cell (50m) -> 10 (cm/s)

createfigure(x_rho,y_rho,Hwave,h,date_str,'Wave height (m)',0,1.5,jet(256))

createfigure(x_rho,y_rho,zeta,h,date_str,'Sea surface hight (m)',0.43,0.53,jet(256))

createfigure(x_rho,y_rho,temp,h,date_str,'Temperature (^oC)',27,35,jet(256))

createfigure(x_rho,y_rho,salt,h,date_str,'Salinity (psu)',33.9,34.5,jet(256))

createfigure(x_rho,y_rho,DIC,h,date_str,'DIC (umol kg^-^1)',1600,2050,jet(256))

createfigure(x_rho,y_rho,TA,h,date_str,'TA (umol kg^-^1)',2100,2270,jet(256))

createfigure(x_rho,y_rho,DO,h,date_str,'DO (umol L^-^1)',100,300,jet(256))

%createfigure(x_rho,y_rho,d13C_DIC,h,date_str,'d^1^3C_D_I_C (permil VPDB)',-1,2.5,jet(256))

createfigure(x_rho,y_rho,pH,h,date_str,'pH (total scale)', 7.8, 8.2 ,jet(256))

createfigure(x_rho,y_rho,Warg,h,date_str,'Aragonite saturation state', 2.5, 4.5, jet(256))

createfigure(x_rho,y_rho,pCO2,h,date_str,'pCO_2 (uatm)', 150, 700, jet(256))

createfigure(x_rho,y_rho,coral_Pg,h,date_str,'Coral Pg (nmol cm^-^2 s^-^1)',0, 0.7,jet(256))

createfigure(x_rho,y_rho,coral_Pn,h,date_str,'Coral Pn (nmol cm^-^2 s^-^1)', -0.4, 0.4,jet(256))

createfigure(x_rho,y_rho,coral_R,h,date_str,'Coral R (nmol cm^-^2 s^-^1)', 0, 0.4, jet(256))

createfigure(x_rho,y_rho,coral_G,h,date_str,'Coral G (nmol cm^-^2 s^-^1)', 0, 0.12, jet(256))

createfigure(x_rho,y_rho,coral_orgC,h,date_str,'Coral organic C (umol cm^-^2)', 0, 20, jet(256))

%createfigure(x_rho,y_rho,coral_d13Ctissue,h,date_str,'Coral d^1^3C_t_i_s_s_u_e (permil VPDB)', -20, -16, jet(256))

%clear time zeta temp




