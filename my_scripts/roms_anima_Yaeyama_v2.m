%
% === Copyright (c) 2014-2021 Takashi NAKAMURA  =====
%
% CASE 1=> YAEYAMA1; 2=> YAEYAMA2; 3=> YAEYAMA3
CASE = 4;

% F_drawUV = true;
F_drawUV = false;
id = 7;  % <- Select 1,2,3,100

if CASE == 1      % YAEYAMA1
    grd='F:\COAWST_DATA\Yaeyama\Yaeyama1\Grid\Yaeyama1_grd_v10.nc';
    his=["H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_19940102.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_19950101.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_19960102.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_19970102.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_19980103.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_19990104.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20000104.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20010102.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20011231.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20021231.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20031221.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20040104.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20050104.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20060105.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20060302.nc"
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20070106.nc"      %<-Yaeyama1_his_20060302_00008.nc
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20080107.nc"      %<-Yaeyama1_his_20060302_00009.nc
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20080222.nc"      %<-Yaeyama1_his_20080222_00009.nc
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20090107.nc"      %<-Yaeyama1_his_20080222_00010.nc
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20100108.nc"      %<-Yaeyama1_his_20080222_00011.nc
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20110109.nc"      %<-Yaeyama1_his_20080222_00012.nc
         "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20120110.nc"      %<-Yaeyama1_his_20080222_00013.nc
         "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20130110.nc"      %<-Yaeyama1_his_20080222_00014.nc
         "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20140111.nc"      %<-Yaeyama1_his_20080222_00015.nc
         "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20150112.nc"      %<-Yaeyama1_his_20080222_00016.nc
         "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20160113.nc"      %<-Yaeyama1_his_20080222_00017.nc
         "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20170113.nc"      %<-Yaeyama1_his_20170113_00018.nc
         "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20180114.nc"      %<-Yaeyama1_his_20170113_00019.nc
         "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20180606.nc"      %<-Yaeyama1_his_20180606_00019.nc
         "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20190115.nc"  ];  %<-Yaeyama1_his_20180606_00020.nc
    out_dirstr = 'output/figs_png_Y1srf2';
    
    LevelList = [-1 1 10];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
    
elseif CASE == 2  % YAEYAMA2
    grd='/gs/hs1/tga-NakamuLab/COAWST/Data/Yaeyama/Yaeyama2/Grid/Yaeyama2_grd_v11.2.nc';
    his=["/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_19940110.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_19950110.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_19960110.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_19960731.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_19960802.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_19970801.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_19980801.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_19990801.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20000801.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20010731.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20020731.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20030731.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20040731.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20040823.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20040826.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20050718.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20060718.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20060915.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20060919.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20070917.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20070919.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20071003.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20071005.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20071008.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20080912.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20080914.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20090913.nc"
         "/gs/hs1/tga-NakamuLab/nakamura/Yaeyama_LongTerm/Yaeyama2/Yaeyama2_his_20100402.nc"  ];
%     out_dirstr = 'output/figs_png_Y2Ctrace';  % Surface
    out_dirstr = 'output/figs_png_Y2btm';  % Bottom
    
    LevelList = [-1 1 10];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

    
elseif CASE == 3  % YAEYAMA3
    grd='F:\COAWST_DATA\Yaeyama\Yaeyama3\Grid\Yaeyama3_grd_v12.2.nc';
    his='H:\COAWST_OUTPUT\Yaeyama3\Yaeyama3_his_19990104.nc';
    out_dirstr = 'output/figs_png_Y3';
    
    LevelList = [-1 1 10];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
   
    
elseif CASE == 4  % SHIRAHO_REEF
    grd='F:/COAWST_DATA/Yaeyama/Shiraho_reef2/Grid/shiraho_reef_grid16.3.nc';
    his=["D:/cygwin64/home/Takashi/COAWST/Projects/Shiraho_reef2/shiraho_eco_his_201904.nc"
         "D:/cygwin64/home/Takashi/COAWST/Projects/Shiraho_reef2/shiraho_eco_his_201904.nc"];
    out_dirstr = 'output/figs_png_SH';
    
    LevelList = [-1 0.2 0.5 3];

    Nz=8; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

end

[status, msg] = mkdir( out_dirstr )

LOCAL_TIME=' (UTC)';
%LOCAL_TIME=' (JST)';
%LOCAL_TIME=' (UTC+9)';
% LOCAL_TIME='';

wet_dry = 1;  % Dry mask OFF: 0, ON: 1

starting_date=datenum(2000,1,1,0,0,0); % 

% My color map
load('MyColormaps')
colormap6=superjet(128,'NuvibZctgyorWq');

% title='Sea surface temperature (^oC)'; cmin=16; cmax=34; colmap=colormap6; ncname='temp'; % YAEYAMA1
% title='Sea surface temperature (^oC)'; cmin=17; cmax=32; colmap=jet(128); ncname='temp'; % YAEYAMA1
% title='Sea surface temperature (^oC)'; cmin=16; cmax=34; colmap=colormap6; ncname='temp'; % YAEYAMA2 surface
% title='Sea bottom temperature (^oC)'; cmin=16; cmax=34; colmap=colormap6; ncname='temp'; % YAEYAMA2 bottom

% title='Salinity (psu)'; cmin=33; cmax=35; colmap=jet(128); ncname='salt';

% title='Coarse POC (umolC L^-^1)'; cmin=0; cmax=2; colmap=colmap1; ncname='POC_02';
% title='Coarse PO^1^3C (umolC L^-^1)'; cmin=0; cmax=2; colmap=colmap1; ncname='PO13C_02';

% title='Detritus (umolC L^-^1)';  cmin=0; cmax=5; colmap=jet(128); ncname='POC_01';
% title='^1^3C in Detritus (umolC L^-^1)'; cmin=0; cmax=0.0001; colmap=colmap1; ncname='PO13C_01';

% title='Labile DOC (umolC L^-^1)';  cmin=0; cmax=50; colmap=jet(128); ncname='DOC_01';
% title='Labile DO^1^3C (umolC L^-^1)'; cmin=0; cmax=0.0005; colmap=colmap1; ncname='DO13C_01';

% title='Refractory DOC (umolC L^-^1)';  cmin=40; cmax=70; colmap=jet(128); ncname='DOC_02';
% title='Refractory DO^1^3C (umolC L^-^1)'; cmin=0; cmax=0.00001; colmap=colmap1; ncname='DO13C_02';

% title='DIC (umol kg^-^1)'; cmin=1800; cmax=2000; colmap=jet(128); ncname='TIC';
% title='DI^1^3C (umol kg^-^1)'; cmin=0; cmax=0.0005; colmap=colmap1; ncname='TI13C';

% title='Dinoflagellate (umolC L^-^1)';  cmin=0; cmax=3; colmap=jet(128); ncname='phytoplankton_01';
% title='^1^3C in Dinoflagellate (umolC L^-^1)'; cmin=0; cmax=0.000001; colmap=colmap1; ncname='phyt13C_01';

% title='Diatom (umolC L^-^1)';  cmin=0; cmax=30; colmap=jet(128); ncname='phytoplankton_02';
% title='^1^3C in Diatom (umolC L^-^1)'; cmin=0; cmax=0.00001; colmap=colmap1; ncname='phyt13C_02';

% title='Coccolithophorids (umolC L^-^1)';  cmin=0; cmax=10; colmap=jet(128); ncname='phytoplankton_03';
% title='^1^3C in Coccolithophorids (umolC L^-^1)'; cmin=0; cmax=0.00001; colmap=colmap1; ncname='phyt13C_03';

% title='Particulate Inorganic C (umolC L^-^1)';  cmin=0; cmax=5; colmap=jet(128); ncname='PIC_01';
% title='Particulate Inorganic ^1^3C (umolC L^-^1)'; cmin=0; cmax=0.000001; colmap=colmap1; ncname='PI13C_01';

% title='Zooplankton (umolC L^-^1)';  cmin=0; cmax=10; colmap=jet(128); ncname='zooplankton_01';
% title='^1^3C in Zooplankton (umolC L^-^1)'; cmin=0; cmax=0.1; colmap=colmap1; ncname='zoop13C_01';

% title='SS \phi=5um (kg m^-^3)'; cmin=0; cmax=0.2; colmap=colmap1; ncname='mud_01';
% title='NO3 (umolN L^-^1)';  cmin=0; cmax=50; colmap=jet(128); ncname='NO3';
title='Phytoplankton (umolC L^-^1)';  cmin=0; cmax=0.5; colmap=jet(128); ncname='phytoplankton_02';

if id == 3
    scale=0.08;  % for Wave
    s_interval=4; % for SHIRAHO & YAEYAMA1 & YAEYAMA3
elseif id == 100
%     scale=1.5;  % for Wind
    scale=1;  % for Wind
    s_interval=6;  % for Wind
    Vmax = 20;  % for Wind
else
    if CASE ==1       % YAEYAMA1
        scale=8;
        s_interval=8;
        Vmax = 3;
    elseif CASE == 2  % YAEYAMA2
        scale=8;
        s_interval=8;
        Vmax = 3;
    elseif CASE == 3  % YAEYAMA3
        scale=8;
        s_interval=8;
        Vmax = 3;
    elseif CASE == 4  % SHIRAHO_REEF
        scale=2;
        s_interval=3;
        Vmax = 0.6;
    end
end


h          = ncread(grd,'h');
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
end

mask_u   = ncread(grd,'mask_u');
mask_v   = ncread(grd,'mask_v');
mask_rho   = ncread(grd,'mask_rho');

[Im, Jm] = size(h);

c(1:Im,1:Jm)=0;

k=0;
i=1;

if CASE == 1      % YAEYAMA1
    xmin=min(min(x_rho))-1;   xmax=max(max(x_rho))+1;  ymin=min(min(y_rho))-1;   ymax=max(max(y_rho))+1;
    xsize=640; ysize=520;
elseif CASE == 2  % YAEYAMA2
    xmin=min(min(x_rho))-0.3;   xmax=max(max(x_rho))+0.3;  ymin=min(min(y_rho))-0.3;   ymax=max(max(y_rho))+0.3;
    xsize=620; ysize=550;
elseif CASE == 3  % YAEYAMA3
    xmin=min(min(x_rho))-0.1;   xmax=max(max(x_rho))+0.1;  ymin=min(min(y_rho))-0.1;   ymax=max(max(y_rho))+0.1;
    xsize=640; ysize=520;
elseif CASE == 4  % SHIRAHO_REEF
    xmin=min(min(x_rho))-0.05;   xmax=max(max(x_rho))+0.05;  ymin=min(min(y_rho))-0.05;   ymax=max(max(y_rho))+0.05;
%     xsize=500; ysize=650; % for SHIRAHO zoom
%     xsize=250; ysize=500; % for SHIRAHO for Publish
    xsize=240; ysize=500; % for SHIRAHO for Animation
else
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xsize=520; ysize=520;   
end

% xmin=min(min(x_rho))-0.01;   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
% xmin=123.6;   xmax=max(max(x_rho));  ymin=23.95;   ymax=max(max(y_rho));

% xmin=116;   xmax=max(max(x_rho));  ymin=-6.5;   ymax=max(max(y_rho));  % for Berau1
% xsize=400; ysize=700; % for Berau1

close all
% clear ubar vber ubar2 vbar2 ubar3 vbar3

mask_u = mask_u ./mask_u;
mask_v = mask_v ./mask_v;
mask_rho = mask_rho ./mask_rho;



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

date=starting_date;
date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

if id==1 || id==2
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Velocity (m s^-^1)',0,Vmax,colmap4,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 3
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Hs (m)',0,1.5,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 4
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Temperature (^oC)',27,35,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 5
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Water elevation (m)',-1.5,2.5,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 6
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Salinity (psu)',31,35,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 7
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 100
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Wind velocity (m s^-^1)',0,Vmax,colmap4,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
end

drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]

% for ihis=1:size(his,1)
% for ihis=30:size(his,1)
for ihis=1:1

    time = ncread(his(ihis),'ocean_time');
    imax=length(time);
    
%     for i=1:1:imax
    for i=1:3:imax

        if id == 1
            ubar = ncread(his(ihis),'ubar',[1 1 i],[Inf Inf 1]);
            vbar = ncread(his(ihis),'vbar',[1 1 i],[Inf Inf 1]);
        elseif id == 2
            ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
            vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
        elseif id == 3
            dwave = ncread(his(ihis),'Dwave',[1 1 i],[Inf Inf 1]);
            tmp = ncread(his(ihis),'Hwave',[1 1 i],[Inf Inf 1]);
            ubar = cos(pi*dwave/180);
            vbar = sin(pi*dwave/180);
            if wet_dry == 1
                wetdry_mask_rho = ncread(his,'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
                wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
                tmp = tmp .* wetdry_mask_rho;
            end
        elseif id == 4
            ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
            vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
            tmp = ncread(his(ihis),'temp',[1 1 Nz i],[Inf Inf 1 1]);  % Surface
        elseif id == 5
            ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
            vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
            tmp = ncread(his(ihis),'zeta',[1 1 i],[Inf Inf 1]).*mask_rho;
        elseif id == 6
            ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
            vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
            tmp = ncread(his(ihis),'salt',[1 1 Nz i],[Inf Inf 1 1]);  % Surface
        elseif id == 7
            if F_drawUV
                ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
                vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
            end
            tmp = ncread(his(ihis),ncname,[1 1 Nz i],[Inf Inf 1 1]);
            if wet_dry == 1
                wetdry_mask_rho = ncread(his(ihis),'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
                wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
                tmp = tmp .* wetdry_mask_rho;
            end

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

        if id == 1 || id == 2
            ubar2(1:Im, 1:Jm)=NaN;
            ubar2(2:Im, 1:Jm)=ubar;%.*scale;
            vbar2(1:Im, 1:Jm)=NaN;
            vbar2(1:Im, 2:Jm)=vbar;%.*scale;
            tmp=hypot(ubar2,vbar2);
        elseif id == 3
            ubar2=ubar;
            vbar2=vbar;
            vel=hwave;
        elseif id == 100
            ubar2=ubar;
            vbar2=vbar;
            tmp=hypot(ubar2,vbar2);
        else
            if F_drawUV
                ubar2(1:Im, 1:Jm)=NaN;
                ubar2(2:Im, 1:Jm)=ubar;%.*scale;
                vbar2(1:Im, 1:Jm)=NaN;
                vbar2(1:Im, 2:Jm)=vbar;%.*scale;
            end
        end

        if F_drawUV
            % Down sampling
            ubar3=ubar2(1:s_interval:Im,1:s_interval:Jm);
            vbar3=vbar2(1:s_interval:Im,1:s_interval:Jm);
        end

        set(h_surf,'CData',tmp)
        if F_drawUV
            set(h_quiver,'UData',ubar3*scale)
            set(h_quiver,'VData',vbar3*scale)
        end
        set(h_annot,'String',date_str)

        drawnow

        fname = strcat( ncname, datestr(date,'_yyyymmddHHMM') );
        hgexport(figure(1), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');
    %     hgexport(figure(1), strcat('output/figs_eps/', fname,'.eps'),hgexport('factorystyle'),'Format','eps');

    end

end


