%
% === ver 2015/10/26   Copyright (c) 2015 Takashi NAKAMURA  =====
%                for MATLAB R2015a,b  

% UTM_zone = '51 R';          % UTM zone, e.g. '30 T', '32 T', '11 S', '28 R', '15 S', '51 R'
starting_date=datenum(2014,4,1,0,0,0);% for YAEYAMA1

id=2;

LOCAL_TIME='(UTC)';
%LOCAL_TIME='(JST)';
%LOCAL_TIME='(UTC+9)';
%LOCAL_TIME='';

% grd='D:/ROMS/Yaeyama/Data/Yaeyama2_grd_v8.nc';
% his='D:/ROMS/Yaeyama/output/ocean_his_Yaeyama2_1g_1_1.nc';
% flt='C:\cygwin64\home\Takashi\ROMS\Projects\Yaeyama\ocean_flt.nc';
% grd='D:/ROMS/Yaeyama/Data/Yaeyama2_grd_v8.nc';
% his='D:/ROMS/Yaeyama/output/ocean_his_Yaeyama2_1g_1_2.nc';
% flt='D:/ROMS/Yaeyama/output/ocean_flt_Yaeyama2_1g_1_2.nc';
% flt='C:\cygwin64\home\Takashi\ROMS\Projects\Yaeyama_offline\ocean_flt.nc';

grd='D:/ROMS/Yaeyama/Data/Yaeyama2_grd_v8.nc';
% grd='D:/ROMS/Yaeyama/Data/Yaeyama3_grd_v8.nc';
his='D:/ROMS/Yaeyama/output/ocean_his_Yaeyama3_2g_Y2Y3_off.nc';
% flt='D:/ROMS/Yaeyama/output/ocean_flt_Yaeyama3_2g_Y2Y3_off.nc';
% flt='D:/ROMS/Yaeyama/output/ocean_flt_Yaeyama2_2g_Y2Y3_off.nc';
% flt='D:/ROMS/Yaeyama/test_eco_1g_Y2/ocean_flt_Yaeyama2_1g_eco_1.nc';
flt='C:\cygwin64\home\Takashi\LTRANSv2b\projects\Yaeyama\output\output.nc';

% grd='C:\cygwin64\home\Takashi\ROMS\Projects\Shiraho_reef_offline\Data\shiraho_reef_grid11.nc';
% his='C:\cygwin64\home\Takashi\ROMS\Projects\Shiraho_reef_offline\ocean_his.nc';
% flt='C:\cygwin64\home\Takashi\ROMS\Projects\Shiraho_reef_offline\ocean_flt.nc';
%grd='D:\output\ROMS\Shiraho_reef\flt_test1\Data\shiraho_reef_grid10.nc';
%his='D:\output\ROMS\Shiraho_reef\flt_test1\ocean_his.nc';
%flt='D:\output\ROMS\Shiraho_reef\flt_test1\ocean_flt.nc';
%grd='D:\output\ROMS\Shiraho_reef\flt_test2\Data\shiraho_reef_grid10.nc';
%his='D:\output\ROMS\Shiraho_reef\flt_test2\ocean_his.nc';
%flt='D:\output\ROMS\Shiraho_reef\flt_test2\ocean_flt.nc';

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

xmin=0;   xmax=max(max(x_rho));  ymin=0;   ymax=max(max(y_rho));

xsize=Im*2+100; ysize=Jm*2+100;  % for YAEYAM1
%xsize=290; ysize=680; % for SHIRAHO
%xsize=500; ysize=650; % for SHIRAHO zoom



close all
clear xfloat yfloat lonfloat latfloat

%time = nc_varget(his,'ocean_time',[i],[1]);
time = ncread(flt,'model_time');
imax=length(time);

%---------------------------------------------------------------------
%  Read in floats data. 
%---------------------------------------------------------------------

spherical=ncread(his,'spherical');

if (spherical),
    lonfloat=ncread(flt,'lon');
    latfloat=ncread(flt,'lat');
    for i = 1:size(lonfloat,2);
        [xfloat(:,i), yfloat(:,i), UTM_zone] = deg2utm(latfloat(:,i),lonfloat(:,i));
    end
    xfloat=(xfloat - x_corner_m)/1000; % m->km
    yfloat=(yfloat - y_corner_m)/1000; % m->km
else  
    xfloat=ncread(flt,'x').*0.001;
    yfloat=ncread(flt,'y').*0.001;
    
end

num_float=size(lonfloat,1);
ifloat = 1:num_float;

% My color map
load('MyColormaps')

i=1;
date=starting_date+time(i+1)/24/60/60;
date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

if id == 1
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat(:,i),yfloat(:,i),ifloat,h,date_str,'Larvae',1,num_float,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 2
    dfloat=ncread(flt,'depth').*-1;
%     [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat(:,i),yfloat(:,i),dfloat(:,i),h,date_str,'Larvae',-1,40,flipud(winter(256)),xsize,ysize,xmin,xmax,ymin,ymax);
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat(:,i),yfloat(:,i),dfloat(:,i),h,date_str,'Larvae (depth/m)',-2,32,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 3
    tempfloat=ncread(flt,'temp');
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat(:,i),yfloat(:,i),tempfloat(:,i),h,date_str,'Larvae (temperature)',22,29,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 4
    saltfloat=ncread(flt,'salt');
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat(:,i),yfloat(:,i),saltfloat(:,i),h,date_str,'Larvae (salinity)',30,36,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 5
    phy1float=ncread(flt,'phytoplankton');
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat(:,i),yfloat(:,i),phy1float(:,i),h,date_str,'Larvae (phytoplankton)',0.2,0.4,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
end

drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]%[0 0 290 620]

%for i=3:3:imax-1%336 %imax-1  %i=1:imax-1
for i=1:1:imax%336 %imax-1  %i=1:imax-1
    
    date=starting_date+time(i)/24/60/60;
    date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);
    
    if id == 1
        set(h_scatter,'XData',xfloat(:,i),'YData',yfloat(:,i),'CData',ifloat)
    elseif id == 2
        set(h_scatter,'XData',xfloat(:,i),'YData',yfloat(:,i),'CData',dfloat(:,i))
    elseif id == 3
        set(h_scatter,'XData',xfloat(:,i),'YData',yfloat(:,i),'CData',tempfloat(:,i))
    elseif id == 4
        set(h_scatter,'XData',xfloat(:,i),'YData',yfloat(:,i),'CData',saltfloat(:,i))
    elseif id == 5
        set(h_scatter,'XData',xfloat(:,i),'YData',yfloat(:,i),'CData',phy1float(:,i))
    end
    
    set(h_annot,'String',date_str)
    
    drawnow
    hgexport(figure(1), strcat('output/figs_png\flt01_',num2str(i,'%0.4u'),'.png'),hgexport('factorystyle'),'Format','png');
    
end



