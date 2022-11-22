%
% === ver 2016/03/10   Copyright (c) 2014-2016 Takashi NAKAMURA  =====
%                for MATLAB R2015a,b  
% CASE 1=> YAEYAMA1; 2=> YAEYAMA2; 3=> YAEYAMA3
CASE = 3;

%% Settings

if CASE == 1      % YAEYAMA1
    grd='F:\COAWST_DATA\Yaeyama\Yaeyama1\Grid\Yaeyama1_grd_v10.nc';
    out_dirstr = 'output/figs_png_Y1srf2';
    
    cmin=-20; cmax=5000;
    xsize=640; ysize=520;
    
    LevelList = [-1 1 10];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
%     unit = 'km'; 
    unit = 'latlon';
    
elseif CASE == 2  % YAEYAMA2
    grd='F:\COAWST_DATA\Yaeyama\Yaeyama2\Grid\Yaeyama2_grd_v11.2.nc';
%     out_dirstr = 'output/figs_png_Y2Ctrace';  % Surface
    out_dirstr = 'output/figs_png_Y2btm';  % Bottom
    
    cmin=-12; cmax=2000;
    xsize=620; ysize=550;
    
    LevelList = [-1 1 10];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
%     unit = 'km'; 
     unit = 'latlon';

    
elseif CASE == 3  % YAEYAMA3
    grd='F:\COAWST_DATA\Yaeyama\Yaeyama3\Grid\Yaeyama3_grd_v12.2.nc';
    out_dirstr = 'output/figs_png_Y3';
    
    cmin=-2.5; cmax=600;
    xsize=640; ysize=520;
    
    LevelList = [-1 1 10];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 
%     unit = 'latlon';
   
    
elseif CASE == 4  % SHIRAHO_REEF
    grd='F:/COAWST_DATA/Yaeyama/Shiraho_reef2/Grid/shiraho_reef_grid16.3.nc';
    out_dirstr = 'output/figs_png_SH';
    
    LevelList = [-1 0.2 0.5 3];  cmin=-2.5; cmax=30;
%     xsize=500; ysize=650; % for SHIRAHO zoom
%     xsize=250; ysize=500; % for SHIRAHO for Publish
    xsize=240; ysize=500; % for SHIRAHO for Animation

    Nz=8; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 
%     unit = 'latlon';

end

%% 

starting_date=datenum(2000,1,1,0,0,0); % 


h          = ncread(grd,'h');
% p_coral    = ncread(grd,'p_coral');
% % p_coral2 = ncread(grd,'p_coral2');
% p_seagrass = ncread(grd,'p_seagrass');
% p_sand = ncread(grd,'p_sand');
% p_algae = ncread(grd,'p_algae');

if strcmp(unit,'latlon')
    y_rho = ncread(grd,'lat_rho');
    x_rho = ncread(grd,'lon_rho');
else

    x_rho = ncread(grd,'x_rho');
    y_rho = ncread(grd,'y_rho');

    x_corner_m = min(min(x_rho));
    y_corner_m = min(min(y_rho));
    x_rho=(x_rho - x_corner_m);
    y_rho=(y_rho - y_corner_m);

    if strcmp(unit,'km')
        x_rho=x_rho/1000;
        y_rho=y_rho/1000;
    end
end
xmin=min(min(x_rho));   xmax=max(max(x_rho));
ymin=min(min(y_rho));   ymax=max(max(y_rho));

mask_rho   = ncread(grd,'mask_rho');



% LOCAL_TIME='(UTC)';
% LOCAL_TIME='(JST)';
% LOCAL_TIME='(UTC+9)';
LOCAL_TIME='';

wet_dry = 1;  % Dry mask OFF: 0, ON: 1


[Im,Jm] = size(h);

c(1:Im,1:Jm)=0;

k=0;
i=1;


close all

% if id <100
% %time = ncread(his,'ocean_time',[i],[1]);
%     time = ncread(his,'ocean_time');
% else
%      time = ncread(his,'time');
% end

% imax=length(time);

% % coral masking
% coral_mask = (p_coral==0).*0+(p_coral>0).*1;
% coral_mask = coral_mask ./coral_mask;
% % coral2 masking
% coral2_mask = (p_coral2==0).*0+(p_coral2>0).*1;
% coral2_mask = coral2_mask ./coral2_mask;
% % seagrass masking
% sg_mask = (p_seagrass==0).*0+(p_seagrass>0).*1;
% sg_mask = sg_mask ./sg_mask;
% % algae masking
% ag_mask = (p_algae==0).*0+(p_algae>0).*1;
% ag_mask = ag_mask ./ag_mask;
% % sand masking
% sand_mask = (p_sand==0).*0+(p_sand>0).*1;
% sand_mask = sand_mask ./sand_mask;

mask_rho = mask_rho ./mask_rho;



% Down sampling
scale=8;
s_interval=8;
Vmax = 3;

x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
% ubar3=ubar2(1:s_interval:Im,1:s_interval:Jm);
% vbar3=vbar2(1:s_interval:Im,1:s_interval:Jm);
ubar3=zeros(size(x_rho2));
vbar3=zeros(size(x_rho2));


% if id <100
%     date=starting_date+time(i+1)/24/60/60;
% else
%     date=starting_date+time(i+1);
% end
% 
date_str=strcat(datestr(starting_date,31),'  ',LOCAL_TIME);

% My color map
load('MyColormaps')
colormap6=superjet(128,'NuvibZctgyorWq');
colormap7=superjet(128,'qhaoGUDylggtttZZZZbbbbiiiiiuuuuuuuuA');

% tmp = zeros(size(x_rho));
% tmp = ncread(his,'temp',[1 1 Nz i],[Inf Inf 1 1]);
% [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,h.*mask_rho,h, date_str,'Bathymetry',0,35,colmap2,xsize,ysize,xmin,xmax,ymin,ymax);

tmp=h.*mask_rho;
title='Bathymetry';
colmap=colormap7;
[h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% set(gca,'ColorScale','log')
drawnow
% hgexport(figure(1), 'output/figs_png\bathY3_2.png',hgexport('factorystyle'),'Format','png');
% hgexport(figure(1), 'output/figs_eps\bathY3_2.eps',hgexport('factorystyle'),'Format','eps');

% tmp = ncread(his,'temp',[1 1 Nz i],[Inf Inf 1 1]);
% [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho, p_coral.*coral_mask ,h,date_str,'Coral coverage',0,1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
% drawnow
% hgexport(figure(2), 'output/figs_png\coral_cov.png',hgexport('factorystyle'),'Format','png');
% hgexport(figure(2), 'output/figs_eps\coral_cov.eps',hgexport('factorystyle'),'Format','eps');

% [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho, p_coral2.*coral2_mask ,h,date_str,'Coral2 coverage',0,1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
% drawnow
% hgexport(figure(3), 'output/figs_png\coral2_cov.png',hgexport('factorystyle'),'Format','png');
% hgexport(figure(3), 'output/figs_eps\coral2_cov.eps',hgexport('factorystyle'),'Format','eps');

% [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,p_seagrass.*sg_mask,h,date_str,'Seagrass coverage',0,1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
% drawnow
% hgexport(figure(4), 'output/figs_png\seagrass_cov.png',hgexport('factorystyle'),'Format','png');
% hgexport(figure(4), 'output/figs_eps\seagrass_cov.eps',hgexport('factorystyle'),'Format','eps');

% [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,p_algae.*ag_mask,h,date_str,'Macroalgae coverage',0,1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
% drawnow
% hgexport(figure(5), 'output/figs_png\macroalgae_cov.png',hgexport('factorystyle'),'Format','png');
% hgexport(figure(5), 'output/figs_eps\macroalgae_cov.eps',hgexport('factorystyle'),'Format','eps');
% 
% [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,p_sand.*sand_mask,h,date_str,'Sand coverage',0,1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
% drawnow
% hgexport(figure(6), 'output/figs_png\sand_cov.png',hgexport('factorystyle'),'Format','png');
% hgexport(figure(6), 'output/figs_eps\sand_cov.eps',hgexport('factorystyle'),'Format','eps');
