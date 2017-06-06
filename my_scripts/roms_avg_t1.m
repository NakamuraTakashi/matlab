%
% === ver 2015/04/02   Copyright (c) 2014-2015 Takashi NAKAMURA  =====
%                for MATLAB R2015a  

grd='D:\ROMS\Data\Shiraho_reef\shiraho_reef_grid16.2.nc';
his1='D:\ROMS\output\Shiraho_reef\OAv12_ctrl\ocean_his_10.nc';

scenario=1;
%id = 15;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
id = 15;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if scenario == 1
    his2='D:\ROMS\output\Shiraho_reef\OAv12_ctrl\ocean_his_10.nc';
    str1='Present';
elseif scenario == 2
    his2='D:\ROMS\output\Shiraho_reef\OAv12_SL_RCP85\ocean_his_10.nc';
    str1='RCP 8.5 Sea Level';
elseif scenario == 3
    his2='D:\ROMS\output\Shiraho_reef\OAv12_pCO2_RCP85\ocean_his_10.nc';
    str1='RCP 8.5 pCO2';
elseif scenario == 4
    his2='D:\ROMS\output\Shiraho_reef\OAv12_pCO2_SL_RCP85\ocean_his_10.nc';
    str1='RCP 8.5 Sea Level + pCO2';
elseif scenario == 5
    his2='D:\ROMS\output\Shiraho_reef\OAv12_SL_RCP26\ocean_his_10.nc';
    str1='RCP 2.6 Sea Level';
elseif scenario == 6
    his2='D:\ROMS\output\Shiraho_reef\OAv12_pCO2_RCP26\ocean_his_10.nc';
    str1='RCP 2.6 pCO2';
elseif scenario == 7
    his2='D:\ROMS\output\Shiraho_reef\OAv12_pCO2_SL_RCP26\ocean_his_10.nc';
    str1='RCP 2.6 Sea Level + pCO2';
elseif scenario == 8
    his2='D:\ROMS\output\Shiraho_reef\OAv12_SL_RCP45\ocean_his_10.nc';
    str1='RCP 4.5 Sea Level';
elseif scenario == 9
    his2='D:\ROMS\output\Shiraho_reef\OAv12_pCO2_RCP45\ocean_his_10.nc';
    str1='RCP 4.5 pCO2';
elseif scenario == 10
    his2='D:\ROMS\output\Shiraho_reef\OAv12_pCO2_SL_RCP45\ocean_his_10.nc';
    str1='RCP 4.5 Sea Level + pCO2';
elseif scenario == 11
	his2='D:\ROMS\output\Shiraho_reef\OAv12_SL_RCP60\ocean_his_10.nc';
    str1='RCP 6.0 Sea Level';
elseif scenario == 12
	his2='D:\ROMS\output\Shiraho_reef\OAv12_pCO2_RCP60\ocean_his_10.nc';
    str1='RCP 6.0 pCO2';
elseif scenario == 13
	his2='D:\ROMS\output\Shiraho_reef\OAv12_pCO2_SL_RCP60\ocean_his_10.nc';
    str1='RCP 6.0 Sea Level + pCO2';
end

% starting_date=datenum(2009,8,25,0,0,0); % for Shiraho
starting_date=datenum(2010,8,20,0,0,0); % for Shiraho
%starting_date=datenum(2014,4,1,0,0,0);

Nz=8; % for Shiraho
%Nz=15; %30-1
%Nz=30; %30-1

%LOCAL_TIME='(UTC)';
%LOCAL_TIME='(JST)';
%LOCAL_TIME='(UTC+9)';
LOCAL_TIME='';

wet_dry = 0;  % Dry mask OFF: 0, ON: 1


h          = ncread(grd,'h');
p_coral    = ncread(grd,'p_coral');
%p_seagrass = ncread(grd,'p_seagrass');
%lat_rho    = ncread(grd,'lat_rho');
%lon_rho    = ncread(grd,'lon_rho');
x_rho      = ncread(grd,'x_rho');
y_rho      = ncread(grd,'y_rho');
mask_rho   = ncread(grd,'mask_rho');

[Im,Jm] = size(h);

c(1:Im,1:Jm)=0;
x_rho=(x_rho-min(min(x_rho)))/1000; % m->km
y_rho=(y_rho-min(min(y_rho)))/1000; % m->km

k=0;
i=432;

% xmin=0;   xmax=max(max(x_rho));  ymin=0;   ymax=max(max(y_rho));
xmin=0;   xmax=2.3;  ymin=0;   ymax=max(max(y_rho));

% xsize=Im*2+100; ysize=Jm*2+100;  % for YAEYAM1
% xsize=300; ysize=680; % for SHIRAHO
xsize=250; ysize=540; % for SHIRAHO for Publish
%xsize=500; ysize=650; % for SHIRAHO zoom



close all

if id <100
%time = ncread(his,'ocean_time',[i],[1]);
    time = ncread(his1,'ocean_time');
else
     time = ncread(his1,'time');
end

imax=length(time);

% coral masking
coral_mask = (p_coral==0).*0+(p_coral>0).*1;
coral_mask = coral_mask ./coral_mask;

mask_rho = mask_rho ./mask_rho;

if id == 1
    tmp = ncread(his1,'temp',[1 1 Nz i],[Inf Inf 1 1]);
    str2='temp';
elseif id == 12
    tmp =  ncread(his1,'coral1_Pg',[1 1 i],[Inf Inf Inf]);
    str2='Pg';
elseif id == 13
    tmp = ncread(his1,'coral1_Pn',[1 1 i],[Inf Inf Inf]);
    str2='Pn';
elseif id == 14
    tmp = ncread(his1,'coral1_R',[1 1 i],[Inf Inf Inf]);
    str2='R';
elseif id == 15
    tmp = ncread(his1,'coral1_G',[1 1 i],[Inf Inf Inf]);
    str2='G';
elseif id == 16
    tmp = ncread(his1,'coral1_orgC',[1 1 i],[Inf Inf Inf]);
    str2='OrgC';
elseif id == 17
    tmp = ncread(his1,'coral1_d13Ctissue',[1 1 i],[Inf Inf Inf]);
    str2='d13C';
elseif id == 18
    tmp = ncread(his1,'coral_densZoox',[1 1 i],[Inf Inf Inf]);
    str2='Zoox';
elseif id == 20
    tmp = ncread(his1,'coral_growth',[1 1 i],[Inf Inf Inf]);
    str2='growth';
elseif id == 21
    tmp = ncread(his1,'coral_mort',[1 1 i],[Inf Inf Inf]);
    str2='mort';
end
%    tmp = ncread(his,'zeta',[i,0 0],[1,Jm,Im]);
%    tmp = ncread(his,'Dwave',[i,0 0],[1,Jm,Im]); 
%    tmp = ncread(his,'TI13C',[i,7,0 0],[1,1,Jm,Im]);

%depth =squeeze(zeta(i,:,:))+h;
%depth =zeta+h;
%date=datenum(2009,8,25,0,0,0)+time/24/60/60;
if wet_dry == 1
    wetdry_mask_rho = ncread(his,'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
    wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
    tmp = tmp .* wetdry_mask_rho;
end

tmp = mean(tmp,3);
tmp1 = tmp .*coral_mask;
tmp = tmp1*1.0e-3*60*60*24;

% My color map
load('MyColormaps')

if id <100
    date=starting_date+time(i+1)/24/60/60;
else
    date=starting_date+time(i+1);
end

if id == 1
    tmp = ncread(his2,'temp',[1 1 Nz i],[Inf Inf 1 1]);
elseif id == 12
    tmp =  ncread(his2,'coral1_Pg',[1 1 i],[Inf Inf Inf]);
elseif id == 13
    tmp = ncread(his2,'coral1_Pn',[1 1 i],[Inf Inf Inf]);
elseif id == 14
    tmp = ncread(his2,'coral1_R',[1 1 i],[Inf Inf Inf]);
elseif id == 15
    tmp = ncread(his2,'coral1_G',[1 1 i],[Inf Inf Inf]);
elseif id == 16
    tmp = ncread(his2,'coral1_orgC',[1 1 i],[Inf Inf Inf]);
elseif id == 17
    tmp = ncread(his2,'coral1_d13Ctissue',[1 1 i],[Inf Inf Inf]);
elseif id == 18
    tmp = ncread(his2,'coral_densZoox',[1 1 i],[Inf Inf Inf]);
elseif id == 20
    tmp = ncread(his2,'coral_growth',[1 1 i],[Inf Inf Inf]);
elseif id == 21
    tmp = ncread(his2,'coral_mort',[1 1 i],[Inf Inf Inf]);
end
%    tmp = ncread(his,'zeta',[i,0 0],[1,Jm,Im]);
%    tmp = ncread(his,'Dwave',[i,0 0],[1,Jm,Im]); 
%    tmp = ncread(his,'TI13C',[i,7,0 0],[1,1,Jm,Im]);

%depth =squeeze(zeta(i,:,:))+h;
%depth =zeta+h;
%date=datenum(2009,8,25,0,0,0)+time/24/60/60;
if wet_dry == 1
    wetdry_mask_rho = ncread(his,'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
    wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
    tmp = tmp .* wetdry_mask_rho;
end

% ���ρA�W���΍����̌v�Z
tmp3=tmp;
for i=1:size(tmp,3)
    tmp3(:,:,i)=tmp3(:,:,i) .*coral_mask;
end

Gave=mean(reshape(tmp3,[], 1),'omitnan')
Gsd=std(reshape(tmp3,[], 1),'omitnan')

tmp = mean(tmp,3);
tmp2=tmp .*coral_mask;


if id <100
    date=starting_date+time(i+1)/24/60/60;
else
    date=starting_date+time(i+1);
end
date_str=strcat(datestr(date,31),'  ',LOCAL_TIME)

date_str=str1;


tmp = tmp2*1.0e-3*60*60*24;

if id == 1
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Temperature (^oC)',28,34,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 12
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Ave. Pg (umol cm^-^2 d^-^1)',15, 25,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 13
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Ave. Pn (umol cm^-^2 d^-^1)', -1, 1, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 14
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Ave. R (umol cm^-^2 d^-^1)', 20, 25, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 15
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Ave. G (umol cm^-^2 d^-^1)', 3.3, 5.7, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 16
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral organic C (umol cm^-^2)', 0, 20, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 17
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral d^1^3C_o_r_g_C (permil VPDB)', -20, -16, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 19
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral zoox. density (cell cm^-^2)', 0, 1200000, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 20
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral growth rate (s^-^1)', 0, 0.000000012, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 21
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral mortality (s^-^1)', 0, 0.00000002, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
end
drawnow
hgexport(figure(1), strcat('output/figs_png\Ave',str2,'_',str1,'.png'),hgexport('factorystyle'),'Format','png');
hgexport(figure(1), strcat('output/figs_png\Ave',str2,'_',str1,'.eps'),hgexport('factorystyle'),'Format','eps');


tmp=tmp2./tmp1*100;
ppc=mean(reshape(tmp2,[], 1),'omitnan')/mean(reshape(tmp1,[], 1),'omitnan')*100

if id == 1
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Temperature (^oC)',28,34,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 12
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Pg (% of present rate)',90, 105,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 13
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Pn (% of present rate)', 70, 115, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 14
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'R (% of present rate)', 90, 105, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 15
%    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Ave. Coral G (nmol cm^-^2 s^-^1)', 0.04, 0.09, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'G (% of present rate)', 60, 124.5, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 16
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral organic C (umol cm^-^2)', 0, 20, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 17
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral d^1^3C_o_r_g_C (permil VPDB)', -20, -16, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 19
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral zoox. density (cell cm^-^2)', 0, 1200000, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 20
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral growth rate (s^-^1)', 0, 0.000000012, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 21
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral mortality (s^-^1)', 0, 0.00000002, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
end
drawnow
hgexport(figure(2), strcat('output/figs_png\',str2,'ppc','_',str1,'.png'),hgexport('factorystyle'),'Format','png');
hgexport(figure(2), strcat('output/figs_png\',str2,'ppc','_',str1,'.eps'),hgexport('factorystyle'),'Format','eps');


tmp=tmp2-tmp1;
delta=mean(reshape(tmp2,[], 1),'omitnan')-mean(reshape(tmp1,[], 1),'omitnan')

if id == 1
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Temperature (^oC)',28,34,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 12
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'\DeltaPg (umol cm^-^2 d^-^1)',-0.025, 0.015,jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 13
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'\DeltaPn (umol cm^-^2 d^-^1)', -0.005, 0.003, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 14
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'\DeltaR (umol cm^-^2 d^-^1)', -0.025, 0.015, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 15
%    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Ave. Coral G (nmol cm^-^2 s^-^1)', 0.04, 0.09, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'\DeltaG (umol cm^-^2 d^-^1)', -0.025, 0.015, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 16
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral organic C (umol cm^-^2)', 0, 20, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 17
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral d^1^3C_o_r_g_C (permil VPDB)', -20, -16, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 19
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral zoox. density (cell cm^-^2)', 0, 1200000, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 20
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral growth rate (s^-^1)', 0, 0.000000012, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 21
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral mortality (s^-^1)', 0, 0.00000002, jet(128),xsize,ysize,xmin,xmax,ymin,ymax);
end

drawnow
hgexport(figure(3), strcat('output/figs_png\Delta',str2,'_',str1,'.png'),hgexport('factorystyle'),'Format','png');
hgexport(figure(3), strcat('output/figs_png\Delta',str2,'_',str1,'.eps'),hgexport('factorystyle'),'Format','eps');




