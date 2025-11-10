%
% === ver 2021/12/22   Copyright (c) 2015-2025 Takashi NAKAMURA  =====
%
clear all;
close all;

% CASE 1=> Shizugawa1; 2=> Shizugawa2; 3=> Shizugawa3
% CASE 4=> Yaeyama1; 5=> Yaeyama2; 6=> Yaeyama3
% CASE 7=> Shiraho reef

% CASE 17=> FORP-JPN02 offline
% CASE 18=> Kushimoto

CASE = 18;

% --- Plotting period --- %
min_date    = datenum(2010,6,21,0,0,0);  % Period 4 start
max_date    = datenum(2010,8,10,0,0,0);  % Period 4 end

ref_date     = datenum(2000,1,1,0,0,0);  % 

id=1;
% id=2;
% id=10;

%==================== Shizugawa ==============================================
if CASE == 1      % Shizugawa1
    grd='D:\COAWST_DATA\Shizugawa\Shizugawa1\Grid\Shizugawa1_grd_v0.1.nc';
    out_dirstr = 'output/figs_png_SZ1tmp_srf';
    
    LevelList = [-10 0 200 400 600 800 1000 1200 1400 1600 1800 2000 2200];
    
    % Nz=15; % Surface
    Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
    
elseif CASE == 2  % Shizugawa2
    grd='D:\COAWST_DATA\Shizugawa\Shizugawa2\Grid\Shizugawa2_grd_v0.2.nc';
    out_dirstr = 'output/figs_png_SZ2tmp_btm';
    
    LevelList = [-10 0 20 40 60 80 100 120 140 160 180 200 220];
    
    % Nz=15; % Surface
    Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

elseif CASE == 3  % Shizugawa3
    grd='D:\COAWST_DATA\Shizugawa\Shizugawa3\Grid\Shizugawa3_grd_v0.3b.nc';
    out_dirstr = 'output/figs_png_SZ3aqdrag_btm';
    
    LevelList = [-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130];
    
    % Nz=15; % Surface
    Nz=1; % Bottom (Sediment: surface layer)
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

%==================== Yaeyama ==============================================
elseif CASE == 4      % Yaeyama1
    grd='D:\COAWST_DATA\Yaeyama\Yaeyama1\Grid\Yaeyama1_grd_v10.nc';
    out_dirstr = 'output/figs_png_Y1_srf';
    
    LevelList = [-1 1 10];

    Nz=15; % Surface
    % Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
   UTM_zone = '51 R';          % UTM zone, e.g. '30 T', '32 T', '11 S', '28 R', '15 S', '51 R'


    spherical=1;

elseif CASE == 5  % Yaeyama2
    grd = 'D:/COAWST_DATA/Yaeyama/Yaeyama2/Grid/Yaeyama2_grd_v11.2.nc';
    flt='D:\cygwin64\home\Takashi\COAWST\Projects\Yaeyama2_3_201004-_offline\Yaeyama2_flt_20110525.nc';
% flt='E:\COAWTS_OUTPUT\Yaeyama2_float\Yaeyama2_flt_20110525.nc';
    out_dirstr = 'output/figs_png_Y2_btm';  % Bottom
    
    LevelList = [-1 1 10];
    
    % Nz=15; % Surface
    Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

elseif CASE == 6  % Yaeyama3
    grd="D:\COAWST_DATA\Yaeyama\Yaeyama3\Grid\Yaeyama3_grd_v12.2.nc";

    out_dirstr = 'output/figs_png_Y3_srf';
    % out_dirstr = 'output/figs_png_Y3_btm';
    
    LevelList = [-1 1 10];
    
    Nz=15; % Surface
    % Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon'; 
    
elseif CASE == 7  % SHIRAHO_REEF
    % grd="D:\COAWST_DATA\Yaeyama\Shiraho_reef2\Grid\shiraho_roms_grd_HYCOM_v17.0.nc";
    grd="D:\COAWST_DATA\Yaeyama\Shiraho_reef2\Grid\shiraho_roms_grd_JCOPET_v18.1.nc";

    out_dirstr = 'output/figs_png_SR_nosg_v5';  % Surface
    % out_dirstr = 'output/figs_png_SR_bstrcwmax_201101_v2';  % Surface
    
    LevelList = [-1 0.2 0.5 3];
    
    % Nz=8; % Surface
    Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

%==================== Panay ==============================================
elseif CASE == 8      % Panay0
    grd='D:\COAWST_DATA\Panay\Panay0\Grid\Panay0_grd_v1.0.nc';
    his=["E:\COAWST_OUTPUT\Panay\Panay0\roms\Panay0_sed_his_20230102.nc"];
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Panay\Panay0\roms\Panay0_sed_qck_20230102.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["E:\COAWST_OUTPUT\Panay\Panay0\roms\Panay0_sed_dia_20230102.nc"];

    out_dirstr = 'output/figs_png_PNY0srf_2023';
    
    LevelList = [-10 0 250 500 750 1000 1250 1500 1750 2000];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 

    scale=10;
    s_interval=4;

    x_arrow_txt = 165; y_arrow_txt=85;
    I_arrow_legend = 31; J_arrow_legend=10;
    v_legend = 1;

elseif CASE == 9  % Panay1
    grd='D:/COAWST_DATA/Panay/Panay1/Grid/Panay1_grd_v1.4.nc';

    out_dirstr = 'output/figs_png_PNY1srf_2023';
    
    LevelList = [-5 5 10 100 200 300 400 500 600 700 800 900 1000];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
  
elseif CASE == 10  % Tangalan
    grd='D:/COAWST_DATA/Panay/Tangalan/Grid/Tangalan_grd_v2.1.nc';

    out_dirstr = 'output/figs_png_TGLsrf_2023';
    
    LevelList = [-5 0 1 3 5 10 100 200 300 400 500 600 700 800 900 1000];
    
    Nz=15; % Surface
    % Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

%==================== TokyoBay ==============================================
elseif CASE == 11  % TokyoBay1
    grd='D:\COAWST_DATA\Shizugawa\Shizugawa3\Grid\Shizugawa3_grd_v0.3b.nc';
    out_dirstr = 'output/figs_png_SZ3aqdrag_btm';
    
    LevelList = [-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130];
    
    % Nz=15; % Surface
    Nz=1; % Bottom (Sediment: surface layer)
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

elseif CASE == 12  % TokyoBay2
    grd='D:\COAWST_DATA\Shizugawa\Shizugawa3\Grid\Shizugawa3_grd_v0.3b.nc';
    out_dirstr = 'output/figs_png_SZ3aqdrag_btm';
    
    LevelList = [-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130];
    
    % Nz=15; % Surface
    Nz=1; % Bottom (Sediment: surface layer)
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

elseif CASE == 13  % TokyoBay3
    grd='D:/COAWST_DATA/TokyoBay/tky3/TDA/present_set/grd/TokyoBay3_grd_v3.2.nc';

    % out_dirstr = 'output/figs_png_TB3_sed1';
    out_dirstr = 'output/figs_png_TB3_sed2';
    
    LevelList = [-1 1 10 20 50 100 500 1000 5000];
    
    % Nz=30; % Surface
    Nz=1; % Bottom (Sediment: surface layer)
    % unit = 'km'; 
%          'm', 'latlon'
    unit = 'latlon';

%==================== Palau ==============================================
elseif CASE == 15  % Palau2
    grd='D:/COAWST_DATA/Palau/Palau2/Grid/Palau2_grd_v1.1.nc';
    % flt='E:/COAWST_OUTPUT/Palau/Palau2_flt_offline/P2_flt_20240106.nc';
    % flt='\\wsl.localhost\ubuntu-24.04\home\nakamulab2\COAWST\ROMSPath\SHOWNESTING_NOMIX.nc'; %LTRANS/ROMSPath float
    % flt='../ROMSPath/P2_ROMSPath_flt.nc'; %LTRANS/ROMSPath float

% [memo] Due to the HDF library issue, nc file by ROMSPath should be
% converted to a classic netcdf fil as follows:
% $nccopy -k classic P2_ROMSPath_flt.nc P2_ROMSPath_flt_v2.nc

    flt='../ROMSPath/P2_ROMSPath_flt_srf_HTurb1.0_v2.nc'; %LTRANS/ROMSPath float

    out_dirstr = 'output/figs_png_Palau2_flt_ROMSPath';
    
    LevelList = [-1 5 50];
    
    % Nz=30; % Surface
    Nz=1; % Bottom (Sediment: surface layer)
    unit = 'km'; 
%          'm', 'latlon'
    % unit = 'latlon';
    spherical=1;

%==================== Kushimoto ==============================================
elseif CASE == 18  % Kushimoto
    grd='D:/COAWST_DATA/Kushimoto/Grid/Kushimoto_grd_v0.1.nc';

% [memo] Due to the HDF library issue, nc file by ROMSPath should be
% converted to a classic netcdf fil as follows:
% $nccopy -k classic P2_ROMSPath_flt.nc P2_ROMSPath_flt_v2.nc

    flt='F:/COAWST_OUTPUT/Kushimoto/Kushimoto_ROMSPath_flt_srf_HTurb1.0_20100621_v3.nc'; %LTRANS/ROMSPath float

    out_dirstr = 'output/figs_png_Kushimoto_flt_v2';
    
    % LevelList = [-1 10 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000];
    LevelList = [-1 5];
    
    Nz=15; % Surface
    % Nz=1; % Bottom (Sediment: surface layer)
    unit = 'km'; 
%          'm', 'latlon'
    % unit = 'latlon';
    spherical=1;

    wplgn_file = 'F:\Dropbox\Projects\Kushimoto\GIS\density_counting_area\west2.shp';
    eplgn_file = 'F:\Dropbox\Projects\Kushimoto\GIS\density_counting_area\east2.shp';
    Sw = shaperead(wplgn_file);
    N_wpt = size(Sw.X,2);
    X_wplgn = Sw.X(1:N_wpt-1);
    Y_wplgn = Sw.Y(1:N_wpt-1);
    Se = shaperead(eplgn_file);
    N_ept = size(Se.X,2);
    X_eplgn = Se.X(1:N_ept-1);
    Y_eplgn = Se.Y(1:N_ept-1);

    fid=fopen('inpolygon.csv','w');   

%==========================================================================
end
%==========================================================================

LOCAL_TIME=' (UTC)';
%LOCAL_TIME=' (JST)';
% LOCAL_TIME=' (UTC+9)';
% ref_date = ref_date + 9/24;
%LOCAL_TIME='';

[status, msg] = mkdir( out_dirstr )



% plgn='C:\Users\Takashi\Dropbox\collaboration\Nanami\Sekisei_area_polygon.shp';

%% 

% LevelList = [-1 1 10];
% LevelList = [-1 0.2 0.5 3];
unit = 'km'; 

h          = ncread(grd,'h');
% p_coral    = ncread(grd,'p_coral');
%p_seagrass = ncread(grd,'p_seagrass');
%lat_rho    = ncread(grd,'lat_rho');
%lon_rho    = ncread(grd,'lon_rho');
x_rho      = ncread(grd,'x_rho');
y_rho      = ncread(grd,'y_rho');

[Im,Jm] = size(h);
x_corner_m = min(min(x_rho));
y_corner_m = min(min(y_rho));

%c(1:Im,1:Jm)=0;
if strcmp(unit,'latlon')
    y_rho    = ncread(grd,'lat_rho');
    x_rho    = ncread(grd,'lon_rho');
elseif strcmp(unit,'m')
    x_rho      = ncread(grd,'x_rho');
    y_rho      = ncread(grd,'y_rho');
elseif strcmp(unit,'km')
    x_rho      = ncread(grd,'x_rho');
    y_rho      = ncread(grd,'y_rho');
    x_rho=(x_rho-min(min(x_rho)))/1000; % m->km
    y_rho=(y_rho-min(min(y_rho)))/1000; % m->km

    X_wplgn = (X_wplgn- x_corner_m)/1000; % m->km;
    Y_wplgn = (Y_wplgn- y_corner_m)/1000; % m->km;
    X_eplgn = (X_eplgn- x_corner_m)/1000; % m->km;
    Y_eplgn = (Y_eplgn- y_corner_m)/1000; % m->km;
end

k=0;
i=1;

if CASE == 1      % Shizugawa1
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xsize=490; ysize=520;
elseif CASE == 2  % Shizugawa2
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=10;   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=84;
    xsize=360; ysize=620;
elseif CASE == 3  % Shizugawa3
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=0.7;   xmax=11.5;  ymin=1.5;   ymax=11;
    xsize=620; ysize=500;
elseif CASE == 4      % YAEYAMA1
    xmin=min(min(x_rho))-1;   xmax=max(max(x_rho))+1;  ymin=min(min(y_rho))-1;   ymax=max(max(y_rho))+1;
    xsize=640; ysize=520;
elseif CASE == 5  % YAEYAMA2
    xmin=min(min(x_rho))-0.3;   xmax=max(max(x_rho))+0.3;  ymin=min(min(y_rho))-0.3;   ymax=max(max(y_rho))+0.3;
    xsize=620; ysize=550;
elseif CASE == 6  % YAEYAMA3
    xmin=min(min(x_rho))-0.1;   xmax=max(max(x_rho))+0.1;  ymin=min(min(y_rho))-0.1;   ymax=max(max(y_rho))+0.1;
    xsize=640; ysize=520;
elseif CASE == 7  % SHIRAHO_REEF
    xmin=min(min(x_rho))-0.05;   xmax=max(max(x_rho))+0.05;  ymin=min(min(y_rho))-0.05;   ymax=max(max(y_rho))+0.05;
%     xsize=500; ysize=650; % for SHIRAHO zoom
%     xsize=250; ysize=500; % for SHIRAHO for Publish
    xsize=280; ysize=550; % for SHIRAHO for Animation
elseif CASE == 8      % Panay0
    % xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=24.5;   ymax=max(max(y_rho));
    xsize=620; ysize=500;
elseif CASE == 9  % Panay1
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=15;   ymax=max(max(y_rho));
    xsize=620; ysize=450;
elseif CASE == 10  % Tangalan
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=2;   ymax=max(max(y_rho));
    xsize=620; ysize=490;
elseif CASE == 12  % TokyoBay2
    xmin=139.05;   xmax=140.15;  ymin=34.92;   ymax=35.7;
    xsize=780; ysize=500;
elseif CASE == 13  % TokyoBay3
    xmin=139.6;   xmax=140.13;  ymin=35.13;   ymax=35.7;
    xsize=550; ysize=650;
elseif CASE == 15  % Palau2
    % xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=80;   xmax=140;  ymin=50;   ymax=150;
    % xmin=90;   xmax=100;  ymin=60;   ymax=70;
    xsize=550; ysize=750;   
elseif CASE == 18  % Kushimoto
    % xmin=min(min(x_rho))+0.3;   xmax=max(max(x_rho))-0.3;  ymin=min(min(y_rho))+0.3;   ymax=max(max(y_rho))-0.3;
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xsize=780; ysize=520;   
else
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xsize=520; ysize=520;   
end

% Polygon
% X_pgon = (X_pgon- x_corner_m)/1000; % m->km;
% Y_pgon = (Y_pgon- y_corner_m)/1000; % m->km;
% pgon = polyshape(X_pgon, Y_pgon);
%% 

close all
clear xfloat yfloat lonfloat latfloat

%time = nc_varget(his,'ocean_time',[i],[1]);
% time = ncread(flt,'ocean_time'); % For ROMS float 
time = ncread(flt,'model_time'); % For ROMSPath
imax=length(time);

%---------------------------------------------------------------------
%  Read in floats data. 
%---------------------------------------------------------------------

% spherical=ncread(his,'spherical');
if (spherical)
    lonfloat=ncread(flt,'lon',[1 1],[Inf 1]);
    latfloat=ncread(flt,'lat',[1 1],[Inf 1]);
    [xfloat0(:), yfloat0(:), UTM_zone] = deg2utm(latfloat(:),lonfloat(:));

    xfloat0=(xfloat0 - x_corner_m)/1000; % m->km
    yfloat0=(yfloat0 - y_corner_m)/1000; % m->km
else  
    xfloat0=ncread(flt,'x',[1 1],[Inf 1]).*0.001;
    yfloat0=ncread(flt,'y',[1 1],[Inf 1]).*0.001;

end
sfloat=ncread(flt,'status',[1 2],[Inf 1]);
xfloat= xfloat0; %(sfloat==1);
yfloat= yfloat0; %(sfloat==1);
% xfloat= xfloat0(sfloat==1);
% yfloat= yfloat0(sfloat==1);


num_float=size(xfloat,2);
ifloat = 1:num_float;
%% 
NumColor = 256; 
% NumColor = 11 % for Palau case

% My color map
load('MyColormaps')
colormap6=superjet(NumColor,'uvbZctjgorW');
colormap7=superjet(NumColor,'vbZctgyorW');
colormap8=superjet(NumColor,'bZctgyorW');


date=ref_date+time(i+1)/24/60/60;
date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

if id == 1
    % [h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat,yfloat,ifloat,h,date_str,'',1,num_float,flipud(jet(NumColor)),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    [h_scatter,h_contour,h_annot]=createfltplot5(x_rho,y_rho,xfloat,yfloat,ifloat,h,date_str,'',1,num_float,flipud(colormap7),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList,4);
elseif id == 2
    % dfloat0=ncread(flt,'depth',[1 1],[Inf 1]).*-1;
    % dfloat0=ncread(flt,'zp',[1 1],[Inf 1]).*-1;
    dfloat=zeros(size(xfloat,2),1);
%     [h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat(:,i),yfloat(:,i),dfloat(:,i),h,date_str,'Larvae',-1,40,flipud(winter(256)),xsize,ysize,xmin,xmax,ymin,ymax);
    [h_scatter,h_contour,h_annot]=createfltplot5(x_rho,y_rho,xfloat(:),yfloat(:),dfloat(:),h,date_str,'Larvae (depth/m)',-2,2,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList,4);
elseif id == 3
    tempfloat=ncread(flt,'temp');
    [h_scatter,h_contour,h_annot]=createfltplot5(x_rho,y_rho,xfloat(:,i),yfloat(:,i),tempfloat(:,i),h,date_str,'Larvae (temperature)',22,29,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList,4);
elseif id == 4
    saltfloat=ncread(flt,'salt');
    [h_scatter,h_contour,h_annot]=createfltplot5(x_rho,y_rho,xfloat(:,i),yfloat(:,i),saltfloat(:,i),h,date_str,'Larvae (salinity)',30,36,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList,2);
elseif id == 5
    phy1float=ncread(flt,'phytoplankton');
    [h_scatter,h_contour,h_annot]=createfltplot5(x_rho,y_rho,xfloat(:,i),yfloat(:,i),phy1float(:,i),h,date_str,'Larvae (phytoplankton)',0.2,0.4,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 10
    ifloat=zeros(size(xfloat,2),1);
    [h_scatter,h_contour,h_annot]=createfltplot5(x_rho,y_rho,xfloat,yfloat,ifloat,h,date_str,'Particle density (particles km^-^2)',0,2e3,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList,2);
end
% plot(pgon,'FaceColor','b','FaceAlpha',0.05);
drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]%[0 0 290 620]

%for i=3:3:imax-1%336 %imax-1  %i=1:imax-1
% for i=2527:1:imax%336 %imax-1  %i=1:imax-1
for i=1:1:imax%336 %imax-1  %i=1:imax-1

    date=ref_date+time(i)/24/60/60;

    if date >= min_date && date <= max_date
    
        if (spherical)
            lonfloat=ncread(flt,'lon',[1 i],[Inf 1]);
            latfloat=ncread(flt,'lat',[1 i],[Inf 1]);
            [xfloat0(:), yfloat0(:), UTM_zone] = deg2utm(latfloat(:),lonfloat(:));
            
            xfloat0=(xfloat0 - x_corner_m)/1000; % m->km
            yfloat0=(yfloat0 - y_corner_m)/1000; % m->km
        else  
            xfloat0=ncread(flt,'x',[1 i],[Inf 1]).*0.001;
            yfloat0=ncread(flt,'y',[1 i],[Inf 1]).*0.001;
    
        end
        sfloat=ncread(flt,'status',[1 i],[Inf 1]);
        xfloat= xfloat0(sfloat==1);
        yfloat= yfloat0(sfloat==1);

        % in = inpolygon(xfloat, yfloat, X_pgon, Y_pgon);
        % num_inpgn = sum(in);
        
        date=ref_date+time(i)/24/60/60;
        date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);
        
        if id == 1
            ifloat = find(sfloat==1);
            set(h_scatter,'XData',xfloat(:),'YData',yfloat(:),'CData',ifloat)
        elseif id == 2
            % dfloat0=ncread(flt,'depth',[1 i],[Inf 1]).*-1;
            dfloat0=ncread(flt,'zp',[1 i],[Inf 1]).*-1;
            dfloat=dfloat0(sfloat==1);
            set(h_scatter,'XData',xfloat(:),'YData',yfloat(:),'CData',dfloat(:))
        elseif id == 3
            set(h_scatter,'XData',xfloat(:,i),'YData',yfloat(:,i),'CData',tempfloat(:,i))
        elseif id == 4
            set(h_scatter,'XData',xfloat(:,i),'YData',yfloat(:,i),'CData',saltfloat(:,i))
        elseif id == 5
            set(h_scatter,'XData',xfloat(:,i),'YData',yfloat(:,i),'CData',phy1float(:,i))
        elseif id == 10
            dist=1.0; % (km); Cell size for counting particle density
            dens = point_density( xfloat, yfloat, dist, dist );
            set(h_scatter,'XData',xfloat(:),'YData',yfloat(:),'CData',dens(:))
        end
        
        set(h_annot,'String',date_str)
        drawnow
        fname = strcat( 'flt', datestr(date,'_yyyymmddHHMM') );
        % exportgraphics(figure(1), strcat(out_dirstr,'/', fname,'.png'));


        ine = inpolygon(xfloat, yfloat, X_eplgn, Y_eplgn);
        num_ineplgn = sum(ine);
        inw = inpolygon(xfloat, yfloat, X_wplgn, Y_wplgn);
        num_inwplgn = sum(inw);
        fprintf(fid,'%s, %d, %d\r\n',datestr(date,'yyyy/mm/dd HH:MM'),num_ineplgn,num_inwplgn);   
    
    end
end



