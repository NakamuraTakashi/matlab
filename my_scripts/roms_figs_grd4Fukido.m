%
% === ver 2016/03/10   Copyright (c) 2014-2016 Takashi NAKAMURA  =====
%                for MATLAB R2015a,b  

grd='D:\ROMS\Data\Fukido\fukido_grd_v7.nc';

starting_date=datenum(2009,8,25,0,0,0); % for Shiraho
% starting_date=datenum(2010,8,20,0,0,0); % for Shiraho
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
% x_rho=(x_rho-min(min(x_rho))); % m->km
% y_rho=(y_rho-min(min(y_rho))); % m->km

k=0;
i=1;

xmin=0;   xmax=max(max(x_rho));  ymin=0;   ymax=max(max(y_rho));
% xmin=0;   xmax=2.3;  ymin=0;   ymax=max(max(y_rho));

% xsize=Im*2+100; ysize=Jm*2+100;  % for YAEYAM1
% xsize=300; ysize=680; % for SHIRAHO
% xsize=250; ysize=540; % for SHIRAHO for Publish
%xsize=500; ysize=650; % for SHIRAHO zoom
xsize=550; ysize=430; % for Fukido

id = 16;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all

% if id <100
% %time = ncread(his,'ocean_time',[i],[1]);
%     time = ncread(his,'ocean_time');
% else
%      time = ncread(his,'time');
% end

% imax=length(time);

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
[h_surf,h_contour,h_annot]=createfigure4(x_rho,y_rho,h.*mask_rho,h, date_str,'Bathymetry',-0.5,1.5,colmap2,xsize,ysize,xmin,xmax,ymin,ymax);
drawnow
hgexport(figure(1), 'output/figs_png\bath.png',hgexport('factorystyle'),'Format','png');
hgexport(figure(1), 'output/figs_eps\bath.eps',hgexport('factorystyle'),'Format','eps');

