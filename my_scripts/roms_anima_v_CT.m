%
% === Copyright (c) 2014-2019 Takashi NAKAMURA  =====
%

% Coral Triangle case
grd='D:/ROMS/Data/Coral_Triangle/CT_0.08_grd_v2.nc'; 
his='D:\cygwin64\home\Takashi\COAWST\Projects\Coral_Triangle\CT_0.08_his_201704.nc';

starting_date=datenum(2000,1,1,0,0,0); % 

%Jm=192;   % Mm+2
%Im=64;    % Lm+2

id = 5;  % <- Select 1,2,3,100

if id==1 || id==2  || id==4  || id==5
    scale=1.5;   % for SHIRAHO
    s_interval=7; % for SHIRAHO & YAEYAMA1 & YAEYAMA3
    Vmax = 2; % for SHIRAHO
elseif id == 3
    scale=0.08;  % for Wave
    s_interval=4; % for SHIRAHO & YAEYAMA1 & YAEYAMA3
elseif id == 100
%     scale=1.5;  % for Wind
    scale=1;  % for Wind
    s_interval=6;  % for Wind
    Vmax = 20;  % for Wind
end

Nz=30;  % for SHIRAHO

% LOCAL_TIME='(UTC)';
%LOCAL_TIME='(JST)';
%LOCAL_TIME='(UTC+9)';
LOCAL_TIME='';

wet_dry = 1;  % Dry mask OFF: 0, ON: 1

% unit = 'km'; % 'm', 'latlon'
unit = 'latlon';
LevelList = [0 1];

h          = ncread(grd,'h');
y_rho    = ncread(grd,'lat_rho');
x_rho    = ncread(grd,'lon_rho');
% x_rho      = ncread(grd,'x_rho');
% y_rho      = ncread(grd,'y_rho');
mask_u   = ncread(grd,'mask_u');
mask_v   = ncread(grd,'mask_v');
mask_rho   = ncread(grd,'mask_rho');

[Im, Jm] = size(h);

c(1:Im,1:Jm)=0;
% x_rho=(x_rho-min(min(x_rho)))/1000; % m->km
% y_rho=(y_rho-min(min(y_rho)))/1000; % m->km

k=0;
i=1;

xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));

% xsize=250; ysize=540; % for SHIRAHO for Publish
xsize=850; ysize=500; % for SHIRAHO for Animation

close all
% clear ubar vber ubar2 vbar2 ubar3 vbar3

mask_u = mask_u ./mask_u;
mask_v = mask_v ./mask_v;
mask_rho = mask_rho ./mask_rho;

if id <100
%time = ncread(his,'ocean_time',[i],[1]);
    time = ncread(his,'ocean_time');
else
    time = ncread(his1,'time');
end
imax=length(time);

tmp = zeros(size(x_rho));

% Down sampling
x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
% ubar3=ubar2(1:s_interval:Im,1:s_interval:Jm);
% vbar3=vbar2(1:s_interval:Im,1:s_interval:Jm);
ubar3=zeros(size(x_rho2));
vbar3=zeros(size(x_rho2));

if id <100
    date=starting_date+time(i+1)/24/60/60;
else
    date=starting_date+time(i+1);
end
date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

% My color map
load('MyColormaps')

if id==1 || id==2
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Velocity (m s^-^1)',0,Vmax,colmap4,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 3
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Hs (m)',0,1.5,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 4
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Temperature (^oC)',20,32,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 5
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Water elevation (m)',-1.5,2.5,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 100
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Wind velocity (m s^-^1)',0,Vmax,colmap4,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
end

drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]

% for i=1:1:imax
for i=1:1:imax

    if id == 1
        ubar = ncread(his,'ubar',[1 1 i],[Inf Inf 1]);
        vbar = ncread(his,'vbar',[1 1 i],[Inf Inf 1]);
    elseif id == 2
        ubar = ncread(his,'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
        vbar = ncread(his,'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
    elseif id == 3
        dwave = ncread(his,'Dwave',[1 1 i],[Inf Inf 1]);
        tmp = ncread(his,'Hwave',[1 1 i],[Inf Inf 1]);
        ubar = cos(pi*dwave/180);
        vbar = sin(pi*dwave/180);
        if wet_dry == 1
            wetdry_mask_rho = ncread(his,'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
            wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
            tmp = tmp .* wetdry_mask_rho;
        end
    elseif id == 4
        ubar = ncread(his,'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
        vbar = ncread(his,'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
        tmp = ncread(his,'temp',[1 1 Nz i],[Inf Inf 1 1]);  % Surface
    elseif id == 5
        ubar = ncread(his,'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
        vbar = ncread(his,'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
        tmp = ncread(his,'zeta',[1 1 i],[Inf Inf 1]).*mask_rho;
    elseif id == 100
        ubar = ncread(his1,'Uwind',[1 1 i],[Inf Inf 1]);
        vbar = ncread(his2,'Vwind',[1 1 i],[Inf Inf 1]);
    end


    if id <100
        date=starting_date+time(i)/24/60/60;
    else
        date=starting_date+time(i);
    end
    date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

    if id==1 || id==2
        ubar2(1:Im, 1:Jm)=NaN;
        ubar2(2:Im, 1:Jm)=ubar;%.*scale;
        vbar2(1:Im, 1:Jm)=NaN;
        vbar2(1:Im, 2:Jm)=vbar;%.*scale;
        tmp=hypot(ubar2,vbar2);
    elseif id == 3
        ubar2=ubar;
        vbar2=vbar;
        vel=hwave;
    elseif id == 4 || id==5
        ubar2=ubar;
        vbar2=vbar;
    elseif id == 100
        ubar2=ubar;
        vbar2=vbar;
        tmp=hypot(ubar2,vbar2);
    end


    % Down sampling
    ubar3=ubar2(1:s_interval:Im,1:s_interval:Jm);
    vbar3=vbar2(1:s_interval:Im,1:s_interval:Jm);

    set(h_surf,'CData',tmp)
    set(h_quiver,'UData',ubar3*scale)
    set(h_quiver,'VData',vbar3*scale)
    set(h_annot,'String',date_str)

    drawnow

    hgexport(figure(1), strcat('output/figs_png\v01_',num2str(i,'%0.4u'),'.png'),hgexport('factorystyle'),'Format','png');
%     hgexport(figure(1), strcat('output/figs_eps\v01_',num2str(i,'%0.4u'),'.eps'),hgexport('factorystyle'),'Format','eps');
end


