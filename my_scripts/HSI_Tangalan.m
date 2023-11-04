% === Copyright (c) 2023 Takashi NAKAMURA  =====
clear all
close all

CASE = 2;
out_dirstr = 'output/figs_Tangalan_DHW';
% out_dirstr = 'output/figs_Tangalan_DHW_zoom';
fname_prefix1='Tangalan_SI_A_';
fname_prefix2='Tangalan_SI_B_';
fname_prefix3='Tangalan_SI_C_';
fname_prefix4='Tangalan_SI_D_';
fname_prefix5='Tangalan_SI_E_';
fname_prefix6='Tangalan_HSI_';
fname_prefix7='Tangalan_HSI2_';

[status, msg] = mkdir( out_dirstr )
fileID = fopen([out_dirstr,'/Tangalan_DHW.txt'],'w');

% Panay1
% grd='F:/COAWST_DATA/Panay/Panay1/Grid/Panay1_grd_v1.4.nc';
% his=["E:/COAWTS_OUTPUT/Panay/Panay1/Panay1_sed_wav_his_20210105.nc"];
%    
% LevelList = [-5 5 10 100 200 300 400 500 600 700 800 900 1000];

 % Tangalan
grd='F:/COAWST_DATA/Panay/Tangalan/Grid/Tangalan_grd_v2.1.nc';
his=["E:/COAWTS_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20210107.nc"
     "E:/COAWTS_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20211010.nc"];

LevelList = [-5 0 1 3 5 10 100 200 300 400 500 600 700 800 900 1000];
    

unit = 'km'; % 'm', 'latlon'
% ---------------------------

h = ncread(grd, 'h');
rmask = ncread(grd, 'mask_rho');
umask = ncread(grd,'mask_u');
vmask = ncread(grd,'mask_v');



scale=2;
s_interval=3;
Vmax = 0.6;

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

[Im, Jm] = size(h);
c(1:Im,1:Jm)=0;

% Nz=15;  % Surface
Nz=1;  % Bottom
% Nz=13;  % Surface + 2 layer
umask = umask ./umask;
vmask = vmask ./vmask;
rmask = rmask ./rmask;

starting_date = datenum(2000,1,1,0,0,0);



% Down sampling
x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
% ubar3=ubar2(1:s_interval:Im,1:s_interval:Jm);
% vbar3=vbar2(1:s_interval:Im,1:s_interval:Jm);
ubar3=zeros(size(x_rho2));
vbar3=zeros(size(x_rho2));
date_str=''; %strcat(datestr(date,31),'  ',LOCAL_TIME);

% Panay1 setting
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=1;   ymax=max(max(y_rho));
% xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=15;   ymax=max(max(y_rho));
% xsize=620; ysize=450;

% Tangalan setting
xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=2;   ymax=max(max(y_rho));
% xmin=3.8;   xmax=11.2;  ymin=3.8;   ymax=11.2; % Zoom
xsize=620; ysize=490;


load('tangalan_results1.mat')
load('tangalan_results2.mat')

% SI_A_Vwav_ave=zeros(size(Vwav_ave));
yyyy=2021;

[SI_A_Vwav_ave] = SI_A(Vwav_ave);
[SI_B_Vwav_max2] = SI_B(Vwav_max2);
[SI_C_vel_ave3] = SI_C(vel_ave3);
[SI_D_vel_ave] = SI_D(vel_ave);
[SI_E_PFD_ave] = SI_E(PFD_ave);

HSI = sqrt((SI_A_Vwav_ave.*SI_A_Vwav_ave + SI_C_vel_ave3.*SI_C_vel_ave3)/2) ...
      .* SI_B_Vwav_max2 .* SI_D_vel_ave .* SI_E_PFD_ave;

% My color map
load('MyColormaps')
colmap6=superjet(20,'wcZbtgyorWq');

title=['SI_A in ', num2str(yyyy)];  cmin=0; cmax=1; colmap=colmap6;
[h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,SI_A_Vwav_ave,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
drawnow
fname = [fname_prefix1, num2str(yyyy) ];
hgexport(figure(1), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

title=['SI_B in ', num2str(yyyy)];  cmin=0; cmax=1; colmap=colmap6;
[h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,SI_B_Vwav_max2,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
drawnow
fname = [fname_prefix2, num2str(yyyy) ];
hgexport(figure(2), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

title=['SI_C in ', num2str(yyyy)];  cmin=0; cmax=1; colmap=colmap6;
[h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,SI_C_vel_ave3,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
drawnow
fname = [fname_prefix3, num2str(yyyy) ];
hgexport(figure(3), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

title=['SI_D in ', num2str(yyyy)];  cmin=0; cmax=1; colmap=colmap6;
[h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho, SI_D_vel_ave ,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
drawnow
fname = [fname_prefix4, num2str(yyyy) ];
hgexport(figure(4), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

title=['SI_E in ', num2str(yyyy)];  cmin=0; cmax=1; colmap=colmap6;
[h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho, SI_E_PFD_ave ,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
drawnow
fname = [fname_prefix5, num2str(yyyy) ];
hgexport(figure(5), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

title=['HSI in ', num2str(yyyy)];  cmin=0; cmax=1; colmap=colmap6;
[h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho, HSI ,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
drawnow
fname = [fname_prefix6, num2str(yyyy) ];
hgexport(figure(6), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

title=['HSI in ', num2str(yyyy)];  cmin=0; cmax=0.5; colmap=colmap6;
[h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho, HSI ,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
drawnow
fname = [fname_prefix7, num2str(yyyy) ];
hgexport(figure(7), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');



%==========================================================================
function [SI] = SI_A(v)
    SI=zeros(size(v));
    SI(v<=0.6) = 1/0.6*v(v<=0.6);
    SI(0.6<v & v<=0.8) = 1.0;
    SI(0.8<v & v<=1.1) = -1/(1.1-0.85)*(v(0.8<v & v<=1.1)-1.1);
    SI(0.8<v) = 0;
% 
%     if(v<=0.6)
%         SI = 1/0.6*v;
%     elseif(0.6<v && v<=0.8)
%         SI = 1.0;
%     elseif(0.8<v && v<1.1)
%         SI = -1/(1.1-0.85)*(v-1.1);
%     else
%         SI = 0;
%     end
end
%--------------------------------------------------------------------------
function [SI] = SI_B(v)
    SI=zeros(size(v));
    SI(v<=3.8) = 1.0;
    SI(3.8<v & v<=5.4) = 1/(5.4-3.8)*(v(3.8<v & v<=5.4)-5.4);
    SI(5.4<v) = 0;
% 
%     if(v<=3.8)
%         SI = 1.0;
%     elseif(3.8<v && v<=5.4)
%         SI = 1/(5.4-3.8)*(v-5.4);
%     else
%         SI = 0;
%     end
end
%--------------------------------------------------------------------------
function [SI] = SI_C(v)
    v=100*v;
    SI=zeros(size(v));
    SI(v<=5) = 0.0;
    SI(5<v & v<=12) = 1/(12-5)*(v(5<v & v<=12)-5);
    SI(12<v & v<=20) = 1.0;
    SI(20<v & v<=40) = -1/(40-20)*(v(20<v & v<=40)-40);
    SI(40<v) = 0;
%     if(v<=5)
%         SI = 0.0;
%     elseif(5<v && v<=12)
%         SI = 1/(12-5)*(v-5);
%     elseif(12<v && v<=20)
%         SI = 1.0;
%     elseif(20<v && v<=40)
%         SI = -1/(40-20)*(v-40);
%     else
%         SI = 0;
%     end
end
%--------------------------------------------------------------------------
function [SI] = SI_D(v)
    v=100*v;
    SI=zeros(size(v));
    SI(v<=6) = 1/6*v(v<=6);
    SI(6<v) = 1;
% 
%     if(v<=6)
%         SI = 1/6*v;
%     else
%         SI = 1;
%     end
end
%--------------------------------------------------------------------------
function [SI] = SI_E(v)
    SI=zeros(size(v));
    SI(v<=110) = 1/110*v(v<=110);
    SI(110<v & v<=1000) = 1;
    SI(1000<v & v<=2000) = -1/(2000-1000)*(v(1000<v & v<=2000)-2000);
    SI(2000<v) = 0;
% 
%     if(v<=110)
%         SI = 1/110*v;
%     elseif(110<v && v<=1000)
%         SI = 1.0;
%     elseif(1000<v && v<=2000)
%         SI = -1/(2000-1000)*(v-2000);
%     else
%         SI = 0;
%     end
end
