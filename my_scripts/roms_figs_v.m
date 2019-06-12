%
% === ver 2015/04/02   Copyright (c) 2014-2015 Takashi NAKAMURA  =====
%                for MATLAB R2015a  


%Shiraho reef case
grd='D:\ROMS\Shiraho_reef\OA5_Ctrl\Data\shiraho_reef_grid11.nc'; his='D:\ROMS\Shiraho_reef\OA5_Ctrl\ocean_his.nc';

i=100;
id = 2;  % <- Select 1,2,3,100

if id==1 || id==2
    scale=0.8;   % for SHIRAHO
%    scale=20;  % for YAEYAMA1
%    scale=5;   % for YAEYAMA2
%    scale=2;   % for YAEYAMA3
elseif id == 3
    scale=0.08;  % for Wave
elseif id == 100
    scale=1.5;  % for Wind
end

s_interval=3; % for SHIRAHO & YAEYAMA1 & YAEYAMA3
%s_interval=6;  % for Wind
%s_interval=1; % for SHIRAHO
%s_interval=3; % for test

Vmax = 0.8; % for SHIRAHO
%Vmax = 1.5; % for YAEYAMA1 & YAEYAMA2 & YAEYAMA3
%Vmax = 30;  % for Wind

%starting_date=datenum(2014,4,1,0,0,0);% for YAEYAMA1
starting_date=datenum(2009,8,25,0,0,0);% for SHIRAHO
%Nz=30; 
Nz=8; 

%LOCAL_TIME='(UTC)';
%LOCAL_TIME='(JST)';
%LOCAL_TIME='(UTC+9)';
LOCAL_TIME='';

wet_dry = 1;  % Dry mask OFF: 0, ON: 1

h          = ncread(grd,'h');
%lat_rho    = ncread(grd,'lat_rho');
%lon_rho    = ncread(grd,'lon_rho');
x_rho      = ncread(grd,'x_rho');
y_rho      = ncread(grd,'y_rho');
mask_u   = ncread(grd,'mask_u');
mask_v   = ncread(grd,'mask_v');

[Im, Jm] = size(h);

c(1:Im,1:Jm)=0;
x_rho=(x_rho-min(min(x_rho)))/1000; % m->km
y_rho=(y_rho-min(min(y_rho)))/1000; % m->km

k=0;

xmin=0;   xmax=max(max(x_rho));  ymin=0;   ymax=max(max(y_rho));
%xmin=0; xmax=2;  ymin=1; ymax=4;

%xsize=Im*2+100; ysize=Jm*2+100;  % for YAEYAM1
xsize=290; ysize=680; % for SHIRAHO
%xsize=500; ysize=650; % for SHIRAHO zoom

close all
clear ubar vber ubar2 vbar2 ubar3 vbar3

mask_u = mask_u ./mask_u;
mask_v = mask_v ./mask_v;

if id <100
%time = ncread(his,'ocean_time',[i],[1]);
    time = ncread(his,'ocean_time');
else
    time = ncread(his,'time');
end
imax=length(time);

if id == 1
	ubar = ncread(his,'ubar',[1 1 i],[Inf Inf 1]);
	vbar = ncread(his,'vbar',[1 1 i],[Inf Inf 1]);
elseif id == 2
    ubar = ncread(his,'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
    vbar = ncread(his,'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
elseif id == 3
	dwave = ncread(his,'Dwave',[1 1 i],[Inf Inf 1]);
	hwave = ncread(his,'Hwave',[1 1 i],[Inf Inf 1]);
    ubar = cos(pi*dwave/180);
    vbar = sin(pi*dwave/180);
    if wet_dry == 1
        wetdry_mask_rho = ncread(his,'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
        wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
        hwave = hwave .* wetdry_mask_rho;
    end
elseif id == 100
	ubar = ncread(his,'Uwind',[1 1 i],[Inf Inf 1]);
	vbar = ncread(his,'Vwind',[1 1 i],[Inf Inf 1]);
end



%depth =squeeze(zeta(i,:,:))+h;
%depth =zeta+h;
%date=datenum(2009,8,25,0,0,0)+time/24/60/60;
if id==1 || id==2
    ubar2(1:Im, 1:Jm)=NaN;
    ubar2(2:Im, 1:Jm)=ubar;%.*scale;
    vbar2(1:Im, 1:Jm)=NaN;
    vbar2(1:Im, 2:Jm)=vbar;%.*scale;
else
    ubar2=ubar;
    vbar2=vbar;
end

vel=hypot(ubar2,ubar2);

% Down sampling
x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
ubar3=ubar2(1:s_interval:Im,1:s_interval:Jm);
vbar3=vbar2(1:s_interval:Im,1:s_interval:Jm);

if id <100
    date=starting_date+time(i+1)/24/60/60;
else
    date=starting_date+time(i+1);
end
date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

% My color map
load('MyColormaps')

if id==1 || id==2
    [h_quiver,h_surf,h_contour,h_annot]=createvplot5(x_rho,y_rho,vel,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Velocity (m s^-^1)',0,Vmax,jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 3
    [h_quiver,h_surf,h_contour,h_annot]=createvplot5(x_rho,y_rho,hwave,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Hs (m)',0,1.5,jet(256),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 100
    [h_quiver,h_surf,h_contour,h_annot]=createvplot5(x_rho,y_rho,vel,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Wind velocity (m s^-^1)',0,Vmax,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
end

drawnow


hgexport(figure(1), strcat('output/figs_png\v01_',num2str(i,'%0.4u'),'.png'),hgexport('factorystyle'),'Format','png');
hgexport(figure(1), strcat('output/figs_eps\v01_',num2str(i,'%0.4u'),'.eps'),hgexport('factorystyle'),'Format','eps');


