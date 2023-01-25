%
% === Copyright (c) 2014-2023 Takashi NAKAMURA  =====
%
% Panay0
grd='F:\COAWST_DATA\Panay\Panay0\Grid\Panay0_swan_grd_v1.0.nc';

FTYPE = 1;  % MATLAB file type (*.mat)
% FTYPE = 2; % NetCDF file type (*.nc)

out_dirstr = 'output/figs_png_panay0_wave';

if FTYPE == 1
    hsig='E:\COAWTS_OUTPUT\Panay\Panay0\output2\Panay0_swan_Hs_20210101.mat';
    dir ='E:\COAWTS_OUTPUT\Panay\Panay0\output2\Panay0_swan_Dir_20210101.mat';
    starting_date=datenum(2021,1,1,0,0,0);
elseif FTYPE == 2
    hsig='E:\COAWTS_OUTPUT\Panay\Panay0\output3\Panay0_swan_Hsig_20210101.nc';
    dir ='E:\COAWTS_OUTPUT\Panay\Panay0\output3\Panay0_swan_Dpk__20210101.nc';
    starting_date=datenum(1970,1,1,0,0,0);
end
% starting_date=datenum(2021,1,1,0,0,0);

xmin=45;   xmax=490;  ymin=-6.5;   ymax=440;  % for Panay0
% xmin=min(min(x_rho))-1;   xmax=max(max(x_rho))+1;  ymin=min(min(y_rho))-1;   ymax=max(max(y_rho))+1;
xsize=600; ysize=500; % Window size


% My color map
load('MyColormaps')
colormap7=superjet(128,'xvbZctgyorWq');

title='Hs (m)'; cmin=0; cmax=2.5; colmap=colormap7;

scale=6;  % for Wave
s_interval=5; % for SHIRAHO & YAEYAMA1 & YAEYAMA3

LOCAL_TIME=' (UTC)';
%LOCAL_TIME='(JST)';
% LOCAL_TIME='(UTC+9)';
% LOCAL_TIME='';

unit = 'km'; 
% 'm', 'latlon'
% unit = 'latlon';
LevelList = [0 10];

%--------------------------------------------------------------------------

[status, msg] = mkdir( out_dirstr )

h          = ncread(grd,'h');
% y_rho    = ncread(grd,'lat_rho');
% x_rho    = ncread(grd,'lon_rho');
x_rho      = ncread(grd,'x_rho');
y_rho      = ncread(grd,'y_rho');
x_rho=(x_rho-min(min(x_rho)))/1000; % m->km
y_rho=(y_rho-min(min(y_rho)))/1000; % m->km
% mask_u   = ncread(his,'mask_u');
% mask_v   = ncread(his,'mask_v');
mask_rho   = ncread(grd,'mask_rho');

if FTYPE == 1
    imax = 24*365;  % ********** Need to set ******************************
elseif FTYPE == 2
    time_sec = ncread(hsig,'time');
    imax = size(time_sec,1);
end

[Im, Jm] = size(h);

close all

mask_rho = mask_rho ./mask_rho;

tmp = zeros(size(x_rho)).*mask_rho;

% Down sampling
x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
ubar3=zeros(size(x_rho2));
vbar3=zeros(size(x_rho2));

date=starting_date;
date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

[h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);

drawnow

for i=1:1:imax
% for i=1:1:24*365

    if FTYPE == 1
        date=starting_date+(i-1)/24;

        nameStr = ['Hsig_' datestr(date,'yyyymmdd_HHMMSS')];
        S = load(hsig,nameStr);
        tmp=S.(nameStr).';
    
        nameStr = ['PkDir_' datestr(date,'yyyymmdd_HHMMSS')];
        S = load(dir,nameStr);
        dwave=S.(nameStr).';

    elseif FTYPE == 2

        date=starting_date+double(time_sec(i))/24/60/60;

        tmp = ncread(hsig,'hs',[1 1 i],[Inf Inf 1]);
        dwave = ncread(dir,'thetap',[1 1 i],[Inf Inf 1]);
    end
    
    ubar = cos(pi*dwave/180);
    vbar = sin(pi*dwave/180);

    date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

    % Down sampling
    ubar3=ubar(1:s_interval:Im,1:s_interval:Jm);
    vbar3=vbar(1:s_interval:Im,1:s_interval:Jm);

    set(h_surf,'CData',tmp)
    set(h_quiver,'UData',ubar3*scale)
    set(h_quiver,'VData',vbar3*scale)
    set(h_annot,'String',date_str)

    drawnow

    fname = ['wave', datestr(date,'_yyyymmddHHMM') ];
    hgexport(figure(1), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');
%     hgexport(figure(1), strcat('output/figs_eps/', fname,'.eps'),hgexport('factorystyle'),'Format','eps');
end


