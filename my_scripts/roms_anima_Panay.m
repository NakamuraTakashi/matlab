%
% === Copyright (c) 2014-2023 Takashi NAKAMURA  =====
%
% CASE 1=> Panay0; 2=> Boracay2; 3=> Boracay3; 4=> Panay1; 5=> Tangalan
% CASE = 1;
% CASE = 4;
CASE = 5;

F_drawUV = true;
% F_drawUV = false;
% id = 7;  % <- 4D var
id = 3;  % <- Wave hight

if CASE == 1      % Panay0
    grd='F:\COAWST_DATA\Panay\Panay0\Grid\Panay0_grd_v1.0.nc';
    his=["E:\COAWTS_OUTPUT\Panay\Panay0\Panay0_sed_his_20210102.nc"];
    out_dirstr = 'output/figs_png_PNY0srf';
%     out_dirstr = 'output/figs_png_BCY1btm';
    
    LevelList = [-10 0 250 500 750 1000 1250 1500 1750 2000];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
    x_arrow_txt = 165; y_arrow_txt=85;
    I_arrow_legend = 31; J_arrow_legend=10;
    v_legend = 1;
    
elseif CASE == 2  % Boracay2
    grd='F:\COAWST_DATA\Boracay\Boracay2\Grid\Boracay2_grd_v1.0.nc';
    his=["E:\COAWTS_OUTPUT\Boracay2\Boracay2_his_20210105.nc"];
    out_dirstr = 'output/figs_png_BCY2srf';
%     out_dirstr = 'output/figs_png_BCY2btm';
    
    LevelList = [-10 0 1 3 5 10 100 200 300 400 500 600 700 800 900 1000];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
    x_arrow_txt = 23; y_arrow_txt=11;
    I_arrow_legend = 21; J_arrow_legend=8;
    v_legend = 1.0;


elseif CASE == 3  % Boracay3
    grd='F:\COAWST_DATA\Boracay\Boracay3\Grid\Boracay3_grd_v1.1.nc';
%     his=["E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210107.nc"
%          "E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210227.nc"
%          "E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210514.nc"];
%     his=["E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210808.nc"];
    his=["E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20211205.nc"];

%     out_dirstr = 'output/figs_png_BCY3srf';
    out_dirstr = 'output/figs_png_BCY3btm';
    
    LevelList = [-5 0 1 3 5 10 100 200 300 400 500 600 700 800 900 1000];
    
%     Nz=15; % Surface
    Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
    x_arrow_txt = 6.6; y_arrow_txt=8.6;
    I_arrow_legend = 20; J_arrow_legend=15;
    v_legend = 1.0;

elseif CASE == 4  % Panay1
    grd='F:/COAWST_DATA/Panay/Panay1/Grid/Panay1_grd_v1.4.nc';
%     his=["E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210107.nc"
%          "E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210227.nc"
%          "E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210514.nc"];
%     his=["E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210808.nc"];
    his=["E:/COAWTS_OUTPUT/Panay/Panay1/Panay1_sed_wav_his_20210105.nc"];

    out_dirstr = 'output/figs_png_PNY1srf';
%     out_dirstr = 'output/figs_png_PNY1btm';
    
    LevelList = [-5 5 10 100 200 300 400 500 600 700 800 900 1000];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
    x_arrow_txt = 30; y_arrow_txt=32;
    I_arrow_legend = 30; J_arrow_legend=1;
    v_legend = 1.0;   
    
elseif CASE == 5  % Tangalan
    grd='F:/COAWST_DATA/Panay/Tangalan/Grid/Tangalan_grd_v2.1.nc';

%     his=["E:/COAWTS_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20210107.nc"
%          "E:/COAWTS_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20211010.nc"];
    his=["E:/COAWTS_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20211010.nc"];

    out_dirstr = 'output/figs_png_TGLsrf';
%     out_dirstr = 'output/figs_png_TGLbtm';
    
    LevelList = [-5 0 1 3 5 10 100 200 300 400 500 600 700 800 900 1000];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
    x_arrow_txt = 3.7; y_arrow_txt=5.5;
    I_arrow_legend = 15; J_arrow_legend=5;
    v_legend = 1.0;   
    
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
colormap7=superjet(128,'xvbZctgyorWq');

% title='Sea surface temperature (^oC)'; cmin=0; cmax=30; colmap=colormap6; ncname='temp'; % YAEYAMA1
% title='Sea surface temperature (^oC)'; cmin=6; cmax=12; colmap=jet(128); ncname='temp'; % YAEYAMA1
% title='Sea surface temperature (^oC)'; cmin=23; cmax=34; colmap=colormap6; ncname='temp'; % Pany
% title='Sea bottom temperature (^oC)'; cmin=23; cmax=34; colmap=colormap6; ncname='temp'; % YAEYAMA2 bottom

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

% title='SS \phi=5um (kg m^-^3)'; cmin=0; cmax=0.1; colmap=colmap1; ncname='mud_01';
title='Suspended Solid (kg m^-^3)'; cmin=0; cmax=0.01; colmap=colmap1; ncname='mud_01';  % Panay setting
% title='Bottom Suspended Solid (kg m^-^3)'; cmin=0; cmax=0.01; colmap=colmap1; ncname='mud_01';  % Panay setting
% title='NO3 (umolN L^-^1)';  cmin=0; cmax=50; colmap=jet(128); ncname='NO3';
% title='Phytoplankton (umolC L^-^1)';  cmin=0; cmax=0.5; colmap=jet(128); ncname='phytoplankton_02';


if CASE ==1       % Panay0
    scale=10;
    s_interval=4;
elseif CASE == 2  % Boracay2
    scale=2;
    s_interval=4;
elseif CASE == 3  % Boracay3
    scale=1;
    s_interval=5;
elseif CASE == 4  % Panay1
    if id==3 %wave
        scale=1.5;
        s_interval=7;
    else
        scale=3;
        s_interval=5;
    end
elseif CASE == 5  % Tangalan
    if id==3 %wave
        scale=0.3;
        s_interval=7;
    else
        scale=0.7;
        s_interval=5;
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
agl   = ncread(grd,'angle');

[Im, Jm] = size(h);

c(1:Im,1:Jm)=0;
agl2 = agl(1:s_interval:Im,1:s_interval:Jm);

k=0;
i=1;

if CASE == 1      % Boracay1
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=24.5;   ymax=max(max(y_rho));
    xsize=620; ysize=500;
elseif CASE == 2  % Boracay2
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=3;   ymax=max(max(y_rho));
    xsize=620; ysize=500;
elseif CASE == 3  % Boracay3
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=1;   ymax=max(max(y_rho));
    xsize=620; ysize=500;
elseif CASE == 4  % Panay1
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=15;   ymax=max(max(y_rho));
    xsize=620; ysize=450;
elseif CASE == 5  % Tangalan
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=2;   ymax=max(max(y_rho));
    xsize=620; ysize=490;
else
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xsize=620; ysize=500;   
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
    ncname='Hs';
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Hs (m)',0,2.5,colormap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 4
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Temperature (^oC)',3,24,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 5
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Water elevation (m)',-1.5,2.5,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 6
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Salinity (psu)',31,35,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 7
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 100
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Wind velocity (m s^-^1)',0,Vmax,colmap4,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
end
% quiver(20,68,0.2*scale,0,0, ...
%     'Color', 'k',...
%     'AutoScale','off');
if F_drawUV
    if id==3
    else
        text(x_arrow_txt,y_arrow_txt,[num2str(v_legend), ' m s^-^1']);
    end
end

drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]

for ihis=1:size(his,1)
    time = ncread(his(ihis),'ocean_time');
    time_min(ihis)=min(time);
end

for ihis=1:size(his,1)
% for ihis=30:size(his,1)
% for ihis=1:1

    time = ncread(his(ihis),'ocean_time');
    if(ihis<size(his,1))
        imax = find(time<time_min(ihis+1), 1 , 'last');
    else
        imax=length(time);
    end
    
    for i=1:1:imax
%     for i=1:3:imax

        if id == 1
            ubar = ncread(his(ihis),'ubar',[1 1 i],[Inf Inf 1]);
            vbar = ncread(his(ihis),'vbar',[1 1 i],[Inf Inf 1]);
        elseif id == 2
            ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
            vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
        elseif id == 3
            dwave = ncread(his(ihis),'Dwave',[1 1 i],[Inf Inf 1]);
            tmp = ncread(his(ihis),'Hwave',[1 1 i],[Inf Inf 1]);
            ubar = cos(pi*dwave/180).*mask_rho;
            vbar = sin(pi*dwave/180).*mask_rho;
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
            vel=tmp;
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
            if id==3
                ubar4=ubar3;
                vbar4=vbar3;
            else
                ubar4=ubar3.*cos(agl2)-vbar3.*sin(agl2);
                vbar4=ubar3.*sin(agl2)+vbar3.*cos(agl2);
    
                ubar4(I_arrow_legend,J_arrow_legend)=v_legend;
                vbar4(I_arrow_legend,J_arrow_legend)=0;
            end
        end

        set(h_surf,'CData',tmp)
        if F_drawUV
            set(h_quiver,'UData',ubar4*scale)
            set(h_quiver,'VData',vbar4*scale)
        end
        set(h_annot,'String',date_str)

        drawnow

        fname = strcat( ncname, datestr(date,'_yyyymmddHHMM') );
        hgexport(figure(1), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');
    %     hgexport(figure(1), strcat('output/figs_eps/', fname,'.eps'),hgexport('factorystyle'),'Format','eps');

    end

end


