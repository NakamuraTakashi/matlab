%
% === ver 2021/12/22   Copyright (c) 2015-2021 Takashi NAKAMURA  =====
%                for MATLAB R2019  
% clear all;
% close all;

UTM_zone = '51 R';          % UTM zone, e.g. '30 T', '32 T', '11 S', '28 R', '15 S', '51 R'
starting_date=datenum(2000,1,1,0,0,0);% for YAEYAMA2

id=2;
spherical=1;

% LOCAL_TIME=' (UTC)';
%LOCAL_TIME=' (JST)';
LOCAL_TIME=' (UTC+9)';
starting_date = starting_date + 9/24;
%LOCAL_TIME='';

out_dirstr = 'output/figs_png_Y2_online_float10000';
[status, msg] = mkdir( out_dirstr )

grd='F:/COAWST_DATA/Yaeyama/Yaeyama2/Grid/Yaeyama2_grd_v11.2.nc';

% his='D:/ROMS/Yaeyama/output/ocean_his_Yaeyama3_2g_Y2Y3_off.nc';
% flt='D:\cygwin64\home\Takashi\LTRANSv2b\Yaeyama2\output.nc';
flt='D:\cygwin64\home\Takashi\COAWST\Projects\Yaeyama2_3_201004-_offline\Yaeyama2_flt_20110525.nc';
% flt='E:\COAWTS_OUTPUT\Yaeyama2_float\Yaeyama2_flt_20110525.nc';

plgn='C:\Users\Takashi\Dropbox\collaboration\Nanami\Sekisei_area_polygon.shp';
S = shaperead(plgn);
%% 

N_pt = size(S.X,2);
X_pgon = S.X(1:N_pt-1);
Y_pgon = S.Y(1:N_pt-1);


%% 

% LevelList = [-1 1 10];
LevelList = [-1 0.2 0.5 3];
unit = 'km'; 

h          = ncread(grd,'h');
p_coral    = ncread(grd,'p_coral');
%p_seagrass = ncread(grd,'p_seagrass');
%lat_rho    = ncread(grd,'lat_rho');
%lon_rho    = ncread(grd,'lon_rho');
x_rho      = ncread(grd,'x_rho');
y_rho      = ncread(grd,'y_rho');

[Im,Jm] = size(h);
x_corner_m = min(min(x_rho));
y_corner_m = min(min(y_rho));
%c(1:Im,1:Jm)=0;
x_rho=(x_rho - x_corner_m)/1000; % m->km
y_rho=(y_rho - y_corner_m)/1000; % m->km

k=0;
i=1;

% xmin=min(min(x_rho))-0.3;   xmax=max(max(x_rho))+0.3;  ymin=min(min(y_rho))-0.3;   ymax=max(max(y_rho))+0.3;
xmin=min(min(x_rho))+0.5;   xmax=max(max(x_rho))-0.5;  ymin=min(min(y_rho))+0.5;   ymax=max(max(y_rho))-0.5;
xsize=620; ysize=550;

% Polygon
X_pgon = (X_pgon- x_corner_m)/1000; % m->km;
Y_pgon = (Y_pgon- y_corner_m)/1000; % m->km;
pgon = polyshape(X_pgon, Y_pgon);
%% 

close all
clear xfloat yfloat lonfloat latfloat

%time = nc_varget(his,'ocean_time',[i],[1]);
time = ncread(flt,'ocean_time');
imax=length(time);

%---------------------------------------------------------------------
%  Read in floats data. 
%---------------------------------------------------------------------

% spherical=ncread(his,'spherical');
if (spherical)
    lonfloat=ncread(flt,'lon',[1 1],[Inf 1]);
    latfloat=ncread(flt,'lat',[1 1],[Inf 1]);
    [xfloat(:), yfloat(:), UTM_zone] = deg2utm(latfloat(:),lonfloat(:));

    xfloat=(xfloat - x_corner_m)/1000; % m->km
    yfloat=(yfloat - y_corner_m)/1000; % m->km
else  
    xfloat=ncread(flt,'x',[1 1],[Inf 1]).*0.001;
    yfloat=ncread(flt,'y',[1 1],[Inf 1]).*0.001;

end
 


num_float=size(lonfloat,1);
ifloat = 1:num_float;
%% 

% My color map
load('MyColormaps')

i=2;
date=starting_date+time(i+1)/24/60/60;
date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

if id == 1
    [h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat(:,i),yfloat(:,i),ifloat,h,date_str,'Larvae',1,num_float,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 2
    dfloat=ncread(flt,'depth',[1 1],[Inf 1]).*-1;
%     [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat(:,i),yfloat(:,i),dfloat(:,i),h,date_str,'Larvae',-1,40,flipud(winter(256)),xsize,ysize,xmin,xmax,ymin,ymax);
    [h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat(:),yfloat(:),dfloat(:),h,date_str,'Larvae (depth/m)',-1,100,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 3
    tempfloat=ncread(flt,'temp');
    [h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat(:,i),yfloat(:,i),tempfloat(:,i),h,date_str,'Larvae (temperature)',22,29,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 4
    saltfloat=ncread(flt,'salt');
    [h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat(:,i),yfloat(:,i),saltfloat(:,i),h,date_str,'Larvae (salinity)',30,36,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 5
    phy1float=ncread(flt,'phytoplankton');
    [h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat(:,i),yfloat(:,i),phy1float(:,i),h,date_str,'Larvae (phytoplankton)',0.2,0.4,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
end
plot(pgon,'FaceColor','b','FaceAlpha',0.05);
drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]%[0 0 290 620]

%for i=3:3:imax-1%336 %imax-1  %i=1:imax-1
% for i=2527:1:imax%336 %imax-1  %i=1:imax-1
for i=1:1:imax%336 %imax-1  %i=1:imax-1
    
    if (spherical)
        lonfloat=ncread(flt,'lon',[1 i],[Inf 1]);
        latfloat=ncread(flt,'lat',[1 i],[Inf 1]);
        [xfloat(:), yfloat(:), UTM_zone] = deg2utm(latfloat(:),lonfloat(:));
        
        xfloat=(xfloat - x_corner_m)/1000; % m->km
        yfloat=(yfloat - y_corner_m)/1000; % m->km
    else  
        xfloat=ncread(flt,'x',[1 i],[Inf 1]).*0.001;
        yfloat=ncread(flt,'y',[1 i],[Inf 1]).*0.001;

    end
    in = inpolygon(xfloat, yfloat, X_pgon, Y_pgon);
    num_inpgn = sum(in);
    
    date=starting_date+time(i)/24/60/60;
    date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);
    
    if id == 1
        set(h_scatter,'XData',xfloat(:),'YData',yfloat(:),'CData',ifloat)
    elseif id == 2
        dfloat=ncread(flt,'depth',[1 i],[Inf 1]).*-1;
        set(h_scatter,'XData',xfloat(:),'YData',yfloat(:),'CData',dfloat(:))
    elseif id == 3
        set(h_scatter,'XData',xfloat(:,i),'YData',yfloat(:,i),'CData',tempfloat(:,i))
    elseif id == 4
        set(h_scatter,'XData',xfloat(:,i),'YData',yfloat(:,i),'CData',saltfloat(:,i))
    elseif id == 5
        set(h_scatter,'XData',xfloat(:,i),'YData',yfloat(:,i),'CData',phy1float(:,i))
    end
    
    set(h_annot,'String',date_str)
    title(['Number of particles inside the polygon: ' num2str(num_inpgn) '/' num2str(num_float)],'FontSize',12,'FontName','Arial', 'FontWeight', 'normal');
    drawnow
    fname = strcat( 'flt', datestr(date,'_yyyymmddHHMM') );
%     hgexport(figure(1), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');
    
end



