%
% === ver 2016/03/10   Copyright (c) 2014-2016 Takashi NAKAMURA  =====
%                for MATLAB R2015a,b  

%grd='C:\cygwin64\home\Takashi\ROMS\Projects\Shiraho_reef_offline\Data\shiraho_reef_grid11.nc'; his='C:\cygwin64\home\Takashi\ROMS\Projects\Shiraho_reef_offline\ocean_his.nc';
% grd='D:\ROMS\Shiraho_reef\OA5_Ctrl\Data\shiraho_reef_grid11.nc'; his='D:\ROMS\Shiraho_reef\OA5_Ctrl\ocean_his.nc';
% grd='C:\cygwin64\home\Takashi\ROMS\Projects\Shiraho_reef\Data\shiraho_reef_grid11.nc'; his='C:\cygwin64\home\Takashi\ROMS\Projects\Shiraho_reef\ocean_his.nc';

% grd='D:\ROMS\Yaeyama\Data\Yaeyama1_grd_v8.nc'; his='J:\ROMS\Yaeyama\Y1_1g_130601\ocean_his_Yaeyama1_1g_130601.nc';
% grd='D:\ROMS\Yaeyama\Data\Yaeyama2_grd_v9.nc'; his='D:\ROMS\Yaeyama\Y2_1g_eco_130607_7\ocean_his_Yaeyama2_1g_eco_130607.nc';

%his='C:\cygwin64\home\Takashi\ROMS\Projects\Yaeyama1\Data\Yaeyama1_air140401_141001_frc.nc';
%his='C:\cygwin64\home\Takashi\ROMS\Projects\Yaeyama1\Data\Yaeyama1_140401_141001_ini.nc';
% grd='D:\ROMS\Shiraho_reef\OAv7_present\Data\shiraho_reef_grid12.nc';
% his='D:\ROMS\Shiraho_reef\OAv7_present\ocean_his.nc';
% grd='D:\ROMS\Shiraho_reef\Data\shiraho_reef_grid13.nc';
% grd='D:\ROMS\Data\Shiraho_reef\shiraho_reef_grid16.2.nc';
% his='D:\ROMS\Shiraho_reef\OAv11\ocean_his_10_4.nc';
grd='D:\ROMS\Data\Fukido\fukido_grd_v7.nc';

% starting_date=datenum(2009,8,25,0,0,0); % for Shiraho
starting_date=datenum(2010,8,20,0,0,0); % for Shiraho
% starting_date=datenum(2013,6,1,0,0,0);

% Nz=8; % for Shiraho
Nz=3; % for Fukido
% Nz=15; %30-1
% Nz=30; %30-1

% LOCAL_TIME='(UTC)';
% LOCAL_TIME='(JST)';
% LOCAL_TIME='(UTC+9)';
LOCAL_TIME='';

wet_dry = 1;  % Dry mask OFF: 0, ON: 1


h          = ncread(grd,'h');
% p_coral    = ncread(grd,'p_coral');
% % p_coral2 = ncread(grd,'p_coral2');
% p_seagrass = ncread(grd,'p_seagrass');
% p_sand = ncread(grd,'p_sand');
% p_algae = ncread(grd,'p_algae');
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

% xsize=Im*2+100; ysize=Jm*2+100;  % for YAEYAM1
% xsize=300; ysize=680; % for SHIRAHO
xsize=250; ysize=540; % for SHIRAHO for Publish
%xsize=500; ysize=650; % for SHIRAHO zoom

id = 16;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all

% if id <100
% %time = ncread(his,'ocean_time',[i],[1]);
%     time = ncread(his,'ocean_time');
% else
%      time = ncread(his,'time');
% end

% imax=length(time);

% coral masking
coral_mask = (p_coral==0).*0+(p_coral>0).*1;
coral_mask = coral_mask ./coral_mask;
% coral2 masking
coral2_mask = (p_coral2==0).*0+(p_coral2>0).*1;
coral2_mask = coral2_mask ./coral2_mask;
% seagrass masking
sg_mask = (p_seagrass==0).*0+(p_seagrass>0).*1;
sg_mask = sg_mask ./sg_mask;
% algae masking
ag_mask = (p_algae==0).*0+(p_algae>0).*1;
ag_mask = ag_mask ./ag_mask;
% sand masking
sand_mask = (p_sand==0).*0+(p_sand>0).*1;
sand_mask = sand_mask ./sand_mask;

mask_rho = mask_rho ./mask_rho;


% My color map
load('MyColormaps')

% if id <100
%     date=starting_date+time(i+1)/24/60/60;
% else
%     date=starting_date+time(i+1);
% end
% 
date_str=strcat(datestr(starting_date,31),'  ',LOCAL_TIME);

% tmp = zeros(size(x_rho));
% tmp = ncread(his,'temp',[1 1 Nz i],[Inf Inf 1 1]);
[h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,h.*mask_rho,h, date_str,'Bathymetry',0,35,colmap2,xsize,ysize,xmin,xmax,ymin,ymax);
drawnow
hgexport(figure(1), 'output/figs_png\bath.png',hgexport('factorystyle'),'Format','png');
hgexport(figure(1), 'output/figs_eps\bath.eps',hgexport('factorystyle'),'Format','eps');

% tmp = ncread(his,'temp',[1 1 Nz i],[Inf Inf 1 1]);
[h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho, p_coral.*coral_mask ,h,date_str,'Coral coverage',0,1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
drawnow
hgexport(figure(2), 'output/figs_png\coral_cov.png',hgexport('factorystyle'),'Format','png');
hgexport(figure(2), 'output/figs_eps\coral_cov.eps',hgexport('factorystyle'),'Format','eps');

[h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho, p_coral2.*coral2_mask ,h,date_str,'Coral2 coverage',0,1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
drawnow
hgexport(figure(3), 'output/figs_png\coral2_cov.png',hgexport('factorystyle'),'Format','png');
hgexport(figure(3), 'output/figs_eps\coral2_cov.eps',hgexport('factorystyle'),'Format','eps');

[h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,p_seagrass.*sg_mask,h,date_str,'Seagrass coverage',0,1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
drawnow
hgexport(figure(4), 'output/figs_png\seagrass_cov.png',hgexport('factorystyle'),'Format','png');
hgexport(figure(4), 'output/figs_eps\seagrass_cov.eps',hgexport('factorystyle'),'Format','eps');

[h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,p_algae.*ag_mask,h,date_str,'Macroalgae coverage',0,1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
drawnow
hgexport(figure(5), 'output/figs_png\macroalgae_cov.png',hgexport('factorystyle'),'Format','png');
hgexport(figure(5), 'output/figs_eps\macroalgae_cov.eps',hgexport('factorystyle'),'Format','eps');

[h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,p_sand.*sand_mask,h,date_str,'Sand coverage',0,1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
drawnow
hgexport(figure(6), 'output/figs_png\sand_cov.png',hgexport('factorystyle'),'Format','png');
hgexport(figure(6), 'output/figs_eps\sand_cov.eps',hgexport('factorystyle'),'Format','eps');
