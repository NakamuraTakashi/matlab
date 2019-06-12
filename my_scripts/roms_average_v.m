%YAEYAMA case
%grd='D:\ROMS\Yaeyama\Data\Yaeyama1_grd_ver2.nc';
%his='D:\ROMS\Yaeyama\output\ocean_his_Yaeyama1.nc';
%his='D:\ROMS\Yaeyama\test1\ocean_his.nc';
%his='D:\ROMS\Yaeyama\Data\Yaeyama1_frc_JMA_140401_141001.nc';
%his='D:\ROMS\Yaeyama\Data\Yaeyama1_ini_HYCOM_140401_141001.nc';

%Shiraho reef case
grd='D:\ROMS\Shiraho_reef\Channel_Ctrl\Data\shiraho_reef_grid11.nc';
his='D:\ROMS\Shiraho_reef\Channel_Ctrl\ocean_his.nc';
%grd='D:\ROMS\Shiraho_reef\Channel_Flat\Data\shiraho_reef_grid11_without_channel.nc';
%his='D:\ROMS\Shiraho_reef\Channel_Flat\ocean_his.nc';

%istart=1873; iend=2023;
istart=73; iend=223;

%Jm=192;   % Mm+2
%Im=64;    % Lm+2

scale=2.5;  % for SHIRAHO
%scale=20;  % for YAEYAMA1
%scale=1.5;  % for Wind
%s_interval=3; % for SHIRAHO & YAEYAMA1
%s_interval=6;  % for Wind
s_interval=1; % for SHIRAHO zoom

%Vmax = 1.5; % for SHIRAHO & YAEYAMA1
%Vmax = 30;  % for Wind
Vmax = 0.1;

%starting_date=datenum(2014,4,1,0,0,0);% for YAEYAMA1
starting_date=datenum(2009,8,25,0,0,0);% for SHIRAHO
Nz=29; %30-1

h          = nc_varget(grd,'h');
%lat_rho    = nc_varget(grd,'lat_rho');
%lon_rho    = nc_varget(grd,'lon_rho');
x_rho      = nc_varget(grd,'x_rho');
y_rho      = nc_varget(grd,'y_rho');
mask_u   = nc_varget(grd,'mask_u');
mask_v   = nc_varget(grd,'mask_v');

[Jm,Im] = size(h);

c(1:Jm,1:Im)=0;
x_rho=(x_rho-min(min(x_rho)))/1000; % m->km
y_rho=(y_rho-min(min(y_rho)))/1000; % m->km

k=0;
i=1;



%xmin=0;   xmax=max(max(x_rho));  ymin=0;   ymax=max(max(y_rho));  % for ALL area
%xmin=0; xmax=2;  ymin=1; ymax=4;  % for SHIRAHO zoom
xmin=0; xmax=2;  ymin=0; ymax=5;  % for SHIRAHO zoom2

%xsize=Im*2+100; ysize=Jm*2+50;  % for YAEYAM1
%xsize=320; ysize=700; % for SHIRAHO
xsize=500; ysize=1000; % for SHIRAHO large
%xsize=500; ysize=650; % for SHIRAHO zoom
id = 1;  % <- Select 1,2,3

close all
clear ubar vber ubar2 vbar2 ubar3 vbar3

mask_u = mask_u ./mask_u;
mask_v = mask_v ./mask_v;

if id <100
%time = nc_varget(his,'ocean_time',[i],[1]);
    time = nc_varget(his,'ocean_time');
else
    time = nc_varget(his,'time');
end
imax=length(time);

if id == 1
	ubar = nc_varget(his,'ubar',[istart,0 0],[(iend-istart),Jm,Im-1]);
	vbar = nc_varget(his,'vbar',[istart,0 0],[(iend-istart),Jm-1,Im]);
elseif id == 2
    ubar = nc_varget(his,'u',[istart,Nz,0 0],[(iend-istart),1,Jm,Im-1]).*mask_u;
    vbar = nc_varget(his,'v',[istart,Nz,0 0],[(iend-istart),1,Jm-1,Im]).*mask_v;
elseif id == 100
	ubar = nc_varget(his,'Uwind',[istart,0 0],[(iend-istart),Jm,Im]);
	vbar = nc_varget(his,'Vwind',[istart,0 0],[(iend-istart),Jm,Im]);
end



%depth =squeeze(zeta(i,:,:))+h;
%depth =zeta+h;
%date=datenum(2009,8,25,0,0,0)+time/24/60/60;
if id <100
    ubar2(1:Jm,1:Im)=NaN;
    ubar(isnan(ubar))=0;
    ubar2(1:Jm,2:Im)=mean(ubar,1);%.*scale;
    vbar2(1:Jm,1:Im)=NaN;
    vbar(isnan(vbar))=0;
    vbar2(2:Jm,1:Im)=mean(vbar,1);%.*scale;
else
    ubar2=mean(ubar,1);
    vbar2=mean(vbar,1);
end


% Down sampling
x_rho2=x_rho(1:s_interval:Jm,1:s_interval:Im);
y_rho2=y_rho(1:s_interval:Jm,1:s_interval:Im);
ubar3=ubar2(1:s_interval:Jm,1:s_interval:Im);
vbar3=vbar2(1:s_interval:Jm,1:s_interval:Im);

if id <100
    date=starting_date+time(i+1)/24/60/60;
else
    date=starting_date+time(i+1);
end
date_str='One tidal cycle';

% My color map
load('MyColormaps')

if id <100
    [h_quiver,h_contour,h_annot]=createvplot4(x_rho,y_rho,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Velocity (m s^-^1)',0,Vmax,colmap1,xsize,ysize,xmin,xmax,ymin,ymax);
else
    [h_quiver,h_contour,h_annot]=createvplot4(x_rho,y_rho,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Wind velocity (m s^-^1)',0,Vmax,colmap1,xsize,ysize,xmin,xmax,ymin,ymax);
end
drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]

 
%set(h_quiver,'u',ubar2,'v',vbar2)
%set(h_annot,'String',date_str)
drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]
hgexport(figure(1), strcat('figs_png\',num2str(i,'%0.4u'),'.png'),hgexport('factorystyle'),'Format','png');



