%
% === ver 2015/11/20   Copyright (c) 2015 Takashi NAKAMURA  =====
%                for MATLAB R2015a,b  

% UTM_zone = '51 R';          % UTM zone, e.g. '30 T', '32 T', '11 S', '28 R', '15 S', '51 R'
starting_date=datenum(0000,1,1,0,0,0);% for YAEYAMA1

id=1;

% LOCAL_TIME='(UTC)';
%LOCAL_TIME='(JST)';
% LOCAL_TIME='(UTC+9)';
LOCAL_TIME='';


grd='D:/ROMS/Data/Fukido/fukido_grd_v7.nc';
% his='D:/ROMS/output/Fukido/offline/ocean_his1.nc';
flt='D:/ROMS/output/Fukido/offline/ocean_flt.nc';
% flt2='/work1/t2gnakamulab/COTS_model/Nx2/cots_larvae_01.nc';

h          = ncread(grd,'h');
p_coral    = ncread(grd,'p_coral');
%p_seagrass = ncread(grd,'p_seagrass');
%lat_rho    = ncread(grd,'lat_rho');
%lon_rho    = ncread(grd,'lon_rho');
x_rho      = ncread(grd,'x_rho');
y_rho      = ncread(grd,'y_rho');

[Im,Jm] = size(h);
% x_corner_m = min(min(x_rho));
% y_corner_m = min(min(y_rho));
%c(1:Im,1:Jm)=0;
% x_rho=(x_rho - x_corner_m); % m->km
% y_rho=(y_rho - y_corner_m); % m->km

k=0;
i=1;

xmin=0;   xmax=max(max(x_rho));  ymin=0;   ymax=max(max(y_rho));
% xmin=30;   xmax=65;  ymin=20;   ymax=55;

% xsize=Im*2+200; ysize=Jm*2+220;  % for YAEYAM1
%xsize=290; ysize=680; % for SHIRAHO
%xsize=500; ysize=650; % for SHIRAHO zoom
xsize=550; ysize=430; % for Fukido



close all
%% 
clear xfloat yfloat lonfloat latfloat

%time = nc_varget(his,'ocean_time',[i],[1]);
time = ncread(flt,'ocean_time');
imax=length(time);

%---------------------------------------------------------------------
%  Read in floats data. 
%---------------------------------------------------------------------

% spherical=ncread(his,'spherical');
spherical=0;

if (spherical),
    lonfloat=ncread(flt,'lon',[1 i],[Inf 1]);
    latfloat=ncread(flt,'lat',[1 i],[Inf 1]);

    [xfloat, yfloat, UTM_zone] = deg2utm(latfloat,lonfloat);

    xfloat=(xfloat - x_corner_m)/1000; % m->km
    yfloat=(yfloat - y_corner_m)/1000; % m->km
    num_float=size(lonfloat,1);
else  
    xfloat=ncread(flt,'x',[1 i],[Inf 1]);
    yfloat=ncread(flt,'y',[1 i],[Inf 1]);
    num_float=size(xfloat,1);
 
end

ifloat = 1:num_float;
%%
cfloat=zeros(size(xfloat));

%% 

% My color map
load('MyColormaps')

% colmap6=vertcat(repmat(prism(26),10000,1),repmat(flipud(prism(26)),10000,1));
colmap6=vertcat(repmat(hsv(13),20000,1),repmat(jet(13),20000,1));
i=1;
date=starting_date+time(i)/24/60/60+9/24;
date_str=[datestr(date,31) '  ' LOCAL_TIME];

if id == 1
    [h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat,yfloat,ifloat,h,date_str,'Larvae (particle #)',1,num_float,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax);
%     [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat,yfloat,ifloat,h,date_str,'Larvae (particle #)',1,num_float,cool(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 2
%     [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat(:,i),yfloat(:,i),cfloat(:,i),h,date_str,'Larvae',-1,40,flipud(winter(256)),xsize,ysize,xmin,xmax,ymin,ymax);
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat,yfloat,cfloat,h,date_str,'Larvae (depth/m)',-2,32,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 3
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat,yfloat,cfloat,h,date_str,'Larvae (temperature)',26,33,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 4
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat,yfloat,cfloat,h,date_str,'Larvae (salinity)',30,36,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 5
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat,yfloat,cfloat,h,date_str,'Larvae (phytoplankton1)',0,2,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 6
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat,yfloat,cfloat,h,date_str,'Larvae (individuals/particle)',0,1.0e7,colmap1,xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 7
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat,yfloat,cfloat,h,date_str,'Larvae (phytoplankton)',0,5,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 8
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat,yfloat,cfloat,h,date_str,'Larvae (lipid)',0,1,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 9
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat,yfloat,cfloat,h,date_str,'Larvae (mortality)',0,5,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 10
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat,yfloat,cfloat,h,date_str,'Larvae (age)',0,14,jet(14),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 11
    [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat,yfloat,cfloat,h,date_str,'Larvae (status)',-0.5,4.5,jet(5),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 12
    xSet(1)=NaN;
    ySet(1)=NaN;
    cSet(1)=NaN;
    [h_scatter,h_scatter2,h_contour,h_annot]=createfltplot3(x_rho,y_rho,xfloat,yfloat,cfloat,xSet,ySet,cSet,h,date_str,'Larvae (particle #)',0,1.0e6,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
    stat1=ncread(flt2,'status_COTS_larvae',[1 1],[Inf 1]);
    stat2=stat1;
elseif id == 13
    period = zeros(size(xfloat));
    [h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat,yfloat,period,h,date_str,'Elapsed time since spawing (hours)',0,80,flipud(hsv(80)),xsize,ysize,xmin,xmax,ymin,ymax);
%     [h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat,yfloat,ifloat,h,date_str,'Larvae (particle #)',1,num_float,cool(128),xsize,ysize,xmin,xmax,ymin,ymax);
%     [h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat,yfloat,ifloat,h,date_str,'Larvae (particle #)',1,num_float,colmap5,xsize,ysize,xmin,xmax,ymin,ymax);
end

drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]%[0 0 290 620]
%% 

for i=145:1:imax-1%336 %imax-1  %i=1:imax-1
    
%     date=starting_date+time(i)/24/60/60+9/24;
    date=starting_date+time(i)/24/60/60;
    date_str=[datestr(date,31) '  ' LOCAL_TIME];
    
    if (spherical),
        lonfloat=ncread(flt,'lon',[1 i],[Inf 1]);
        latfloat=ncread(flt,'lat',[1 i],[Inf 1]);

        [xfloat, yfloat, UTM_zone] = deg2utm(latfloat,lonfloat);
        
        xfloat=(xfloat - x_corner_m)/1000; % m->km
        yfloat=(yfloat - y_corner_m)/1000; % m->km
    else  
        xfloat=ncread(flt,'x',[1 i],[Inf 1]);
        yfloat=ncread(flt,'y',[1 i],[Inf 1]);

    end
    
    if id == 1
        cfloat = ifloat;
    elseif id == 2
        cfloat=ncread(flt,'depth',[1 i],[Inf 1]).*-1;
    elseif id == 3
        cfloat=ncread(flt,'temp',[1 i],[Inf 1]);
    elseif id == 4
        cfloat=ncread(flt,'salt',[1 i],[Inf 1]);
    elseif id == 5
        cfloat=ncread(flt,'phytoplankton1',[1 i],[Inf 1]);
    elseif id == 6
        cfloat=ncread(flt2,'num_COTS_larvae',[1 i],[Inf 1]);
        xfloat(cfloat<1.0e4)=NaN;
        yfloat(cfloat<1.0e4)=NaN;
    elseif id == 7
        cfloat=ncread(flt2,'PHY_COTS_larvae',[1 i],[Inf 1]);
    elseif id == 8
        cfloat=ncread(flt2,'lipid_COTS_larvae',[1 i],[Inf 1]);
    elseif id == 9
        cfloat=ncread(flt2,'mort_COTS_larvae',[1 i],[Inf 1]);
    elseif id == 10
        cfloat=ncread(flt2,'age_COTS_larvae',[1 i],[Inf 1]);
    elseif id == 11
        cfloat=ncread(flt2,'status_COTS_larvae',[1 i],[Inf 1]);
    elseif id == 12
        stat1=ncread(flt2,'status_COTS_larvae',[1 i],[Inf 1]);
    %     stat(stat<=3)=1;
    %     stat(stat>=4)=NaN;
        cfloat=ncread(flt2,'num_COTS_larvae',[1 i],[Inf 1]);
        iset=find(stat1==4 & stat2==3);
        xSet=vertcat(xSet,xfloat(iset));
        ySet=vertcat(ySet,yfloat(iset));
        cSet=vertcat(cSet,cfloat(iset));

        xfloat(cfloat<1.0e4)=NaN;
        yfloat(cfloat<1.0e4)=NaN;
        xfloat(stat1>=4)=NaN;
        yfloat(stat1>=4)=NaN;

        stat2=stat1;
    elseif id == 13
        exist = zeros(size(xfloat));
        exist(~isnan(xfloat))=1;
        period = period +exist;
        pelagic_period = 73;   % 73; 49; 25; % hours
        xfloat(period>pelagic_period)=NaN;
        yfloat(period>pelagic_period)=NaN;
        cfloat = period;
%         cfloat = ifloat;
    end
    set(h_scatter,'XData',xfloat,'YData',yfloat,'CData',cfloat)    
    set(h_annot,'String',date_str)
    
    drawnow
    hgexport(figure(1), strcat('output/figs_png\flt01_',num2str(i,'%0.4u'),'.png'),hgexport('factorystyle'),'Format','png');
    
end



